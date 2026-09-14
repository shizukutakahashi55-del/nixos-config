{ config, pkgs, inputs, ... }:

{

  # ─────────────────────────────────────────────
  # Hyprland
  # ─────────────────────────────────────────────
  programs.hyprland = {

    # Habilita la sesión de Hyprland en NixOS
    enable = true;

    # Utiliza UWSM para gestionar la sesión Wayland
    withUWSM = true;

    # Soporte para aplicaciones X11 mediante XWayland
    xwayland.enable = true;

    # Utiliza Hyprland 0.56.2 desde el flake oficial
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # Mantiene el portal de Hyprland en la misma versión
    # que el compositor.
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };


  # ─────────────────────────────────────────────
  # Polkit
  # ─────────────────────────────────────────────
  security.polkit.enable = true;


  # ─────────────────────────────────────────────
  # Paquetes del entorno Hyprland
  # ─────────────────────────────────────────────
  environment.systemPackages = with pkgs; [

    # ────────────────
    # Wayland / Hyprland
    # ────────────────
    waybar
    waybar-mpris
    rofi

    # ────────────────
    # Hyprland utilities
    # ────────────────
    hyprpaper
    hyprlock
    hypridle

    # ────────────────
    # Screenshots / Clipboard
    # ────────────────
    wl-clipboard
    grim
    slurp

    # ────────────────
    # Polkit
    # ────────────────
    kdePackages.polkit-kde-agent-1

    # ────────────────
    # Notifications
    # ────────────────
    swaynotificationcenter

    # ────────────────
    # Wallpaper
    # ────────────────
    awww
    waypaper

    # ────────────────
    # Network
    # ────────────────
    networkmanagerapplet

    # ────────────────
    # Theming
    # ────────────────
    matugen

    # ────────────────
    # Shell / UI
    # ────────────────
    quickshell

    # ────────────────
    # Audio
    # ────────────────
    cava
    pavucontrol

    # ────────────────
    # Logout menu
    # ────────────────
    wlogout
  ];
}

