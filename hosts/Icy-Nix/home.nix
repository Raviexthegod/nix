{ pkgs, lib, ... }:
{

  home.username = "raviex";
  home.homeDirectory = "/home/raviex";
  home.shell.enableNushellIntegraton = true;
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

    kitty = {
      enable = true;
      enableGitIntegration = true;
      font.name = "MesloLGS NF";
      font.package = pkgs.meslo-lgs-nf;
      shellIntegration.enableNushellIntegraton = true;
      themeFile = "GitHub_Dark_High_Contrast";
    };

    nix-index = {
      enable = true;
      enableNushellIntegraton = true;
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
      enableNushellIntegraton = true;
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
      plugins = with pkgs.nushellPlugins; [units dbus gstat highlight query];
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
    zsh = {
      enable = true;
      completionInit = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      initContent = ''source ~/.p10k.zsh'';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "eza"
          "git"
          "sudo"
          "vscode"
          "node"
          "fzf"
          "systemd"
          "aliases"
          "zoxide"
        ];
      };
      shellAliases = {
        ls = "eza -lah --git";
        cat = "bat";
        cd = "z";
        fr = "nh os switch /home/raviex/.config/nixos --hostname Icy-Nix --update";
        man = "batman";
        grep = "batgrep";
      };
    };
  };

  home.stateVersion = "25.11";

}
