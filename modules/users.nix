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

  };
}