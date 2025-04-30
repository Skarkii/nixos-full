{ ... }:

{
  # Enable and configure LibreWolf
  #"ui.systemUsesDarkTheme" = 1;
  programs.librewolf = {
    enable = false;
    profiles = {
      profile = {
        settings = {
          "privacy.trackingprotection.enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          # "network.cookie.cookieBehavior" = 1;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.region" = "US";
          "general.smoothScroll" = true;
          "ui.systemUsesDarkTheme" = 1;

          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
        };
      };
    };
  };
}
