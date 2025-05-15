{ config, pkgs, ... }:

let
  mediaPath = [
    "/mnt/hdd/Shows/Series"
    "/mnt/hdd/Shows/Movies"
  ];
in
{
  users.groups.plex = { };

  users.users.plex = {
    isSystemUser = true;
    group = "plex";
    description = "User for Plex";
    createHome = false;
    shell = "${pkgs.shadow}/sbin/nologin";
  };

  # Set permissions for the folders
  systemd.tmpfiles.rules =
    [
      "d /var/lib/plex 0700 plex plex - -"
      "Z /var/lib/plex 0700 plex plex - -"
    ]
    ++ (
      # Media folders: read-only for plex group
      builtins.concatMap (path: [
        "d ${path} 0755 root plex - -"
        "Z ${path} - root plex - -"
      ]) mediaPath
    );

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "plex";
    group = "plex";
  };

  systemd.services.plex = {
    serviceConfig = {
      # Restrict filesystem access
      # ProtectSystem = true;
      ReadOnlyPaths = [
        mediaPath
      ];
      ReadWritePaths = [
        "var/lib/plex"
      ];
      # Drop unnecessary privileges
      #   CapabilityBoundingSet = "";
      #   NoNewPrivileges = true;
      #   PrivateTmp = true;
      #   # PrivateDevices = true;
      #   ProtectHome = true;
      #   ProtectKernelTunables = true;
      #   ProtectKernelModules = true;
      #   ProtectControlGroups = true;
      #   RestrictAddressFamilies = "AF_INET AF_INET6";
      #   RestrictNamespaces = false;
      #   LockPersonality = true;
      #   MemoryDenyWriteExecute = true;
      #   RestrictRealtime = true;
      #   RestrictSUIDSGID = true;
      #   SystemCallFilter = [
      #     "@system-service"
      #     "mount"
      #     "umount"
      #   ];
      #   SystemCallArchitectures = "native";
    };
  };
}
