{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    
    # OBS pipeware support
    (obs-studio.override {
      cudaSupport = true;
    })
  ];

  #  NVIDIA libraries
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
  };
}