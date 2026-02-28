{ pkgs, config, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caiigee";
  home.homeDirectory = "/home/caiigee";
  programs.ssh.enable = true;
  programs.fastfetch.enable = true;
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

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

  # Packages:
  home.packages = with pkgs; [
    # Apps:
    libreoffice-fresh
    signal-desktop
    foliate
    gimp3
    icon-library
    switcheroo
    pinta
    # ghidra
    sqlitebrowser
    anki
    pdfarranger
    prismlauncher
    mangohud
    gamemode
    protonvpn-gui

    # Fonts (for some reason they don't symlink to /etc/profiles/per-user/caiigee/share/fonts):
    nerd-fonts.symbols-only

    # Utility:
    brightnessctl
    unzip
    zip
    dex
    # Open project script.
    (pkgs.writeShellApplication {
      name = "open-project";
      runtimeInputs = [ pkgs.fzf ];
      text = builtins.readFile ./assets/scripts/open_project.sh;
    })
    bat
    waypaper
    jq
  ];

  # git:
  programs.git = {
    enable = true;
    settings = {
      user.name = "caiigee";
      user.email = "";
      core.sshcommand = "ssh -i /home/caiigee/.ssh/id_ed25519";
    };
  };

  # tmux:
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g status-position top
      set -g mouse on
      set -sg escape-time 10
    '';
  };

  # Bluetooth
  services.mpris-proxy.enable = true;

  # Environment variables
  home.sessionVariables = {
    BROWSER = "firefox";
    XDG_SCREENSHOTS_DIR = "/home/caiigee/Pictures/Screenshots";
    PROMPT_DIRTRIM = 2;
    EDITOR = "nvim";
    NOTES_DIR = "/home/caiigee/Documents/Notes";
    PROJECTS_DIR = "/home/caiigee/Desktop/Projects";
    TERMINAL = "kitty";
    FILE_MANAGER = "nautilus";
  };
}
