{ pkgs, ... }:
{
  # Enable and configure LibreWolf
  programs.librewolf = {
    enable = true;

    profiles = {
      profile = {
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
          ];
        };

        bookmarks = {
          force = true;
          enable = true;
          settings = [
            {
              name = "wikipedia";
              tags = [ "wiki" ];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
              name = "wikipedia";
              tags = [ "wiki" ];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
          ];
        };

        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.region" = "SE";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;

          "ui.systemUsesDarkTheme" = 1;

          "general.smoothScroll" = true;

          "privacy.trackingprotection.enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          "privacy.sanitize.sanitizeOnShutdown" = false;

          "network.trr.mode" = 3;
          "network.trr.uri" = "https://dns.mullvad.net/dns-query";
          "extensions.autoDisableScopes" = 0;

          # "browser.places.importBookmarksHTML" = false;
          # "network.cookie.cookieBehavior" = 1;
          # user_pref("browser.bookmarks.addedImportButton", true);

          "toolkit.telemetry.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
        };
      };
    };
  };
}
