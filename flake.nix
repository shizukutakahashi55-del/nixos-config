
{
  description = "NixOS configuration";

  # ─────────────────────────────────────────────
  # Inputs (Fuentes de paquetes y módulos)
  # ─────────────────────────────────────────────
  inputs = {
    # Canal principal de paquetes en su rama estable 26.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Hyprland 0.56.2
    # Usamos directamente el tag de la versión para evitar
    # que Hyprland cambie automáticamente a una versión futura.
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.56.2";

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
  };

  # ─────────────────────────────────────────────
  # Outputs (Construcción del sistema)
  # ─────────────────────────────────────────────
  outputs = { self, nixpkgs, millennium, prismlauncher, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      # Pasa las entradas (inputs) a todos los módulos (.nix)
      # Esto permite utilizar inputs.hyprland desde hyprland.nix
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

