{inputs, ...}: {

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix.optimise = {
    automatic = true;
    dates = "weekly";
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