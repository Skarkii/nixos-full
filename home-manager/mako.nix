{ ... }:
{
  services.mako = {
    enable = true;

    # Suppress Spotify notifications
    extraConfig = ''
      [app-name=Spotify]
      invisible=1
    '';

    maxVisible = 5;
    maxHistory = 5;
    sort = "-time";

    layer = "top";
    anchor = "top-right";

    font = "monospace 10";
    backgroundColor = "#285577FF";
    textColor = "#FFFFFFFF";
    width = 300;
    height = 100;
    margin = "10";
    padding = "5";
    borderSize = 1;
    borderColor = "#4C7899FF";
    borderRadius = 0;
    progressColor = "over #5588AAFF";
    icons = true;
    maxIconSize = 64;

    markup = true;
    actions = true;
    format = "<b>%s</b>\\n%b";
    defaultTimeout = 0;
    ignoreTimeout = false;
  };
}
