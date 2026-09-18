{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # X11
  # ─────────────────────────────────────────────

  services.xserver.enable = true;

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
    nerd-fonts.jetbrains-mono  
  ];
}