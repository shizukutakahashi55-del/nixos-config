{ config, pkgs, inputs, lib, ... }:

{
  # ─────────────────────────────────────────────
  # KDE / Desktop
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum

    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
  ];
}