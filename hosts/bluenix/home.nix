{ pkgs, lib, ... }:
{

  home.username = "raviex";
  home.homeDirectory = "/home/raviex";
  home.shell.enableZshIntegration = true;
  programs.git = {
    enable = true;
    userEmail = "xaviercoffey0@gmail.com";
    userName = "Raviexthegod";
  };

  home.packages = [
    pkgs.zsh
    pkgs.zsh-autocomplete
    pkgs.eza
    pkgs.bat
    pkgs.zoxide
    pkgs.zsh-powerlevel10k
    pkgs.nerd-fonts.meslo-lg
    pkgs.zsh-syntax-highlighting
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
      shellIntegration.enableZshIntegration = true;
      themeFile = "GitHub_Dark_High_Contrast";
    };

    mangohud = {
      enable = true;
      enableSessionWide = false;
    };

    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    nix-your-shell = {
      enable = true;
      enableZshIntegration = true;
    };

    pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
        fr = "nh os switch /home/raviex/.config/nixos --hostname bluenix --update";
        man = "batman";
        grep = "batgrep";
      };
    };
  };

  home.stateVersion = "25.11";

}
