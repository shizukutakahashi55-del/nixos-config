{ config, pkgs, ... }:

{

  # ─────────────────────────────────────────────
  # GRAPHICS INFRASTRUCTURE AND CODECS
  # ─────────────────────────────────────────────
  hardware.graphics = {
    # Enables support for OpenGL, Vulkan, and hardware acceleration.
    enable = true;

    # Enables 32-bit graphics libraries (essential for Steam and Proton games).
    enable32Bit = true;

    # Additional packages for translating VA-API/VDPAU video acceleration to NVIDIA drivers.
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # VA-API to NVDEC translator for browsers and video playback.
      libvdpau-va-gl      # VDPAU support through OpenGL.
    ];
  };

  # ─────────────────────────────────────────────
  # SYSTEM ENVIRONMENT VARIABLES
  # ─────────────────────────────────────────────
  # Defines the global variables required to force applications (such as OBS,
  # browsers, and screen compositors) to detect and use the NVIDIA GPU and its codecs.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";          # Forces the VA-API video acceleration backend to NVIDIA.
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Ensures that OpenGL uses the NVIDIA implementation.
    NVD_BACKEND = "direct";               # Optimizes direct rendering for NVIDIA drivers.
  };

  # ─────────────────────────────────────────────
  # NVIDIA DRIVER AND CONFIGURATION
  # ─────────────────────────────────────────────
  # Tells the X Server and graphics system to use the proprietary NVIDIA drivers.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for Wayland and modern compositors (prevents tearing and display issues).
    modesetting.enable = true;

    # Uses proprietary kernel modules instead of open source modules.
    # Recommended as 'false' to ensure maximum stability with NVENC/CUDA on Turing/Ampere.
    open = false;

    # Enables the GUI utility for adjusting GPU parameters (nvidia-settings).
    nvidiaSettings = true;

    # Selects the stable driver version within the active kernel.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}