{ ... }: {
  networking = {
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
