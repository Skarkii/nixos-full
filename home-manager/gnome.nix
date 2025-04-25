{ pkgs, ... }:

{
  # Enable dconf for GNOME settings
  dconf.enable = true;

  # Configure GNOME Shell settings
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        clipboard-indicator.extensionUuid

        # applications-menu.extensionUuid # cant get these to work?!
        # status-icons.extensionUuid
        # places-status-indicator.extensionUuid

        # Outdated:
        # sound-output-device-chooser.extensionUuid
        # quick-settings-tweaker.extensionUuid
      ];
      favorite-apps = [
            "dev.zed.Zed.desktop"
            "org.gnome.Console.desktop"
            "mullvad-browser.desktop"
            "discord.desktop"
            "spotify.desktop"
            "org.gnome.Nautilus.desktop"
            # Add more .desktop files in your desired order
        ];
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      color-scheme = "prefer-dark";
      # gtk-theme = "Nordic";
      # icon-theme = "Adwaita";
      # cursor-theme = "Adwaita";
      # font-name = "Cantarell 11";
    };
  };
}
