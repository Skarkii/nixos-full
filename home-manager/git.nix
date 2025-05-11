{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Skarkii";
    userEmail = "lucas@kuja-halkola.com";
    ignores = [
      "*~"
      "*.swp"
    ];
    aliases = {
      # ci = "commit";
    };
    extraConfig = {
      # init.defaultBranch = "master";
      # pull.rebase = "false";
    };
  };
}
