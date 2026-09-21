{ config, pkgs, ... }:

{

    # Sonora native player for linux spotify

{
  imports = [
    inputs.sonora.homeManagerModules.default # O homeManagerModules si es mediante Home Manager
  ];

  programs.sonora = {
    enable = true;
    # La configuración declarativa se genera dentro de ~/.config/sonora/config.json
    settings = {
      # Puedes pasar tus opciones de configuración por defecto
    };
  };

  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
  # discord
    telegram-desktop
    spotify
    vesktop
    
    
  ];

}

