{ config, pkgs, ... }:

{
  
  # ---------------------------------------------------------------------------
  # System packages
  # Web Browsers
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [

    brave
    librewolf
    vivaldi
  ];

}
