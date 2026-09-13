{ pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Steam Configuration
  # ─────────────────────────────────────────────

  programs.steam = {
    enable = true;

    # Cliente de Steam parcheado con Millennium
    package = pkgs.millennium-steam;

    # Opciones útiles recomendadas para Steam
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}