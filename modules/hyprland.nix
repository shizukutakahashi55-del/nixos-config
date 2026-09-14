{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    #kitty
    awww
    waybar
    rofi
    hyprpaper
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
    polkit_kde_agent
    swaynotificationcenter
    waypaper
    networkmanagerapplet
    matugen
    
  ];
}