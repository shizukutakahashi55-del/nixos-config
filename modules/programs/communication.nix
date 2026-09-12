{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    discord
    
    # OBS empaquetado con soporte Nvidia
    (obs-studio.override {
      cudaSupport = true;
    })
  ];

  # Inyecta las librerías de NVIDIA registradas por el sistema
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
  };
}
