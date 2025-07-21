{
  config,
  lib,
  modulesPath,
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
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4f53d250-fa33-4430-8c11-2c0b7494d15f";
    fsType = "ext4";
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-partuuid/e13b5cc2-f0b0-45ba-9750-6b764ebd7dac";
    fsType = "ntfs-3g";
    options = [ "nofail" "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117"];
  };

  fileSystems."/mnt/misc" = {
    device = "/dev/disk/by-partuuid/01058ea6-ae64-438f-8591-6d7719bfacee";
    fsType = "ntfs-3g";
    options = [ "nofail" "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FAEC-908D";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/42f1a96a-1f22-426a-9ad3-f96b3cccb285"; }
  ];

  hardware = {
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    ckb-next.enable = true;
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
