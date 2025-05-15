{ pkgs, ... }:
{
  imports = [
    ./editor.nix
    ./kitty.nix
    ./ssh.nix
    ./browser.nix
    ./hyprland.nix
    ./git.nix
    ./zsh.nix
    ./neovim.nix
    ./waybar/waybar.nix
    ./mako.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    # Nix editor utilties
    nixd
    nixfmt-rfc-style
    nix-index

    # lsp&formatters
    nil
    black
    gopls
    clang-tools
    prettierd

    # General
    discord
    spotify
    plex-desktop
    neofetch
    wl-clipboard
    waybar-mpris

    kdePackages.dolphin # $fileManager

    # Controls for waybar and keyboard shortcuts
    playerctl
    brightnessctl

    # Print screen
    hyprshot
    btop
    dig # nslookup
  ];

  home.username = "skarkii";
  home.homeDirectory = "/home/skarkii";

  nixpkgs.config.allowUnfree = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
    };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
  # programs.home-manager.path = "$HOME/.nix-profile/bin/home-manager";
}
