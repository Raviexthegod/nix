{pkgs, lib, ...}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      
      grub = {
        enable = lib.mkForce true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
        memtest86.enable = true;
        copyKernels = true;
        extraEntries = ''
          menuentry "Reboot to Firmware Setup" {
            fwsetup
          }
        '';
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