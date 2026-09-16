{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    spotify
    
  ];

}

