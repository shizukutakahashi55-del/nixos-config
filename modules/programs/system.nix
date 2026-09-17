{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # System / CLI
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    jq
    playerctl
    swayosd
  ];
}