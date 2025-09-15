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

  home.packages = with pkgs; [
    zsh
    zsh-autocomplete
    zsh-forgit
    zsh-fzf-history-search
    zsh-fzf-tab
    zsh-nix-shell
    zsh-abbr
    zsh-
    eza
    bat
    zoxide
    zsh-powerlevel10k
    nerd-fonts.meslo-lg
    zsh-syntax-highlighting
    hstr
    pay-respects
    git
    fzf
    bat-extras.batgrep
    bat-extras.batman
    ripgrep
    mangojuice
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
