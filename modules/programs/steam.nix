{ pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Steam Configuration
  # ─────────────────────────────────────────────

  programs.steam = {
    enable = true;

    # Steam Millennium
    package = pkgs.millennium-steam;

    # Utils
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}