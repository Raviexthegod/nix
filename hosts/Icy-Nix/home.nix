{ pkgs, lib, ... }:
{

  home.username = "raviex";
  home.homeDirectory = "/home/raviex";
  programs.git = {
    enable = true;
    userEmail = "xaviercoffey0@gmail.com";
    userName = "Raviexthegod";
  };

  home.packages = [
    pkgs.eza
    pkgs.bat
    pkgs.zoxide
    pkgs.nerd-fonts.fira-code
    pkgs.hstr
    pkgs.pay-respects
    pkgs.git
    pkgs.fzf
    pkgs.bat-extras.batgrep
    pkgs.bat-extras.batman
    pkgs.ripgrep
    pkgs.mangojuice
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs = {

    nix-index = {
      enable = true;
    };

    nix-your-shell = {
      enable = true;
      enableNushellIntegration = true;
    };

    pay-respects = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };


    nushell = {
      enable = true;
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell ... $spans | from json
        }
        $env.config = {
          show_banner: false,
          completions: {
          case_sensetive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
            }
          }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/raviex/.apps
        append /usr/bin/env
        )
      '';
      shellAliases = {
        ls = "eza -lah --git";
        cat = "bat";
        cd = "z";
        fr = "nh os switch /home/raviex/.config/nixos --hostname Icy-Nix --update";
        man = "batman";
        grep = "batgrep";
      };
      plugins = with pkgs.nushellPlugins; [units gstat highlight query];
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = lib.importTOML ./starship.toml;
    };

  };

  home.stateVersion = "25.11";

}
