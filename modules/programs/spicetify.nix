{ pkgs, inputs, lib, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  spicetifyThemesSrc = pkgs.fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";
    rev = "master";
    hash = "sha256-R0lho0h+GxAiHARFz31ZEJil5KSTR1/M0mFR/wnxK3o=";
  };

in
{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = {
    enable = true;

    theme = {
      name = "Sleek";
      src = "${spicetifyThemesSrc}/Sleek";
      colorScheme = "Base"; 
      injectCss = true;
      injectThemeJs = false;
      replaceColors = true;
      sidebarConfig = true;
      homeConfig = true;
      overwriteAssets = false;
      additionalCss = ""; 
    };

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}