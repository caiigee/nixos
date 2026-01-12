{ pkgs, ... }:

{
  # Packages
  home.packages = with pkgs; [
    baobab
    nautilus
    papers
    dconf
    loupe
    file-roller
    gnome-calendar
    vanilla-dmz
    gnome-themes-extra
    adwaita-icon-theme
    gnome-disk-utility
    mission-center
    gnome-font-viewer
    ghex
    d-spy
    pwvucontrol
    hyprpolkitagent
    clipse
    grimblast
    wl-clipboard
    gnome-epub-thumbnailer
    showtime
    # hyprpaper
  ];
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "Dejavu Sans";
    };
    settings = {
      tab_bar_edge = "top";
    };
  };
  services.dunst.enable = true;

  # Hyprland
  wayland.windowManager.hyprland =
    let
      wpchanger = pkgs.writers.writePython3Bin "wpchanger" { } ''
        import json
        import subprocess
        import time
        import random
        from pathlib import Path


        def get_monitors():
            """Get list of connected monitors using hyprctl."""
            result = subprocess.run(
                ["hyprctl", "-j", "monitors"], capture_output=True, text=True
            )
            monitors = json.loads(result.stdout)
            return [monitor["name"] for monitor in monitors]


        def get_random_wallpapers(count):
            """Get random wallpapers from the wallpapers directory."""
            wallpaper_dir = Path.home() / "Pictures/Wallpapers"
            wallpapers = list(wallpaper_dir.glob("*"))
            return random.sample(wallpapers, min(count, len(wallpapers)))


        def set_wallpapers():
            """Set random wallpapers for all connected monitors."""
            monitors = get_monitors()
            wallpapers = get_random_wallpapers(len(monitors))

            # # Preloading wallpapers:
            # for wallpaper in wallpapers:
            #     subprocess.run(["hyprctl", "hyprpaper", "preload", str(wallpaper)])

            # Setting the wallpapers for each monitor:
            for monitor, wallpaper in zip(monitors, wallpapers):
                subprocess.run(
                    ["hyprctl", "hyprpaper", "reload", f"{monitor},{str(wallpaper)}"]
                )


        def main():
            while True:
                try:
                    set_wallpapers()
                except Exception as e:
                    print(f"Error setting wallpapers: {e}")
                time.sleep(600)


        if __name__ == "__main__":
            main()
      '';
    in
    {
      enable = true;
      systemd.enable = false;
      settings = {
        # MONITORS
        monitor = [
          "desc:AU Optronics 0xC199, 2560x1600@60.03Hz, auto, auto, transform, 2"
          "desc:Acer Technologies Acer XB281HK T4REE0014201, 1920x1080@60.00Hz, 0x0, 1"
          "desc:Samsung Electric Company SAMSUNG 0x01000E0, 1920x1080@60.00Hz, 0x0, 1"
        ];

        # DEFAULT PROGRAMS
        "$terminal" = "uwsm app -- $TERMINAL";
        "$fileManager" = "uwsm app -- $FILE_MANAGER";
        # "$menu" = "uwsm app -- anyrun";
        "$browser" = "uwsm app -- $BROWSER";
        "$editor" = "uwsm app -T -- $EDITOR";
        # "$emoji" = "uwsm app -- smile";

        # Autostart applications
        exec-once = [
          "uwsm app -s b -- clipse -listen"
          "uwsm app -s b -- waybar"
          # "uwsm app -s b -- ${lib.getExe wpchanger}"
          "systemctl --user enable --now hypridle.service"
          # "systemctl --user enable --now hyprpaper.service"
          "systemctl --user enable --now hyprpolkitagent.service"
          "[workspace 1 silent] $browser --new-tab https://lumo.proton.me --new-tab https://drive.proton.me --new-tab https://mail.proton.me --new-tab https://calendar.proton.me"
          "[workspace 1 silent] sleep 1;$fileManager  ~"
          "[workspace 1 silent] sleep 2.8;hyprctl dispatch resizewindowpixel exact 35% 100%,class:firefox;uwsm app -T -- tmux"
        ];

        # NVidia drivers broke Zed so this is the workaround:
        #render = { explicit_sync = 0; };

        # Cursor settings
        cursor = {
          no_hardware_cursors = true;
          inactive_timeout = 3;
        };

        # Look and Feel
        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "master";
        };

        # Decoration
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = true;
            popups = true;
            size = 4;
            passes = 2;
            ignore_opacity = true;
          };
        };

        # ANIMATIONS
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # LAYOUTS
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "slave";
        };

        # MISC
        misc = {
          disable_hyprland_logo = true;
        };

        # INPUT
        input = {
          kb_layout = "hr";
          follow_mouse = 1;
          # sensitivity = -0.3;
          accel_profile = "flat";
          kb_options = "compose:caps";

          touchpad = {
            natural_scroll = true;
          };
        };

        # GESTURES
        # gestures = {
        #   workspace_swipe = true;
        # };

        # KEYBINDINGS
        bind = [
          # Main programs:
          "SUPER, space, exec, $menu"
          "SUPER, RETURN, exec, $terminal tmux"
          "SUPER, T, exec, $editor"
          "SUPER, F, exec, $fileManager --new-window"
          "SUPER, B, exec, $browser"
          "SUPER, A, exec, pkill waybar || uwsm app -- waybar"
          "SUPER, E, exec, $emoji"
          #"SUPER, G, exec, uwsm app -- heroic"

          # Shortcuts:
          "SUPER, I, exec, cd $XDG_CONFIG_HOME/nixos && uwsm app -T -- tmux new $EDITOR"
          "SUPER, V, exec, $terminal --class clipse -e clipse"
          "SUPER, N, exec, cd $NOTES_DIR && $editor"
          "SUPER, D, exec, uwsm app -T -- open-project"

          # Misc:
          "SUPER, Q, killactive"
          "SUPER, W, togglefloating"
          "SUPER, S, togglesplit"
          "SUPER, Z, exec, loginctl lock-session"

          # Screenshots:
          ", Print, exec, uwsm app -- grimblast copysave area"
          "SUPER SHIFT, S, exec, uwsm app -- grimblast copysave area"
          "CTRL, Print, exec, uwsm app -- grimblast copysave output"
          "SUPER SHIFT CTRL, S, exec, uwsm app -- grimblast copysave output"

          # ", XF86Launch1, togglespecialworkspace, rog"

          # Switching to other windows:
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # Switching to other workspaces:
          "SUPER, tab, workspace, +1"
          "SUPER SHIFT, tab, workspace, -1"

          # Moving windows
          "SUPER SHIFT, L, movetoworkspace, +1"
          "SUPER SHIFT, H, movetoworkspace, -1"
          "SUPER CTRL, L, movewindow, r"
          "SUPER CTRL, H, movewindow, l"
          "SUPER CTRL, K, movewindow, u"
          "SUPER CTRL, J, movewindow, d"

          # Audio and brightness control:
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [ "SUPER, ${toString ws}, workspace, ${toString ws}" ]
          ) 9
        ));

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        binde = [
          # Resizing
          "SUPER ALT, H, resizeactive, -32 0"
          "SUPER ALT, L, resizeactive, 32 0"
          "SUPER ALT, K, resizeactive, 0 -32"
          "SUPER ALT, J, resizeactive, 0 32"

          # Audio
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindl = [
          # Monitor and keyboard brightness
          ", XF86KbdBrightnessUp, exec, brightnessctl -sd asus::kbd_backlight set +1"
          ", XF86KbdBrightnessDown, exec, brightnessctl -sd asus::kbd_backlight set 1-"
          ", XF86MonBrightnessUp, exec, brightnessctl --save set +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl --save set 5%-"
        ];

        # WINDOW RULES
        windowrulev2 = [
          "suppressevent maximize, class:.*"

          "float,class:com.saivert.pwvucontrol"
          "float,class:gthumb"
          "float,class:xdg-desktop-portal-gtk"
          "float,class:clipse"
          "float,class:nmtui"
          "float,class:tweaks"
          "float,class:qt6ct"
          "float,class:blueman-manager"
          "float,class:org.gnome.Calendar"
          "float,class:org.gnome.FileRoller"

          # Floating pop-ups:
          "float,class:firefox,initialTitle:^$"
          "float,class:firefox,initialTitle:^(Library)$"
          "float,class:^(\.blueman-manager-wrapped)$,initialTitle:^(Bluetooth Devices)$"
          "float,class:^(com\.github\.johnfactotum\.Foliate)$,initialTitle:^(Image from .+)$"
          "float,class:^(signal-desktop)$,title:^(Save File)$"
          "float,class:^(signal-desktop)$,title:^(Open Files)$"
          "float,class:^(file-.+)$,title:^(Export Image as .+)$"

          "size 90% 90%,class:gthumb"
          "size 60% 60%,class:^(gimp)$,title:^(Open Image)$"
          "size 60% 60%,class:^(file-.+)$,title:^(Export Image as .+)$"
          "size 90% 90%,class:^(com.github.jeromerobert.pdfarranger)$,title:^(Hide Margins)$"
          "size 90% 90%,class:^(com.github.jeromerobert.pdfarranger)$,title:^(Crop Margins)$"
          "size 80% 80%,class:org.gnome.Calendar"
          "size 50% 50%,class:xdg-desktop-portal-gtk"
          "size 622 652,class:clipse"
          "size 30% 60%,class:nmtui"
          "size 40% 60%,title:Format Cells"
          "size 80% 80%,class:^(com.github.johnfactotum.Foliate)$,initialTitle:^(Image from .+)$"

          # Full opacity:
          # Minecraft 1.21.4
          "opacity 1,class:^(Minecraft (\\d+)\.(\\d+)\.(\\d+))$"
          "opacity 1,class:^(steam_app_\\d+)$"
        ];
      };
    };

  # Hypridle:
  # services.hypridle = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       # Command to run when executing `loginctl lock-session`
  #       lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
  #       # Lock the screen, set the keyboard brightness to zero and turn off the monitors before suspending.
  #       before_sleep_cmd = "pidof hyprlock || uwsm app -- hyprlock && brightnessctl -sd asus::kbd_backlight set 0 && hyprctl dispatch dpms off";
  #       # Restore the previous keyboard brightness and turn on the monitors when waking up.
  #       after_sleep_cmd = "brightnessctl -rd asus::kbd_backlight && hyprctl dispatch dpms on";
  #     };
  #
  #     listener = [
  #       # Dimming the monitors and turning off the keyboard backlight:
  #       {
  #         timeout = 150; # 2.5min
  #         on-timeout = "brightnessctl --save set 0 && brightnessctl -sd asus::kbd_backlight set 0";
  #         on-resume = "brightnessctl --restore && brightnessctl -rd asus::kbd_backlight";
  #       }
  #       # Locking the session:
  #       {
  #         timeout = 300; # 5min
  #         on-timeout = "uwsm app -- hyprlock";
  #       }
  #       # Turning off the monitors:
  #       {
  #         timeout = 330; # 5.5min
  #         on-timeout = "hyprctl dispatch dpms off";
  #         on-resume = "hyprctl dispatch dpms on";
  #       }
  #       # Suspending the computer:
  #       {
  #         timeout = 1800; # 30 min
  #         on-timeout = "systemctl suspend";
  #       }
  #     ];
  #   };
  # };

  # Hyprpaper:
  # services.hyprpaper = {
  #   enable = true;
  #   # Required for generating the hyprpaper.conf file:
  #   settings = {
  #     preload = "";
  #     wallpaper = "";
  #   };
  # };

  # Hyprlock:
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
        ignore_empty_input = true;
      };

      background = [
        {
          path = "~/Pictures/Wallpapers/nixos-lock.png";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };

  # UWSM
  programs.bash.profileExtra = ''
    if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  # Dead greek
  # xdg.configFile."custom.xkb".text = ''
  #   xkb_symbols "basic" {
  #     key <AD02> { [ w, W, dead_greek, Ł ] };
  #   };
  # '';

  # Required for Nautilus dark mode to work, more research is required:
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.userDirs.enable = true;
}
