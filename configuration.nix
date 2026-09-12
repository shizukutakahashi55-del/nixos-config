{ config, pkgs, ... }:

{
  imports = [
    # ───────────────────────────────────────────
    # Hardware
    # ───────────────────────────────────────────

    ./hardware-configuration.nix

    # ───────────────────────────────────────────
    # System
    # ───────────────────────────────────────────

    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/nvidia.nix
    ./modules/users.nix

    # ───────────────────────────────────────────
    # Programs
    # ───────────────────────────────────────────

    ./modules/programs/browsers.nix
    ./modules/programs/communication.nix
    ./modules/programs/development.nix
    ./modules/programs/gaming.nix
    ./modules/programs/kde.nix
    ./modules/programs/system.nix
    ./modules/programs/terminal.nix
  ];

  # ─────────────────────────────────────────────
  # Services
  # ─────────────────────────────────────────────

  # Habilita el soporte para paquetes Flatpak en el sistema
  services.flatpak.enable = true;

  # ─────────────────────────────────────────────
  # Nix
  # ─────────────────────────────────────────────

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ─────────────────────────────────────────────
  # Unfree packages
  # ─────────────────────────────────────────────

  nixpkgs.config.allowUnfree = true;

  # ─────────────────────────────────────────────
  # NixOS version
  # ─────────────────────────────────────────────

  system.stateVersion = "26.05";
}