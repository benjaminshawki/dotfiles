#!/bin/bash

# Claude Code VM Setup Script
# Sets up a QEMU/KVM virtual machine for running Claude Code safely

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
VM_NAME="claude-code-vm"
VM_DIR="$HOME/VMs/$VM_NAME"
DISK_SIZE="20G"
RAM_SIZE="4096"
CPU_COUNT="2"
ISO_URL="https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img"
ISO_NAME="ubuntu-22.04-minimal.img"
BRIDGE_NAME="virbr0"

# Functions
print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=()
    
    # Check for QEMU
    if ! command -v qemu-system-x86_64 &> /dev/null; then
        missing_deps+=("qemu")
    fi
    
    # Check for KVM support
    if ! [ -e /dev/kvm ]; then
        print_warning "KVM not available. VM will run without hardware acceleration."
    fi
    
    # Check for bridge-utils
    if ! command -v brctl &> /dev/null; then
        missing_deps+=("bridge-utils")
    fi
    
    # Check for cloud-init tools
    if ! command -v cloud-localds &> /dev/null; then
        missing_deps+=("cloud-utils")
    fi
    
    # Check for wget
    if ! command -v wget &> /dev/null; then
        missing_deps+=("wget")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        echo "Install with: sudo pacman -S ${missing_deps[*]}"
        exit 1
    fi
    
    print_success "All dependencies are installed"
}

setup_directories() {
    print_status "Setting up VM directory..."
    mkdir -p "$VM_DIR"
    cd "$VM_DIR"
    print_success "VM directory created at $VM_DIR"
}

download_iso() {
    print_status "Downloading Ubuntu Server minimal image..."
    
    if [ -f "$ISO_NAME" ]; then
        print_warning "ISO already exists. Skipping download."
    else
        wget -O "$ISO_NAME" "$ISO_URL" || {
            print_error "Failed to download ISO"
            exit 1
        }
        print_success "ISO downloaded successfully"
    fi
}

create_cloud_init() {
    print_status "Creating cloud-init configuration..."
    
    # Create meta-data
    cat > meta-data <<EOF
instance-id: claude-code-vm
local-hostname: claude-code-vm
EOF
    
    # Create user-data with Claude Code installation
    cat > user-data <<EOF
#cloud-config
users:
  - name: claude
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat ~/.ssh/id_rsa.pub 2>/dev/null || echo "no-ssh-key")
    
package_update: true
package_upgrade: true

packages:
  - curl
  - git
  - build-essential
  - qemu-guest-agent
  - spice-vdagent
  - xclip

runcmd:
  # Install Node.js
  - curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  - apt-get install -y nodejs
  
  # Install Claude Code
  - npm install -g @anthropic-ai/claude-cli
  
  # Create Claude Code launcher script
  - |
    cat > /home/claude/run-claude.sh << 'SCRIPT'
    #!/bin/bash
    echo "Starting Claude Code with --dangerously-skip-permissions flag"
    echo "WARNING: This flag bypasses permission checks. Use with caution!"
    echo ""
    claude code --dangerously-skip-permissions "\$@"
    SCRIPT
  - chmod +x /home/claude/run-claude.sh
  - chown claude:claude /home/claude/run-claude.sh
  
  # Enable clipboard sharing
  - systemctl enable spice-vdagentd
  - systemctl start spice-vdagentd

final_message: |
  Claude Code VM is ready!
  
  Login: claude (passwordless sudo)
  
  To run Claude Code:
  ./run-claude.sh
  
  Or directly:
  claude code --dangerously-skip-permissions
EOF
    
    # Create seed ISO
    cloud-localds seed.iso user-data meta-data
    print_success "Cloud-init configuration created"
}

create_disk() {
    print_status "Creating virtual disk..."
    
    if [ -f "disk.qcow2" ]; then
        print_warning "Disk already exists. Skipping creation."
    else
        # Create base disk from cloud image
        qemu-img convert -O qcow2 "$ISO_NAME" base.qcow2
        qemu-img resize base.qcow2 "$DISK_SIZE"
        
        # Create overlay disk
        qemu-img create -f qcow2 -F qcow2 -b base.qcow2 disk.qcow2
        
        print_success "Virtual disk created ($DISK_SIZE)"
    fi
}

setup_network() {
    print_status "Setting up network bridge..."
    
    # Check if bridge exists
    if ! ip link show "$BRIDGE_NAME" &> /dev/null; then
        print_warning "Bridge $BRIDGE_NAME not found. Creating it requires root privileges."
        
        cat > setup-bridge.sh <<'EOF'
#!/bin/bash
# Create network bridge for QEMU
BRIDGE_NAME="virbr0"

# Install libvirt if not present
if ! command -v virsh &> /dev/null; then
    echo "Installing libvirt for network management..."
    sudo pacman -S libvirt iptables-nft dnsmasq
    sudo systemctl enable --now libvirtd
fi

# Check if default network exists
if ! sudo virsh net-info default &> /dev/null; then
    echo "Creating default network..."
    sudo virsh net-define /usr/share/libvirt/networks/default.xml
    sudo virsh net-start default
    sudo virsh net-autostart default
fi

echo "Network bridge setup complete!"
EOF
        chmod +x setup-bridge.sh
        
        echo "Run ./setup-bridge.sh to set up networking (requires sudo)"
        print_warning "For now, VM will use user-mode networking (slower but works without root)"
    else
        print_success "Network bridge $BRIDGE_NAME is available"
    fi
}

create_launch_script() {
    print_status "Creating VM launch script..."
    
    cat > launch-vm.sh <<'EOF'
#!/bin/bash

VM_NAME="claude-code-vm"
RAM_SIZE="4096"
CPU_COUNT="2"
SPICE_PORT="5900"

# Detect if KVM is available
KVM_OPTS=""
if [ -e /dev/kvm ]; then
    KVM_OPTS="-enable-kvm"
    echo "KVM acceleration enabled"
else
    echo "Warning: KVM not available, VM will run slowly"
fi

# Detect network mode
NET_OPTS="-netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0"
if ip link show virbr0 &> /dev/null 2>&1; then
    echo "Using bridge networking"
    NET_OPTS="-netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0"
fi

echo "Starting Claude Code VM..."
echo "----------------------------------------"
echo "To connect via SSH: ssh -p 2222 claude@localhost"
echo "To use clipboard sharing: Connect with SPICE client to localhost:$SPICE_PORT"
echo "----------------------------------------"

qemu-system-x86_64 \
    $KVM_OPTS \
    -name "$VM_NAME" \
    -m "$RAM_SIZE" \
    -smp "$CPU_COUNT" \
    -drive file=disk.qcow2,if=virtio,format=qcow2 \
    -drive file=seed.iso,if=virtio,format=raw \
    $NET_OPTS \
    -vga qxl \
    -spice port=$SPICE_PORT,addr=127.0.0.1,disable-ticketing=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -display spice-app \
    -monitor stdio
EOF
    
    chmod +x launch-vm.sh
    print_success "Launch script created"
}

create_connect_script() {
    print_status "Creating connection helper script..."
    
    cat > connect-vm.sh <<'EOF'
#!/bin/bash

echo "Claude Code VM Connection Options:"
echo "=================================="
echo ""
echo "1. SSH Connection:"
echo "   ssh -p 2222 claude@localhost"
echo ""
echo "2. SPICE Console (with clipboard sharing):"
echo "   remote-viewer spice://localhost:5900"
echo ""
echo "3. Install SPICE client if needed:"
echo "   sudo pacman -S virt-viewer"
echo ""
echo "4. To use Claude Code in the VM:"
echo "   ./run-claude.sh"
echo "   or"
echo "   claude code --dangerously-skip-permissions"
echo ""
echo "=================================="

# Offer to connect
read -p "Connect via SSH now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ssh -p 2222 claude@localhost
fi
EOF
    
    chmod +x connect-vm.sh
    print_success "Connection script created"
}

create_readme() {
    print_status "Creating README..."
    
    cat > README.md <<'EOF'
# Claude Code VM

This VM provides a safe environment for running Claude Code with the `--dangerously-skip-permissions` flag.

## Quick Start

1. **Start the VM:**
   ```bash
   ./launch-vm.sh
   ```

2. **Connect to the VM:**
   ```bash
   ./connect-vm.sh
   ```

## VM Details

- **OS:** Ubuntu 22.04 Minimal
- **RAM:** 4GB
- **Disk:** 20GB
- **User:** claude (passwordless sudo)
- **Claude Code:** Pre-installed with launcher script

## Running Claude Code

Once connected to the VM:

```bash
# Using the launcher script (recommended)
./run-claude.sh

# Or directly
claude code --dangerously-skip-permissions
```

## Features

- **Hardware acceleration:** KVM support when available
- **Clipboard sharing:** Via SPICE protocol
- **Network access:** Internet connectivity for Claude Code
- **SSH access:** Port 2222 on localhost
- **Auto-updates:** Cloud-init handles initial setup

## Clipboard Sharing

For clipboard sharing between host and VM:

1. Install SPICE client: `sudo pacman -S virt-viewer`
2. Connect: `remote-viewer spice://localhost:5900`

## Security Notes

This VM runs Claude Code with `--dangerously-skip-permissions`, which bypasses normal permission checks. The VM provides isolation to mitigate risks.

## Troubleshooting

- **No KVM:** VM will run without acceleration (slower)
- **Network issues:** Check if libvirtd is running
- **Can't connect:** Wait for cloud-init to complete (2-3 minutes on first boot)
EOF
    
    print_success "README created"
}

main() {
    echo -e "${GREEN}Claude Code VM Setup Script${NC}"
    echo "============================"
    echo ""
    
    check_dependencies
    setup_directories
    download_iso
    create_cloud_init
    create_disk
    setup_network
    create_launch_script
    create_connect_script
    create_readme
    
    echo ""
    print_success "VM setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Start the VM: cd $VM_DIR && ./launch-vm.sh"
    echo "2. Wait 2-3 minutes for initial setup"
    echo "3. Connect: ./connect-vm.sh"
    echo ""
    print_warning "First boot will take longer due to package installation"
}

# Run main function
main "$@"