{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Nixpkgs overlays
  # Overrides the native package version with the stable GitHub release
  # ─────────────────────────────────────────────

  nixpkgs.overlays = [
    (final: prev: {
      # Force the use of version v2.3.2243 using the official .jar executable
      suwayomi-server = prev.suwayomi-server.overrideAttrs (oldAttrs: {
        version = "2.3.2243";

        src = final.fetchurl {
          url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v2.3.2243/Suwayomi-Server-v2.3.2243.jar";
          hash = "sha256-ghFBsy4XDUoC08vf7Vd+2PB70iOD/19BMuu1rkDpjdU=";
        };
      });
    })
  ];

  # To get the hash use: nix hash convert --to sri sha256: (the number you see on GitHub)
  # ─────────────────────────────────────────────
  # Suwayomi Server (Tachidesk)
  # Local web server for reading and managing manga
  # ─────────────────────────────────────────────

  services.suwayomi-server = {
    enable = true;                 # Enables the background service at system startup
    dataDir = "/var/lib/suwayomi"; # Directory for downloads, extensions, and database
    openFirewall = true;           # Automatically opens the port in the NixOS firewall

    # Internal server configuration
    settings = {
      server.port = 4567;
      server.enableSystemTray = true;
    };
  };
}