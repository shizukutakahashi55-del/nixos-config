{ config, pkgs, ... }:

{
<<<<<<< HEAD
  
 # ---------------------------------------------------------------------------
  # Paquetes del Sistema
  # Navegadores web disponibles a nivel global en el sistema.
  # ---------------------------------------------------------------------------
=======
  # ---------------------------------------------------------------------------
  # Overlays de Nixpkgs
  # Permiten modificar o sobrescribir paquetes existentes en la rama actual.
  # ---------------------------------------------------------------------------
  nixpkgs.overlays = [
    (final: prev: {
      # Sobrescribimos el paquete 'suwayomi-server' para forzar una versión específica (v2.3.2243)
      suwayomi-server = prev.suwayomi-server.overrideAttrs (oldAttrs: {
        version = "2.3.2243";

        # Descarga directa del ejecutable .jar desde los releases oficiales de GitHub
        src = final.fetchurl {
          url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v2.3.2243/Suwayomi-Server-v2.3.2243.jar";
          hash = "sha256-ghFBsy4XDUoC08vf7Vd+2PB70iOD/19BMuu1rkDpjdU=";
        };
      });
    })
  ];
>>>>>>> 88d085afad65c0e5bd4ceeeee7c62c662616514c

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

<<<<<<< HEAD
=======
  # ---------------------------------------------------------------------------
  # Servicio de Suwayomi Server (Tachidesk)
  # Servidor web local para lectura y gestión de manga.
  # ---------------------------------------------------------------------------
  services.suwayomi-server = {
    enable = true; # Habilita el servicio al iniciar el sistema

    dataDir = "/var/lib/suwayomi"; # Directorio donde se guardan las descargas, extensiones y base de datos
    openFirewall = true;           # Abre automáticamente el puerto en el firewall de NixOS

    # Configuración interna del servidor
    settings = {
      server.port = 4567;              # Puerto de acceso web (http://localhost:4567)
      server.enableSystemTray = true;  # Habilita el icono del servidor en la bandeja del sistema (System Tray)
    };
  };
>>>>>>> 88d085afad65c0e5bd4ceeeee7c62c662616514c
}
