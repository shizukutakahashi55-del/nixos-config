{ config, pkgs, ... }:

{
  
 # ---------------------------------------------------------------------------
  # Paquetes del Sistema
  # Navegadores web disponibles a nivel global en el sistema.
  # ---------------------------------------------------------------------------

  # ---------------------------------------------------------------------------
  # Paquetes del Sistema
  # Navegadores web disponibles a nivel global en el sistema.
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    firefox
    brave
    chromium
    librewolf
  ];

}
