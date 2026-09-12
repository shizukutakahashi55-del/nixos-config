{ config, pkgs, ... }:

{
  # ─────────────────────────────────────────────
  # PERMISOS Y LICENCIAS
  # ─────────────────────────────────────────────
  # Permite la instalación de paquetes propietarios (como los drivers oficiales de NVIDIA y CUDA).
  nixpkgs.config.allowUnfree = true;

  # ─────────────────────────────────────────────
  # INFRAESTRUCTURA GRÁFICA Y CÓDECS
  # ─────────────────────────────────────────────
  hardware.graphics = {
    # Habilita el soporte para OpenGL, Vulkan y aceleración por hardware.
    enable = true;

    # Habilita librerías gráficas de 32-bit (esencial para juegos de Steam y Proton).
    enable32Bit = true;

    # Paquetes adicionales para traducción de aceleración de video VA-API/VDPAU a drivers de NVIDIA.
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Traductor VA-API a NVDEC para navegadores y reproducciones de video.
      libvdpau-va-gl      # Soporte VDPAU mediante OpenGL.
    ];
  };

  # ─────────────────────────────────────────────
  # VARIABLES DE ENTORNO DEL SISTEMA
  # ─────────────────────────────────────────────
  # Define las variables globales necesarias para forzar a las aplicaciones (como OBS, 
  # navegadores y compositores de pantalla) a detectar y usar la GPU de NVIDIA y sus códecs.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";          # Fuerza el backend de aceleración de video VA-API a NVIDIA.
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Asegura que OpenGL use la implementación de NVIDIA.
    NVD_BACKEND = "direct";               # Optimiza el renderizado directo para drivers de NVIDIA.
  };

  # ─────────────────────────────────────────────
  # DRIVER Y CONFIGURACIÓN DE NVIDIA
  # ─────────────────────────────────────────────
  # Indica al X Server y al sistema gráfico que use los drivers propietarios de NVIDIA.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Requerido para Wayland y compositores modernos (evita tearing y errores de pantalla).
    modesetting.enable = true;

    # Usa los módulos del kernel propietarios en lugar de los módulos open source.
    # Recomendado en 'false' para garantizar la máxima estabilidad con NVENC/CUDA en Turing/Ampere.
    open = false;

    # Habilita la utilidad GUI para ajustar parámetros de la GPU (nvidia-settings).
    nvidiaSettings = true;

    # Selecciona la versión estable del driver dentro del kernel activo.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
