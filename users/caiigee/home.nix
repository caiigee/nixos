{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caiigee";
  home.homeDirectory = "/home/caiigee";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "DejaVuSans" ];
      monospace = [ "ZedMono" ];
    };
  };

  # Cursor:
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Adwaita";
    size = 24;
  };

  # GTK Settings:
  gtk = {
    enable = true;
    theme.name = "Adwaita";
    iconTheme.name = "Adwaita";
    font = {
      name = "Cantarell";
      size = 11;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # SOFTWARE
  # Packages without options:
  home.packages = with pkgs; [
    # Apps:
    libreoffice-fresh
    signal-desktop
    foliate
    icon-library
    switcheroo
    gimp
    pinta
    ghidra
    sqlitebrowser
    anki
    wike
    pdfarranger

    # Fonts:
    nerd-fonts.symbols-only
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.zed-mono

    # Utility:
    brightnessctl
    unzip
    zip
    dex

    # Gaming:
    bottles
    prismlauncher
  ];

  programs.ssh.enable = true;
  programs.git = {
    enable = true;
    userName = "caiigee";
    userEmail = "caiigee@pm.me";
    extraConfig = {
      core = {
        sshcommand = "ssh -i /home/caiigee/.ssh/id_ed25519";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo nix-store --gc";
      flipscreen = "hyprctl keyword monitor desc:AU Optronics 0xC199, 2560x1600@60.03Hz, auto, auto, transform, 0";
      zipub = "zip -X0 book.epub mimetype && zip -Xr9D book.epub META-INF OEBPS";
      nsc = "nix run github:snowfallorg/nix-software-center";
    };
    initExtra = ''
      nos() {
        if [ -z "$1" ]; then
          echo "Desktop environment is required!"
          return 1
        fi
        rm /home/caiigee/.mozilla/firefox/default/search.json.mozlz4
        sudo nixos-rebuild switch --flake /etc/nixos#"$1"-$(hostname)
      }
    '';
  };

  # BLUETOOTH
  services.mpris-proxy.enable = true;

  # ENVIRONMENT VARIABLES
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "zeditor";
    XDG_SCREENSHOTS_DIR = /home/caiigee/Pictures/Screenshots;
  };
}
