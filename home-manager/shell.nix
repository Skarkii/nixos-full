{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./neovim.nix
  ];

  # Things used within the shell
  home.packages = with pkgs; [
    neofetch
    wl-clipboard
  ];

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.8;
    };
  };
}
