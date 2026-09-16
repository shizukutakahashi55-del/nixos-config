{ pkgs, ... }:

{
  # Enables Flathub
  services.flatpak.enable = true;

  # Flathub at Startup
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
}