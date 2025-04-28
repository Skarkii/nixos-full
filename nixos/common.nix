# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };
  console.keyMap = "sv-latin1";

  # Sound
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    #media-session.enable = true;
  };

  # Users
  users.users.skarkii = {
    isNormalUser = true;
    description = "Lucas Kuja-Halkola";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    home-manager

    # Nix editor utilties
    nixd
    nixfmt-rfc-style
    nix-index

    # Gnome utilities
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    # gnomeExtensions.applications-menu # cant get these 3 to work
    # gnomeExtensions.status-icons
    # gnomeExtensions.places-status-indicator
    # Outdated
    # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.quick-settings-tweaker

    # Editor/Terminal
    neovim
    zed-editor
    zsh
    atuin

    # lsp&formatters
    nil
    black
    gopls
    clang-tools
    prettierd

    # Terminal utilies
    git

    # General
    mullvad-browser
    discord
    spotify
    plex-desktop
    neofetch
    wl-clipboard
  ];

  # Set zsh to default terminal
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # remove trash programs
  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
