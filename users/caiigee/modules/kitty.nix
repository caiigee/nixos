{pkgs, ...}:

{
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
}
