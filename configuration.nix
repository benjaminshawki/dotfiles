# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader = {
  #   systemd-boot.enable = true;
  #   efi.canTouchEfiVariables = true;
  # };

  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      device = "nodev"; # for UEFI systems, use "nodev" to prevent installing to a specific device
      efiSupport = true;
      useOSProber = true; # enables searching for other operating systems
    };
    systemd-boot.enable = false; # disable systemd-boot
    efi.canTouchEfiVariables = true;
  };

  # Zsh
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benjamin = {
    isNormalUser = true;
    description = "Benjamin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    DOTFILES = "/home/benjamin/dotfiles";
    XDG_CONFIG_HOME = "/home/benjamin/.config";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

#  programs.hyprland = {
#    enable=true;
#    xwayland.enable = true;
#  };

  programs.sway = {
    enable = true;
  };

  hardware = {
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    openssh
    git
    man
    man-pages
    wget
    curl
    networkmanager
    fzf
    udiskie
    ripgrep
    htop
    ranger
    tmux
    tmuxp
    libnotify
    pipewire
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    zoxide
    alacritty
    zathura

    # syncthing # TODO: Check this out? sync desktop / phone data?
    # keybase # TODO: Check this out? private drive, git, chat.

    #Wayland
    wayland
    waybar
    grim slurp
    mako
    wdisplays
    
    # Programming languages stuff
    libgcc


    glib
    grim
    slurp
    wl-clipboard
    gnupg

    # TODO Add to home manager
    google-chrome

    # TODO: check if these or variants are needed
    #rsync
    #scrot
    xcape


  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # openssh
  services.openssh = {
  	enable = true;
	settings = {
		PermitRootLogin = "no";
		PasswordAuthentication = true;
	};
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # TODO: Add to home-manager
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    #polkitPolicyOwners = [ "yourUsernameHere" ];
  };

  # sevices.pcscd.enable = true;

  # System76
  hardware.system76.enableAll = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
