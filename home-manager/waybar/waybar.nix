{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./style.js;
    settings = {
      mainBar = builtins.fromJSON (builtins.readFile ./config.jsonc);
    };
  };
}
