{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Development
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [

    appimage-run
    curl
    direnv
    git
    gh
    jdk21
    jdk17
    lazygit
    python3
    python3Packages.pip
    vscodium
    nixd 
    nixfmt-rfc-style
    nix-direnv 
    nix-search-cli
    ruff
    tree
    qt6.qtquick3d
    qt6.qtdeclarative
    uv 
    wget
    vim

    # C++ Build Tools
    gcc
    gnumake
    cmake
    pkg-config 
  ];
}