{
  pkgs,
  lib,
  config,
  ...
}:

{

  networking.hostName = "nixdesk";

  imports = [
    # Include the results of the hardware scan.
    ./plex.nix
  ];

  services.printing.enable = false;

  environment.systemPackages = with pkgs; [
      steam
      steam-unwrapped
      steam-run
      filezilla
      lutris
      protonplus
      ntfs3g
      ldmtool
  ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  systemd.services.ldmtool = {
      description = "LDM Tool Auto-Scan and Create";
      wantedBy = [ "multi-user.target" ];
      before = [ "local-fs.target" ];
      script = ''
            /run/current-system/sw/bin/ldmtool scan /dev/sda
            /run/current-system/sw/bin/ldmtool create all
      '';
  };

  fileSystems."/mnt/hdd" = {
      device = "/dev/disk/by-uuid/9846E04246E022AC";
      fsType = "ntfs-3g";
      options = [ "uid=1000" "gid=1000" "rw" "user" "exec" "umask=000" "noatime" "nofail" ];
  };

  fileSystems."/mnt/m2" = {
      device = "/dev/disk/by-uuid/9C52B88A52B86AA2";
      fsType = "ntfs-3g";
      options = [ "uid=1000" "gid=1000" "rw" "user" "exec" "umask=000" "noatime" "nofail" ];
  };


  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    # nixpkgs.config.allowUnfreePredicate =
    #   pkg:
    #   builtins.elem (lib.getName pkg) [
    #   ];
  };
  #
}
