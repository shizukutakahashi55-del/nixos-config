{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Gaming packages
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    gamemode
    lutris
    mangohud
    protonplus
    wine
  ];

  # ─────────────────────────────────────────────
  # Steam
  # ─────────────────────────────────────────────

  programs.steam = {
    enable = true;

    # Millennium Steam desde el overlay
    package = pkgs.millennium-steam;
  };
}