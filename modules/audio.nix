{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # PipeWire
  # ─────────────────────────────────────────────

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    # JACK
    # jack.enable = true;

    # WirePlumber
    # wireplumber.enable = true;
  };
}