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

  fonts.fontconfig.enable = true;

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
  home.packages = with pkgs; [
    # Apps:
    libreoffice-fresh
    signal-desktop
    foliate
    gimp
    icon-library
    switcheroo
    pinta
    ghidra
    sqlitebrowser
    anki
    pdfarranger

    # Fonts (for some reason they don't symlink to /etc/profiles/per-user/caiigee/share/fonts):
    nerd-fonts.symbols-only

    # Utility:
    brightnessctl
    unzip
    zip
    dex
  ];

  programs.ssh.enable = true;
  programs.git = {
    enable = true;
    userName = "caiigee";
    userEmail = "141404025+caiigee@users.noreply.github.com";
    extraConfig = {
      core = {
        sshcommand = "ssh -i /home/caiigee/.ssh/id_ed25519";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo nix-store --gc";
      flipscreen = "hyprctl keyword monitor desc:AU Optronics 0xC199, 2560x1600@60.03Hz, auto, auto, transform, 0";
      zipub = "zip -X0 book.epub mimetype && zip -Xr9D book.epub META-INF OEBPS";
      list = "nix profile list";
      update = "sudo nix flake update --flake /etc/nixos";
      switch = ''
        rm /home/caiigee/.mozilla/firefox/default/search.json.mozlz4
        nix profile remove --all
        sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)-$XDG_CURRENT_DESKTOP
      '';
    };
    initExtra = ''
      umask 0077
      flash() {
        if [ -z "$1" ]; then
          echo "ISO path is required!"
          return 1
        fi
        if [ -z "$2" ]; then
          echo "sdX must be specified!"
          return 1
        fi
        if [ ! -e "/dev/$2" ]; then
          echo "Device /dev/$2 does not exist!"
          return 1
        fi
        sudo dd if="$1" of=/dev/"$2" bs=4M status=progress
      }
      install() {
        if [ -z "$1" ]; then
          echo "Package name is required!"
          return 1
        fi
        nix profile install nixpkgs#"$1"
      }
      remove() {
        if [ -z "$1" ]; then
          echo "Package name is required!"
          return 1
        fi
        nix profile remove "$1"
      }
      clone() {
        if [ -z "$1" ]; then
          echo "Error: GitHub repository name is required!"
          return 1
        fi

        git clone git@github.com:"$1".git

        if [ $? -ne 0 ]; then
          echo "Error: Failed to clone repository."
          return 1
        fi

        echo "Successfully cloned $1"
      }
      commit() {
        if [ ! -d .git ]; then
            echo "Error: Not in a git repository root directory" >&2
            return 1
        fi

        if [ $# -eq 0 ]; then
            echo "Error: Please provide a commit message"
            return 1
        fi

        # Check if running as root (sudo)
        if [ "$(id -u)" -eq 0 ]; then
            SUDO="sudo"
        else
            SUDO=""
        fi

        $SUDO git add .
        $SUDO git commit -m "$*"
        $SUDO git push
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
    PROMPT_DIRTRIM = 2;
  };
}
