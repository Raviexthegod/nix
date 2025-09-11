# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/boot.nix
    ../../modules/fonts.nix
    ../../modules/network.nix
    ../../modules/nix.nix
    ../../modules/packages.nix
    ../../modules/power.nix
    ../../modules/security.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  # Define what documentation is enabled.
  documentation.dev.enable = true;
  documentation.nixos.includeAllModules = true;

  networking.hostName = "bluenix"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/New_York";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.nh = {
    enable = true;
    flake = "github:Raviexthegod/nix#bluenix";
  };

  # Ser default user shell to ZSH
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raviex = {
    isNormalUser = true;
    isSystemUser = false;
    description = "Xavier Coffey";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "gamemode"
      "kvm"
      "adbusers"
    ];
    shell = pkgs.zsh;
  };

  # Enable appimages
  programs.appimage.binfmt = true;
  programs.appimage.enable = true;

  # Virtualization
  virtualisation.waydroid.enable = true;

  # Enable UEFI support for Qemu
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  # Enable programs and services
  services.fwupd.enable = true;
  services.tor = {
    enable = true;
    client = {
      enable = true;
      dns.enable = true;
    };
    settings.DNSPort = [{
      addr = "127.0.0.1";
      port = 53;
    }];
    
    openFirewall = true;
    torsocks.enable = true;
  };
  services.resolved = {
    enable = true;
    fallbackDns = [ "8.8.8.8" "2001:4860:4860::8844" ];
  };
  networking.nameservers = [ "127.0.0.1" ];
  programs.partition-manager.enable = true;
  programs.adb.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      nss_latest
      nspr
      dbus
      at-spi2-atk
      cups
      libdrm
      glib
      gtk2
      gtk3
      pango
      cairo
      libgbm
      expat
      libxkbcommon
      alsa-lib-with-plugins
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
      xorg_sys_opengl
    
    ];
  }; 
  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;

  # enable QEMU frontend
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "raviex" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [
        (pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd
      ];
    };
  }; 
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark-qt;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vscode
    wget
    brave
    bottles
    rclone
    opentabletdriver
    rclone-ui
    nixfmt-rfc-style
    nix-output-monitor
    nvd
    nixd
    gdrive3
    nixos-generators
    inkscape-with-extensions
    kdePackages.gear.kio-gdrive
    libreoffice
    obsidian
    protonvpn-gui
    proton-pass
    openrgb-with-all-plugins
    kdePackages.kcmutils
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.signond
    kdePackages.signon-kwallet-extension
    kdePackages.kio-admin
    kdePackages.kio-fuse
    vesktop
    vkbasalt-cli
    flatpak
    kdePackages.kdeplasma-addons
    qemu
    quickemu
    swtpm
    vulkan-tools
    protonplus
    neofetch
    zip
    ventoy-full-qt
    sbctl
    tor-browser-bundle-bin
    cryptomator
    ntfs3g
    qgis
    obs-studio
    obs-studio-plugins.obs-vkcapture
    freecad-wayland
    atuin
    dust
    tldr
    kdePackages.plasma-integration
    spotify
    jprofiler
    visualvm
    tmux
    fwupd
    phoronix-test-suite
    openssl
    python314Full
    flex
    bc
    bison
    kdePackages.kde-cli-tools
    kdePackages.qtstyleplugin-kvantum
    kdePackages.sddm-kcm
    kdePackages.ksystemlog
    kdePackages.kcalc
    kdePackages.kcolorscheme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  system.stateVersion = "25.05"; # DO NOT TOUCH

}
