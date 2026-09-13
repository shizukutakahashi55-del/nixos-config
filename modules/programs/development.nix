{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Development
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    direnv
    git
    gh
    lazygit
    python3
    python3Packages.pip
    vscodium
    # Servidor de lenguaje (LSP) para soporte inteligente de Nix
    nixd 
    # Formateador oficial de código Nix
    nixfmt-rfc-style
    nix-direnv 
  ];
}