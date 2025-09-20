{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/633da642-762d-406c-b0f2-586f8cfc8103";
    fsType = "ext4";
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-partuuid/b019506c-4b81-4ddd-a16b-17530f7f3321";
    fsType = "ext4";
    options = [ "nofail" "rw" ];
  };

  fileSystems."/mnt/misc" = {
    device = "/dev/disk/by-partuuid/2f592c0d-eca8-4cf0-841f-963d0f2c5f17";
    fsType = "ext4";
    options = [ "nofail" "rw" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F6AA-4721";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/e2952089-8168-4c51-98be-03bb8b9de3bb"; }
  ];

  hardware = {
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    amdgpu = {
      initrd.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        supportExperimental.enable = true;
      };
      legacySupport.enable = true;
      opencl.enable = true;
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
