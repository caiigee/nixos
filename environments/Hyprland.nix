{...}:

{
  # Necessary for Nautilus trash feature.
  services.gvfs.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  security.pam.services.hyprlock = {};
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
}
