{ config, pkgs, ... }:

{
  
  # ─────────────────────────────────────────────
  # Bluetooth
  # ─────────────────────────────────────────────
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  
  };

  environment.systemPackages = with pkgs; [
      blueman
   ];
  
  # ─────────────────────────────────────────────
  # Network
  # ─────────────────────────────────────────────

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  # ─────────────────────────────────────────────
  # Timezone
  # ─────────────────────────────────────────────

  time.timeZone = "America/Phoenix";

  # ─────────────────────────────────────────────
  # Locale
  # ─────────────────────────────────────────────

  i18n.defaultLocale = "en_US.UTF-8";

  # ─────────────────────────────────────────────
  # Keyboard
  # ─────────────────────────────────────────────

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}