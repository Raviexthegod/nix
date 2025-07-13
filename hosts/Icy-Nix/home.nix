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

    kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_opacity = "0.5";
      background_blur = 5;
      symbol_map = let
        mappings = [
          "U+23FB-U+23FE"
          "U+2B58"
          "U+E200-U+E2A9"
          "U+E0A0-U+E0A3"
          "U+E0B0-U+E0BF"
          "U+E0C0-U+E0C8"
          "U+E0CC-U+E0CF"
          "U+E0D0-U+E0D2"
          "U+E0D4"
          "U+E700-U+E7C5"
          "U+F000-U+F2E0"
          "U+2665"
          "U+26A1"
          "U+F400-U+F4A8"
          "U+F67C"
          "U+E000-U+E00A"
          "U+F300-U+F313"
          "U+E5FA-U+E62B"
        ];
      in
        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
        };
    };

    mangohud = {
      enable = true;
      enableSessionWide = true;
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
        fr = "nh os switch /home/raviex/.dotfiles --hostname Icy-Nix --update";
        man = "batman";
        grep = "batgrep";
      };
    };
  };

  home.stateVersion = "25.11";

}
