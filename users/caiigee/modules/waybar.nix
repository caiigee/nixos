{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        modules-center = [
          "clock"
        ];
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "network"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "battery"
        ];
        backlight = {
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-up = "brightnessctl --save set +1%";
          on-scroll-down = "brightnessctl --save set 1%-";
        };
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% ";
          format-full = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-plugged = "{capacity}% ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        bluetooth = {
          format = "";
          format-connected = " {num_connections} connected";
          format-disabled = "";
          on-click = "blueman-manager";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };
        clock = {
          format = "{:%B %d, %H:%M}";
          interval = 60;
          tooltip = false;
          on-click = "uwsm app -- gnome-calendar";
        };
        "hyprland/workspaces" = {
          all-outputs = true;
        };
        network = {
          format-disconnected = "";
          format-ethernet = "{ifname} ";
          format-wifi = "{essid} ";
          max-length = 50;
          on-click = "uwsm app -- kitty --class nmtui -e nmtui";
        };
        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            car = "";
            default = [
              ""
              ""
              ""
            ];
            hands-free = "";
            headphone = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = " {format_source}";
          format-source-muted = "";
          on-click = "uwsm app -- pwvucontrol";
        };
        layer = "top";
        output = [
          "eDP-1"
          "eDP-2"
        ];
      };
    };
    style = builtins.readFile ../assets/styles/waybar.css;
  };
}
