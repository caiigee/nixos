{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -al --color";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      flipscreen = "hyprctl keyword monitor desc:AU Optronics 0xC199, 2560x1600@60.03Hz, auto, auto, transform, 0";
      zipub = "zip -X0 book.epub mimetype && zip -Xr9D book.epub META-INF OEBPS";
      list = "nix profile list";
      update = "cd $XDG_CONFIG_HOME/nixos && nix flake update && commit \"Updated lock\"";
      switch = ''
        rm /home/caiigee/.mozilla/firefox/default/search.json.mozlz4 /home/caiigee/.mozilla/firefox/normal/search.json.mozlz4
        nix profile remove --all
        sudo nixos-rebuild switch --flake $XDG_CONFIG_HOME/nixos#$(hostname)-$XDG_CURRENT_DESKTOP
      '';
    };
    initExtra = # bash
      ''
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
         run() {
           if [ -z "$1" ]; then
             echo "Package name is required!"
             return 1
           fi
           nix run nixpkgs#$1 ''${@:2}
         }
         dev() {
           if [ -z "$1" ]; then
             echo "Error: Project name is required!"
             return 1
           fi
           
           cd $PROJECTS_DIR/"$1" && nix develop . -c nvim -c "Telescope find_files"
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

           git add .
           git commit -m "$*"
           git push
         }
      '';
  };
}
