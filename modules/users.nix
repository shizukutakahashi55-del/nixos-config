{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # User
  # ─────────────────────────────────────────────

  users.users.oozenix = {
    isNormalUser = true;

    description = "OozeNix";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      # KDE
      kdePackages.kate
    ];
  };
}