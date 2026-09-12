{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Development
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    git
    python3
    python3Packages.pip
    vscodium
    # Servidor de lenguaje (LSP) para soporte inteligente de Nix
    nixd 
    
    # Formateador oficial de código Nix
    nixfmt-rfc-style
  ];
}