#!/bin/bash

# Simple Claude Code VM Setup Script
# Uses Ubuntu Server ISO for easier setup

set -euo pipefail

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
VM_NAME="claude-code-vm"
VM_DIR="$HOME/VMs/$VM_NAME"
DISK_SIZE="20G"
RAM_SIZE="4096"
CPU_COUNT="2"

# Ubuntu Server 22.04.3 direct download
ISO_URL="https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso"
ISO_NAME="ubuntu-22.04.3-server.iso"

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

check_deps() {
    print_status "Checking dependencies..."
    
    local missing=()
    command -v qemu-system-x86_64 &>/dev/null || missing+=("qemu")
    command -v wget &>/dev/null || missing+=("wget")
    
    if [ ${#missing[@]} -ne 0 ]; then
        print_error "Missing: ${missing[*]}"
        echo "Install with: sudo pacman -S ${missing[*]}"
        exit 1
    fi
    
    print_success "Dependencies OK"
}

setup_dir() {
    print_status "Setting up VM directory..."
    mkdir -p "$VM_DIR"
    cd "$VM_DIR"
    print_success "Directory created: $VM_DIR"
}

download_iso() {
    if [ -f "$ISO_NAME" ]; then
        print_status "ISO exists, checking size..."
        local size=$(stat -c%s "$ISO_NAME")
        if [ $size -lt 1000000 ]; then
            print_status "ISO too small, re-downloading..."
            rm -f "$ISO_NAME"
        else
            print_success "ISO already downloaded"
            return
        fi
    fi
    
    print_status "Downloading Ubuntu Server ISO (2GB)..."
    wget -O "$ISO_NAME" "$ISO_URL" || {
        print_error "Download failed"
        exit 1
    }
    print_success "ISO downloaded"
}

create_disk() {
    if [ -f "disk.qcow2" ]; then
        print_status "Disk exists, skipping..."
    else
        print_status "Creating $DISK_SIZE virtual disk..."
        qemu-img create -f qcow2 disk.qcow2 "$DISK_SIZE"
        print_success "Disk created"
    fi
}

create_install_script() {
    print_status "Creating install script..."
    
    cat > install-vm.sh <<'EOF'
#!/bin/bash

echo "Starting Ubuntu Server installation..."
echo "======================================="
echo ""
echo "Installation steps:"
echo "1. Choose 'Ubuntu Server' (not minimal)"
echo "2. Select your language (English recommended)"
echo "3. Update to the new installer if prompted"
echo "4. Configure network (DHCP is fine)"
echo "5. Skip proxy configuration"
echo "6. Use default mirror"
echo "7. Use entire disk, LVM group"
echo "8. Create user: claude (remember password!)"
echo "9. Install OpenSSH server (space to select)"
echo "10. Skip featured snaps"
echo ""
echo "After installation completes:"
echo "- Select 'Reboot Now'"
echo "- Press Enter when prompted to remove media"
echo "- VM will shut down automatically"
echo ""
read -p "Press Enter to start installation..."

qemu-system-x86_64 \
    -enable-kvm \
    -name "claude-code-vm-install" \
    -m 4096 \
    -smp 2 \
    -drive file=disk.qcow2,if=virtio,format=qcow2 \
    -drive file=ubuntu-22.04.3-server.iso,if=virtio,media=cdrom \
    -boot d \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -vga std \
    -monitor stdio

echo ""
echo "Installation complete!"
echo "Run ./launch-vm.sh to start your VM"
EOF
    
    chmod +x install-vm.sh
    print_success "Install script created"
}

create_launch_script() {
    print_status "Creating launch script..."
    
    cat > launch-vm.sh <<'EOF'
#!/bin/bash

# Check for KVM
KVM_OPTS=""
if [ -e /dev/kvm ]; then
    KVM_OPTS="-enable-kvm"
    echo "KVM acceleration enabled"
fi

echo "Starting Claude Code VM..."
echo "=========================="
echo ""
echo "SSH: ssh -p 2222 claude@localhost"
echo "VNC: localhost:5900 (for GUI access)"
echo ""

qemu-system-x86_64 \
    $KVM_OPTS \
    -name "claude-code-vm" \
    -m 4096 \
    -smp 2 \
    -drive file=disk.qcow2,if=virtio,format=qcow2 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0 \
    -vnc :0 \
    -monitor stdio
EOF
    
    chmod +x launch-vm.sh
    print_success "Launch script created"
}

create_setup_claude_script() {
    print_status "Creating Claude setup script..."
    
    cat > setup-claude.sh <<'EOF'
#!/bin/bash

echo "Claude Code Setup Script"
echo "======================="
echo ""
echo "This script will install Claude Code in the VM"
echo ""

# Commands to run inside the VM
cat << 'SETUP' > /tmp/install-claude.sh
#!/bin/bash
set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential git

echo "Installing Claude Code..."
sudo npm install -g @anthropic-ai/claude-cli

echo "Creating launcher script..."
cat > ~/run-claude-dangerous.sh << 'LAUNCHER'
#!/bin/bash
echo "Starting Claude Code with --dangerously-skip-permissions"
echo "WARNING: This bypasses all permission checks!"
echo ""
claude code --dangerously-skip-permissions "$@"
LAUNCHER

chmod +x ~/run-claude-dangerous.sh

echo ""
echo "Setup complete!"
echo ""
echo "To use Claude Code:"
echo "  ./run-claude-dangerous.sh"
echo ""
echo "Or directly:"
echo "  claude code --dangerously-skip-permissions"
SETUP

echo "Copy this script to your VM and run it"
echo ""
echo "Steps:"
echo "1. Start VM: ./launch-vm.sh"
echo "2. SSH in: ssh -p 2222 claude@localhost"
echo "3. Copy and run the setup script"
echo ""
echo "Or run this command after SSH'ing in:"
echo "curl -sSL https://raw.githubusercontent.com/anthropics/claude-code/main/install.sh | bash"

EOF
    
    chmod +x setup-claude.sh
    print_success "Setup script created"
}

create_readme() {
    print_status "Creating README..."
    
    cat > README.md <<'EOF'
# Claude Code VM - Simple Setup

This VM provides a safe environment for running Claude Code with dangerous permissions.

## Quick Start

### 1. Install Ubuntu Server

```bash
./install-vm.sh
```

Follow the installation wizard. Create user 'claude' and install OpenSSH server.

### 2. Start the VM

```bash
./launch-vm.sh
```

### 3. Connect via SSH

```bash
ssh -p 2222 claude@localhost
```

### 4. Install Claude Code

In the VM, run:

```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Claude Code
sudo npm install -g @anthropic-ai/claude-cli

# Create dangerous mode launcher
cat > ~/claude-dangerous.sh << 'EOF'
#!/bin/bash
claude code --dangerously-skip-permissions "$@"
EOF
chmod +x ~/claude-dangerous.sh
```

## Usage

Run Claude Code in dangerous mode:

```bash
./claude-dangerous.sh
```

## Features

- Ubuntu Server 22.04 LTS
- 4GB RAM, 2 CPUs, 20GB disk
- SSH access on port 2222
- VNC access on port 5900
- KVM acceleration (when available)

## Security Note

The `--dangerously-skip-permissions` flag bypasses all permission checks. Only use this in an isolated VM environment.
EOF
    
    print_success "README created"
}

main() {
    echo -e "${GREEN}Claude Code VM Setup (Simple)${NC}"
    echo "============================="
    echo ""
    
    check_deps
    setup_dir
    download_iso
    create_disk
    create_install_script
    create_launch_script
    create_setup_claude_script
    create_readme
    
    echo ""
    print_success "Setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Install Ubuntu: cd $VM_DIR && ./install-vm.sh"
    echo "2. After install: ./launch-vm.sh"
    echo "3. SSH in: ssh -p 2222 claude@localhost"
    echo "4. Run setup: ./setup-claude.sh (see instructions)"
}

main "$@"