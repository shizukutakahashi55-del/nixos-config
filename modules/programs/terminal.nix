{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Terminal
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    fastfetch
    kitty
    vim
    zsh
  ];
}