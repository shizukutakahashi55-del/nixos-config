{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # Module NixOS
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}