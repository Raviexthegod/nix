# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./Steam.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Define flake automations
  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.autoUpgrade = {
    allowReboot = true;
    enable = true;
    dates = "daily";
    flake = "github:Raviexthegod/nix";
    operation = "switch";
    persistent = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
    upgrade = true;
  };

  # Define cpu freqency governor
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  # Define what documentation is enabled.
  documentation.dev.enable = true;
  documentation.nixos.includeAllModules = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.nix-store-veritysetup.enable = true;
  boot.initrd.systemd.dmVerity.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Icy-Nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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
  # You can disable this if you're only using the Wayland session.
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
    flake = "/home/raviex/.dotfiles";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.cups-pdf.enable = true;
  services.printing.openFirewall = true;
  services.printing.startWhenNeeded = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.appimage.binfmt = true;
  programs.appimage.enable = true;
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  # Virtualization
  virtualisation.waydroid.enable = true;

  # Enable UEFI support for Qemu
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  # Enable programs and services
  services.flatpak.enable = true;
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  programs.partition-manager.enable = true;
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
    ];
  }; 
  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;
  programs.streamcontroller.enable = true;

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
    flatpak
    kdePackages.wallpaper-engine-plugin
    kdePackages.kdeplasma-addons
    atlauncher
    prismlauncher
    lutris
    qemu
    quickemu
    swtpm
    heroic
    vulkan-tools
    bs-manager
    protonplus
    nexusmods-app-unfree
    neofetch
    zip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
