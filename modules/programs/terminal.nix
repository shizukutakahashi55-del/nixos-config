{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Terminal
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    eza          #Reemplazo moderno e interactivo de ls con iconos y árbol de archivos.
    fastfetch
    kitty
    ripgrep      #Reemplazo ultrarrápido de grep respetando archivos .gitignore.
    starship
    vim
    zsh
  ];
}