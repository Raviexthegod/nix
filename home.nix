{ pkgs, ... }:
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
    pkgs.mangohud
    pkgs.mangojuice
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-your-shell.enable = true;
  programs.nix-your-shell.enableZshIntegration = true;
  programs.pay-respects.enable = true;
  programs.pay-respects.enableZshIntegration = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zsh = {
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
        "systemadmin"
        "systemd"
        "aliases"
      ];
    };
    shellAliases = {
      ls = "eza -lah";
      cat = "bat";
      cd = "z";
      fr = "nh os switch /home/raviex/.dotfiles --hostname Icy-Nix --update";
      man = "batman";
      grep = "batgrep";
    };
  };

  home.stateVersion = "25.11";

}
