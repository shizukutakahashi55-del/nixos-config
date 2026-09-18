{ pkgs, inputs, lib, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  # Sleek vive dentro del monorepo oficial de temas de spicetify,
  # así que traemos todo el repo y apuntamos solo a la subcarpeta "Sleek".
  spicetifyThemesSrc = pkgs.fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";
    rev = "master"; # cuando quieras reproducibilidad, cámbialo por un commit fijo
    hash = "sha256-R0lho0h+GxAiHARFz31ZEJil5KSTR1/M0mFR/wnxK3o=";
  };
in
{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = {
    enable = true;

    # Antes: theme = spicePkgs.themes.catppuccin; colorScheme = "mocha";
    # Sleek no viene precargado en spicePkgs, así que lo definimos como tema custom.
    theme = {
      name = "Sleek";
      src = "${spicetifyThemesSrc}/Sleek";

      injectCss = true;
      injectThemeJs = false; # Sleek no trae theme.js; revisa su README si esto cambia
      replaceColors = true;
      sidebarConfig = true;
      homeConfig = true;
      overwriteAssets = false;
      additonalCss = "";
    };

    # Colores dinámicos generados por matugen (ver spicetify-colors.nix.template).
    # colorScheme se vuelve "custom" automáticamente cuando esto no está vacío.
    customColorScheme = import /home/oozenix/.cache/matugen/spicetify-colors.nix;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}
