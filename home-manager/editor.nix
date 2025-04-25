{

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

      lsp = {
        nil = {
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };
          };
        };
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
}
