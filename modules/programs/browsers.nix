{ config, pkgs, ... }:

{
  
  # ---------------------------------------------------------------------------
  # System packages
  # Web Browsers
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    firefox
    brave
    chromium
    librewolf
  ];

}
