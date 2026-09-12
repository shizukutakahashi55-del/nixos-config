{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Bootloader
  # ─────────────────────────────────────────────

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ─────────────────────────────────────────────
  # Kernel
  # ─────────────────────────────────────────────

  # Kernel estable
  boot.kernelPackages = pkgs.linuxPackages;
}