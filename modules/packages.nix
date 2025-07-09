{pkgs, ...}: {

  services = {

    # Enable Flatpak
    flatpak.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    printing.cups-pdf.enable = true;
    printing.openFirewall = true;
    printing.startWhenNeeded = true;
  };


}