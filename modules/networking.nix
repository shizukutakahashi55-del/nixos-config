{ config, pkgs, ... }:

#Networking Module
{
  
  # ─────────────────────────────────────────────
  # Bluetooth
  # ─────────────────────────────────────────────
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true; # Ayuda con adaptadores caprichosos o BLE
        };
      };
    };

  services.blueman.enable = true;
  
  hardware.enableAllFirmware = true;

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