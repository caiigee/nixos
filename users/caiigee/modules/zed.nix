{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "toml"
      "nix"
      "ron"
      "git-firefly"
      "ruff"
    ];
    userSettings = {
      notification_panel = {
        dock = "left";
      };
      chat_panel = {
        dock = "left";
      };
      assistant = {
        version = 2;
        dock = "left";
        enabled = false;
      };
      terminal = {
        dock = "bottom";
      };
      languages = {
        Rust.tab_size = 4;
        Python = {
          tab_size = 4;
          language_servers = [
            "!pylsp"
            "pyright"
            "ruff"
          ];
          format_on_save = "on";
          formatter = [
            {
              language_server = {
                name = "ruff";
              };
            }
          ];
        };
        RON.tab_size = 4;
        Nix = {
          language_servers = [
            "nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
      tab_size = 2;
      collaboration_panel = {
        dock = "right";
      };
      outline_panel = {
        dock = "right";
      };
      project_panel = {
        dock = "right";
      };
      features = {
        inline_completion_provider = "none";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        light = "Andromeda";
        dark = "Ayu Dark";
      };
      file_scan_exclusions = [ ];
      autosave = {
        after_delay = {
          milliseconds = 500;
        };
      };
      soft_wrap = "editor_width";
      restore_on_startup = "none";
      extend_comment_on_newline = false;
    };
    userKeymaps = [
      {
        bindings = {
          ctrl-q = null;
        };
      }
      {
        context = "ProjectPanel";
        bindings = {
          ctrl-shift-n = "project_panel::NewDirectory";
          enter = "project_panel::Open";
        };
      }
      {
        context = "Workspace";
        bindings = {
          ctrl-e = "workspace::ToggleRightDock";
          ctrl-b = null;
        };
      }
      {
        context = "Editor";
        bindings = {
          ctrl-shift-n = "editor::Fold";
          ctrl-shift-b = "editor::UnfoldLines";
          ctrl-right = "editor::MoveToNextSubwordEnd";
          ctrl-left = "editor::MoveToPreviousSubwordStart";
          ctrl-shift-left = "editor::SelectToPreviousSubwordStart";
          ctrl-shift-right = "editor::SelectToNextSubwordEnd";
        };
      }
      {
        context = "Editor && mode == full";
        bindings = {
          ctrl-shift-t = "outline::Toggle";
          ctrl-shift-o = "outline_panel::ToggleFocus";
        };
      }
    ];
    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      ruff
    ];
  };
}
