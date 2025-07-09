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
        enableTpm2 = true;
        dmVerity.enable = true;
        
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    crashDump.enable = true;
  };
}