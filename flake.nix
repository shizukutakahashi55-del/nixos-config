{
  description = "NixOS configuration";

  # ─────────────────────────────────────────────
  # Inputs (Fuentes de paquetes y módulos)
  # ─────────────────────────────────────────────
  inputs = {
    # Canal principal de paquetes en su rama estable 26.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Parche Millennium para el cliente de Steam
    millennium.url =
      "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    # Efecto de desenfoque mejorado para KWin (KDE)
    kwin-effects-better-blur-dx = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prism Launcher (Flake oficial apuntando a tags/releases estables)
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify para personalización declarativa de Spotify
    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ─────────────────────────────────────────────
  # Outputs (Construcción del sistema)
  # ─────────────────────────────────────────────
  outputs = { self, nixpkgs, spicetify-nix, ... }@inputs: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };

      modules = [
        {
          # Arquitectura del sistema objetivo
          nixpkgs.hostPlatform = "x86_64-linux";
          
          # Overlays globales para inyectar paquetes personalizados
          nixpkgs.overlays = [
            inputs.millennium.overlays.default
          ];
        }

        # Archivo principal de configuración de NixOS
        ./configuration.nix
      ];
    };
  };
}