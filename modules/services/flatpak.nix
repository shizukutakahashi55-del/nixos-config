{ pkgs, ... }:

{
  # Habilita el soporte para paquetes Flatpak en el sistema
  services.flatpak.enable = true;

  # Agrega automáticamente el repositorio de Flathub al iniciar
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
}