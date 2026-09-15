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
    waybar-mpris
    rofi
    hyprpaper
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
    kdePackages.polkit-kde-agent-1
    swaynotificationcenter
    waypaper
    networkmanagerapplet
    matugen
    quickshell
    cava
    wlogout
    pavucontrol
    imagemagick
    libnotify
    qt6Packages.qt6ct
    
  ];
}