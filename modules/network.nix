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
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
        powersave = true;
      };
    };
  };
}
