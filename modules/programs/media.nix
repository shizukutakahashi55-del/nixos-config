{ config, pkgs, inputs, ... }:

{

  
  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
  
    mpv      # Media player general use
    vlc      # Video Player VLC
    nomacs   # Image Vierwer

  ];

}

