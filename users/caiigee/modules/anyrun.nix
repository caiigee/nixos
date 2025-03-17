{
  pkgs,
  anyrun,
  anyrun-plugins,
  ...
}:
let
  my-plugins = anyrun-plugins.packages.${pkgs.system}.default;
  default-plugins = anyrun.packages.${pkgs.system};
in
{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        default-plugins.symbols
        default-plugins.translate
        default-plugins.dictionary
        "${my-plugins}/lib/libbookmarks.so"
        "${my-plugins}/lib/libapplications.so"
        "${my-plugins}/lib/libwebpages.so"
        "${my-plugins}/lib/libpowermenu.so"
        "${my-plugins}/lib/librink.so"
        "${my-plugins}/lib/libshell.so"
        "${my-plugins}/lib/libwebsearch.so"
      ];
      x = {fraction = 0.5;};
      y = {fraction = 0.33;};
      width = {fraction = 0.3;};
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
    };
    extraCss = builtins.readFile ../assets/styles/anyrun.css;

    extraConfigFiles."symbols.ron".text = ''
      Config(
        prefix: "€",
        symbols: {
          "shrug": "¯\\_(ツ)_/¯",
        },
        max_entries: 3
      )
    '';
    extraConfigFiles."dictionary.ron".text = ''
      Config(
        prefix: ":?",
        max_entries: 3,
      )
    '';
    extraConfigFiles."Common.ron".text = ''
      CommonConfig(
        prefix_args: Some(["uwsm", "app", "--"])
      )
    '';
  };
}
