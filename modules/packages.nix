{pkgs, ...}: {

  services = {

    # Enable Flatpak
    flatpak.enable = true;

    # Printing
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    printing = {
      enable = true;
      cups-pdf.enable = true;
      openFirewall = true;
      startWhenNeeded = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
    };
/*     samba = {
      enable = true;
      package = pkgs.sambaFull;
      openFirewall = true;
      settings = {
        global = {
          "load printers" = "yes";
          "printing" = "cups";
          "printcap name" = "cups";
        };
        "printers" = {
          "comment" = "All Printers";
          "path" = "/var/spool/samba";
          "public" = "yes";
          "browseable" = "yes";
          # to allow user 'guest account' to print.
          "guest ok" = "yes";
          "writable" = "no";
          "printable" = "yes";
          "create mode" = 0700;
        };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    }; */
  };

/*   systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ]; */


}