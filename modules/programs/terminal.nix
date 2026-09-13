{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Terminal
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    fastfetch
    kitty
    starship
    vim
    zsh
  ];
}
