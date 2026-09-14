{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #kitty
    waybar
    rofi
    hyprpaper
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
  ];
}