{
  description = "NixOS configuration";

  inputs = {
    # Main package channel on stable 26.05 release branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";


    # Millennium patch for Steam client
    millennium.url =
      "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    # Enhanced blur effect for KWin (KDE)
    kwin-effects-better-blur-dx = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prism Launcher
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify for declarative Spotify customization
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # Hyprland input
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, spicetify-nix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };

      modules = [
        {
          # Target system architecture
          nixpkgs.hostPlatform = "x86_64-linux";

          # Global overlays
          nixpkgs.overlays = [
            inputs.millennium.overlays.default
          ];
        }

        # Main configuration file
        ./configuration.nix
      ];
    };
  };
}
