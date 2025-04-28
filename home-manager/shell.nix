{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enable_accept = false;
    };
  };

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
      ]; # Add plugins you need
      theme = "robbyrussell"; # A modern, clean theme (you can change this)
    };

    initContent = ''
      cmkdir() {
        mkdir -p "$1" && cd "$1"
      }

      va() {
          # Check if we are in a Git repository
          if git rev-parse --is-inside-work-tree &>/dev/null; then
              # Get the root of the Git repository
              GIT_ROOT=$(git rev-parse --show-toplevel)

              # Check for virtual environments in the Git root
              if [[ -d "$GIT_ROOT/.venv" ]]; then
                  source "$GIT_ROOT/.venv/bin/activate"
                  echo "Activated virtual environment from $GIT_ROOT/.venv"
                  return
              elif [[ -d "$GIT_ROOT/venv" ]]; then
                  source "$GIT_ROOT/venv/bin/activate"
                  echo "Activated virtual environment from $GIT_ROOT/venv"
                  return
              fi
          fi

          # Check for virtual environments in the current directory
          if [[ -d ".venv" ]]; then
              source ".venv/bin/activate"
              echo "Activated virtual environment from .venv"
          elif [[ -d "venv" ]]; then
              source "venv/bin/activate"
              echo "Activated virtual environment from venv"
          fi
      }

      vd() {
          if [[ -n "$VIRTUAL_ENV" ]]; then
              deactivate
              echo "Virtual environment deactivated."
          else
              echo "No active virtual environment."
          fi
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

      # dev tools
      vim = "nvim";
      vi = "nvim";
      dev = "nix develop";
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
