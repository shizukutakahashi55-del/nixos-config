{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # X11
  # ─────────────────────────────────────────────

  services.xserver.enable = true;

  # ─────────────────────────────────────────────
  # KDE Plasma
  # ─────────────────────────────────────────────

  services.desktopManager.plasma6.enable = true;

  # ─────────────────────────────────────────────
  # Display Manager
  # ─────────────────────────────────────────────

  services.displayManager.sddm.enable = true;

  # ─────────────────────────────────────────────
  # Printing
  # ─────────────────────────────────────────────

  services.printing.enable = true;

  # ─────────────────────────────────────────────
  # Fonts
  # ─────────────────────────────────────────────

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono  # Elimina esta línea si no necesitas Nerd Fonts
  ];
}