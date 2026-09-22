{ config, pkgs, ... }:

{
  imports = [
    # ───────────────────────────────────────────
    # Hardware
    # ───────────────────────────────────────────

    ./hardware-configuration.nix

    # ───────────────────────────────────────────
    # Sistema
    # ───────────────────────────────────────────

    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/nvidia.nix
    ./modules/users.nix
    ./modules/hyprland.nix

    # ───────────────────────────────────────────
    # Programas
    # ───────────────────────────────────────────

    ./modules/programs/browsers.nix
    ./modules/programs/communication.nix
    ./modules/programs/development.nix
    ./modules/programs/gaming.nix
    ./modules/programs/kde.nix
    ./modules/programs/media.nix
    ./modules/programs/obs.nix
    ./modules/programs/steam.nix
    ./modules/programs/suwayomi.nix
    ./modules/programs/system.nix
    ./modules/programs/terminal.nix

    # ───────────────────────────────────────────
    # Servicios
    # ───────────────────────────────────────────

    ./modules/services/flatpak.nix
    
  ];

  # ─────────────────────────────────────────────
  # Nix & System Configuration
  # ─────────────────────────────────────────────

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Habilita paquetes propietarios en todo el sistema
  nixpkgs.config.allowUnfree = true;

  # Versión inicial de NixOS
  system.stateVersion = "26.05";
}