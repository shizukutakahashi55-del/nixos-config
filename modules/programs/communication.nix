{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # Communication
  # ─────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    
<<<<<<< HEAD
  ];

}
=======
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
>>>>>>> 88d085afad65c0e5bd4ceeeee7c62c662616514c
