{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      suwayomi-server = prev.suwayomi-server.overrideAttrs (oldAttrs: {
        version = "2.3.2243";

        src = final.fetchurl {
          url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v2.3.2243/Suwayomi-Server-v2.3.2243.jar";
          hash = "sha256-ghFBsy4XDUoC08vf7Vd+2PB70iOD/19BMuu1rkDpjdU=";
        };
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    firefox
    brave
    chromium
    librewolf
  ];

  services.suwayomi-server = {
    enable = true;

    dataDir = "/var/lib/suwayomi";
    openFirewall = true;

    settings = {
      server.port = 4567;
      server.enableSystemTray = true;
    };
  };
}
