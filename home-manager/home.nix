{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "skarkii";
  home.homeDirectory = "/home/skarkii";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/skarkii/etc/profile.d/hm-session-vars.sh
  #

  # Enable dconf for GNOME settings
  dconf.enable = true;

  # Configure GNOME Shell settings
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        clipboard-indicator.extensionUuid

        # applications-menu.extensionUuid # cant get these to work?!
        # status-icons.extensionUuid
        # places-status-indicator.extensionUuid

        # Outdated:
        # sound-output-device-chooser.extensionUuid
        # quick-settings-tweaker.extensionUuid
      ];
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      color-scheme = "prefer-dark";
      # gtk-theme = "Nordic";
      # icon-theme = "Adwaita";
      # cursor-theme = "Adwaita";
      # font-name = "Cantarell 11";
    };
  };

  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "shift shift" = "file_finder::Toggle";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-b" = "workspace::ToggleLeftDock";
          "alt-k" = "editor::MoveLineUp";
          "alt-j" = "editor::MoveLineDown";
        };
      }
    ];
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        light = "Andromeda";
        dark = "Andromeda";
      };
      show_whitespaces = "boundary";
      relative_line_numbers = true;
      show_edit_predictions = false;
      remove_trailing_whitespace_on_save = true;
      base_keymap = "VSCode";
      ui_font_size = 16;
      buffer_font_size = 16;
      load_direnv = "shell_hook";
      hard_tabs = false;

      git_status = "false";
      git = {
        inline_blame = {
          enabled = true;
          show_commit_summary = false;
        };
      };

      search = {
        whole_word = false;
        case_sensitive = false;
        include_ignored = false;
        regex = true;
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      edit_predictions = {
        disabled_globs = [
          "**/.env*"
          "**/*.pem"
          "**/*.key"
          "**/*.cert"
          "**/*.crt"
          "**/secrets.yml"
        ];
      };

      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/.jj"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        ".ropeproject"
        ".venv"
        "__pycache__"
      ];

      languages = {
        C = { };
        JSON = { };
        Python = { };
        # Example on how to format:
        # "Python": {
        #   "format_on_save": {
        #     "external": {
        #       "command": "black",
        #       "arguments": ["-", "--line-length", "999"]
        #     }
        #   }
      };

      assistant = {
        default_model = {
          provider = "openai";
          model = "gpt-4o";
        };
        enabled = false;
        button = false;
        dock = "right";
        default_width = 640;
        default_height = 320;
        provider = "openai";
        version = "2";
      };

    };
  };

  programs.zsh = {
    enable = true;
    history.size = 10000;
    # autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ]; # Add plugins you need
      theme = "robbyrussell"; # A modern, clean theme (you can change this)
    };

    initExtra = ''
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
    };
  };
}
