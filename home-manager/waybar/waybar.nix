{ pkgs, ... }:
{
  # Fonts needed
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./waybar/style.js;
    settings = {
      mainBar = builtins.fromJSON (builtins.readFile ./waybar/config.jsonc);
    };
  };
}
