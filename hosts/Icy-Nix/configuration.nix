# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/boot.nix
    ../../modules/fonts.nix
    ../../modules/nix.nix
    ../../modules/packages.nix
    ../../modules/power.nix
    ../../modules/security.nix
    ../../modules/Steam.nix
  ];

  # Define what documentation is enabled.
  documentation.dev.enable = true;
  documentation.nixos.includeAllModules = true;

  networking.hostName = "Icy-Nix"; # Define your hostname.

  # Set trusted users
  nix.trustedUsers = [ "root" "raviex" ];

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
  services.xserver.videoDrivers = [ "amdgpu" ];

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
    flake = "github:Raviexthegod/nix#Icy-Nix";
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
      "qemu-libvirtd"
      "libvirtd"
      "gamemode"
      "kvm"
      "adbusers"
      "wireshark"
      "tss"
    ];
    shell = pkgs.zsh;
  };

  # Enable appimages
  programs.appimage.binfmt = true;
  programs.appimage.enable = true;

  # Virtualization

  virtualisation = {

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = { dns_enabled = true; };
    };

    waydroid.enable = true;
  };
  
  # Enable UEFI support for Qemu
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  # Enable programs and services
  services = {
    fwupd.enable = true;
    ollama = {
      enable = true;
      acceleration = "rocm";
      loadModels = ["deepseek-r1:latest"];
    };
  };

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
    xwayland.enable = true;
    git = {
      enable = true;
      config = {pull.rebase = false;};
    };
    partition-manager.enable = true;
    adb.enable = true;
    nix-ld = {
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
        glfw-wayland-minecraft
      ];
    };
    kdeconnect.enable = true;
    zsh.enable = true;
  };
  systemd.packages = with pkgs; [
    lact
  ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  
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
      packages = [pkgs.OVMFFull.fd];
    };
  };
  services.spice-vdagentd.enable = true;


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vscode
    wget
    brave
    bottles
    nixfmt-rfc-style
    nix-output-monitor
    nvd
    nixd
    nixos-generators
    libreoffice
    obsidian
    openrgb-with-all-plugins
    vesktop
    vkbasalt-cli
    nix-init
    nix-janitor
    nix-health
    nix-inspect
    flatpak
    kdePackages.kdeplasma-addons
    atlauncher
    (prismlauncher.override {
      additionalPrograms = [ffmpeg];
      additionalLibs = [libdecor];
    })
    lutris
    qemu
    lact
    quickemu
    swtpm
    heroic
    unixtools.net-tools
    unixtools.netstat
    vulkan-tools
    bs-manager
    protonplus
    nexusmods-app-unfree
    neofetch
    zip
    ventoy-full-qt
    sbctl
    tor-browser-bundle-bin
    ente-auth
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
    flex
    bc
    distrobox
    usbutils
    virt-viewer
    spice-gtk
    spice
    spice-protocol
    win-virtio
    smartmontools
    udisks
    btrfs-assistant
    btrfs-progs
    win-spice
    adwaita-icon-theme
    bison
    dive
    podman-tui
    podman-desktop
    docker-compose
    dnsmasq
    kdePackages.kde-cli-tools
    kdePackages.qtstyleplugin-kvantum
    kdePackages.sddm-kcm
    kdePackages.ksystemlog
    kdePackages.kcalc
    kdePackages.kcolorscheme
    kdePackages.filelight
    kdePackages.dolphin-plugins
    kdotool
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
