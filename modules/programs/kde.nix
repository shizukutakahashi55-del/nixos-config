{ config, pkgs, inputs, lib, ... }:

{
 
  # ─────────────────────────────────────────────
  # KDE Plasma
  # ─────────────────────────────────────────────

  services.desktopManager.plasma6.enable = true;

  # ─────────────────────────────────────────────
  # KWIN BetterBlur
  # ─────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum

    kdePackages.kate # Kate for testing

    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
  ];
 
}