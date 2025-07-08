{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
    package = pkgs.steam-millennium;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
    ];
    extraPackages = with pkgs; [
      gamescope
      mangohud
      mangojuice
    ];
    protontricks.enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
}
