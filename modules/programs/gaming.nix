{ pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Gaming Packages & Utilities
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    gamemode
    lutris
    mangohud
    prismlauncher
    protonplus
    wine
    protontricks
    goverlay
    
  ];
}