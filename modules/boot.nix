{pkgs, ...}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
        memtest86.enable = true;
      };
    };

    initrd = {
      nix-store-veritysetup.enable = true;
      systemd = {
        enable = true;
        tpm2.enable = true;
        dmVerity.enable = true;
        dbus.enable = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    crashDump.enable = true;
  };
}