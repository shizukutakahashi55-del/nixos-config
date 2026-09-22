{
  description = "NixOS configuration";

  inputs = {

    # ==========================================================================
    # NIXPKGS
    # ==========================================================================

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";


    # ==========================================================================
    # MILLENNIUM
    # ==========================================================================

    millennium.url =
      "github:SteamClientHomebrew/Millennium?dir=packages/nix";


    # ==========================================================================
    # KDE BETTER BLUR
    # ==========================================================================

    kwin-effects-better-blur-dx = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # ==========================================================================
    # PRISM LAUNCHER
    # ==========================================================================

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # ==========================================================================
    # Sonora
    # ==========================================================================

    sonora.url = "github:sonorahq/sonora";


    # ==========================================================================
    # HYPRLAND
    # ==========================================================================

    hyprland.url =
      "github:hyprwm/Hyprland";
  };


  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      specialArgs = {
        inherit inputs;
      };

      modules = [

        {
          nixpkgs.hostPlatform = "x86_64-linux";

          nixpkgs.overlays = [
            inputs.millennium.overlays.default
          ];
        }

        ./configuration.nix
      ];
    };
  };
}