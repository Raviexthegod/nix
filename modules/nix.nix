{inputs, ...}: {

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nixpkgs = {
    overlays = [
      inputs.millennium.overlays.default
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "ventoy-qt5-1.1.05"
      ];
    };
  };

  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  system.autoUpgrade = {
    allowReboot = true;
    enable = true;
    flake = "github:Raviexthegod/nix";
    operation = "switch";
    persistent = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
    upgrade = true;
  };

}