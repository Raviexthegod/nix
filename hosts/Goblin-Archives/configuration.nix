{pkgs, ...}: {

  imports = [
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/boot.nix
    ../../modules/fonts.nix
    ../../modules/network.nix
    ../../modules/nix.nix
    ../../modules/packages.nix
    ../../modules/power.nix
  ];

  networking.hostName = "Goblin-Archives";

  environment.systemPackages = with pkgs; [
    atuin

  ];

  users.users.goblin = {
    description = "Primary Administrative user";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = "true";
    isSystemUser = "false";
    shell = pkgs.zsh;
  };

  programs = {
    nh = {
      enable = true;
      flake = "github:Raviexthegod/nix#Goblin-Archives";
    };
  };

  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "localhost";
      config.adminuser = "goblin";
      config.adminpassFile = "/etc/nextcloud-admin-password";
    };

  };

  system.stateVersion = "25.05";
}