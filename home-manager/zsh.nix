{ ... }:
{
  programs.zsh = {
    enable = true;
    history.size = 10000;
    # autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      theme = "robbyrussell"; # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    };

    initContent = ''
      cmkdir() {
        mkdir -p "$1" && cd "$1"
      }

      nix-index-fetch () {
        filename="index-$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | tr A-Z a-z)"
        mkdir -p ~/.cache/nix-index && cd ~/.cache/nix-index
        # -L follows redirects, -s is silent, -z only downloads if newer
        curl -Ls -o $filename -z $filename https://github.com/nix-community/nix-index-database/releases/latest/download/$filename
        ln -f $filename files
      }
    '';

    shellAliases = {
      la = "ls -a";
      logout = "hyprctl dispatch exit";

      dev = "nix develop -c $SHELL";
      gs = "git status";
      gc = "git commit --verbose -m";

      # Nix/Homemanager
      nix-rebuild = "sudo nixos-rebuild switch";
      hm-rebuild = "home-manager switch";
      hm-clean = "nix-collect-garbage"; # -d ?

      # clipboard, usage: program | clip
      clip = "wl-copy";
      CLIP = "wl-copy";

      # z alias
      zl = "z -l";
      za = "z --add";
      zx = "z -x";
      zd = "z -x";
    };
  };
}
