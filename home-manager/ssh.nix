{ ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "rpi" = {
        hostname = "192.168.1.223";
        user = "lucas";
        port = 22;
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/git";

      };
    };
  };
}
