{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
    package = pkgs.millennium;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
    ];
    protontricks.enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  hardware.xone.enable = true;
  services.getty.autologinUser = "raviex";
  environment.loginShellInit = ''
    [[ "(tty)" = "/dev/tty1" ]] && ./gs.sh
  '';
}
