{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Overlays de Nixpkgs
  # Sobrescribe la versión del paquete nativo por la release estable de GitHub
  # ─────────────────────────────────────────────

  nixpkgs.overlays = [
    (final: prev: {
      # Forzamos el uso de la versión v2.3.2243 usando el ejecutable .jar oficial
      suwayomi-server = prev.suwayomi-server.overrideAttrs (oldAttrs: {
        version = "2.3.2243";

        src = final.fetchurl {
          url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v2.3.2243/Suwayomi-Server-v2.3.2243.jar";
          hash = "sha256-ghFBsy4XDUoC08vf7Vd+2PB70iOD/19BMuu1rkDpjdU=";
        };
      });
    })
  ];

  # ─────────────────────────────────────────────
  # Servicio de Suwayomi Server (Tachidesk)
  # Servidor web local para lectura y gestión de manga
  # ─────────────────────────────────────────────

  services.suwayomi-server = {
    enable = true;                 # Habilita el servicio de fondo al iniciar el sistema
    dataDir = "/var/lib/suwayomi"; # Directorio para descargas, extensiones y base de datos
    openFirewall = true;           # Abre el puerto en el firewall de NixOS automáticamente

    # Configuración interna del servidor
    settings = {
      server.port = 4567;
      server.enableSystemTray = true;
    };
  };
}