{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [

# ============================================================================
  #  ENTORNO DE ESCRITORIO & SHELL (Hyprland Ecosistema)
  # ============================================================================
  waybar                        # Barra de estado superior/inferior personalizable
  swaynotificationcenter        # Centro de notificaciones y panel de control (SwayNC)
  rofi                          # Lanzador de aplicaciones y menú dinámico
  wlogout                       # Menú gráfico para cerrar sesión, reiniciar y apagar
  quickshell                    # Framework de QML para crear widgets e interfaces personalizadas

  # ============================================================================
  #  GESTIÓN DE FONDOS DE PANTALLA Y ESTÉTICA (Matugen / Wallpapers)
  # ============================================================================
  hyprpaper                     # Daemon de gestión de fondos de pantalla para Hyprland
  waypaper                      # GUI para cambiar fondos de pantalla fácilmente
  matugen                       # Generador de paletas de colores dinámicas (Material You)
  qt6Packages.qt6ct             # Herramienta de configuración de temas e integración para Qt6

  # ============================================================================
  #  BLOQUEO DE PANTALLA & GESTIÓN DE ENERGÍA / SESIÓN
  # ============================================================================
  hyprlock                      # Utilidad para bloqueo de pantalla nativo de Hyprland
  hypridle                      # Daemon para suspensión, apagado de pantalla e inactividad
  kdePackages.polkit-kde-agent-1 # Agente de autenticación Polkit (ventanas de contraseña root)

  # ============================================================================
  #  AUDIO & CONTROL MULTIMEDIA
  # ============================================================================
  pavucontrol                   # Mezclador y control de volumen gráfico para PipeWire/PulseAudio
  cava                          # Visualizador de audio en tiempo real para terminal o barra
  waybar-mpris                  # Módulo/Integración MPRIS para mostrar reproductor en Waybar

  # ============================================================================
  #  CAPTURAS DE PANTALLA Y PORTAPAPELES
  # ============================================================================
  grim                          # Herramienta para tomar capturas de pantalla en Wayland
  slurp                         # Seleccionador de regiones en pantalla (usado junto a grim)
  wl-clipboard                  # Utilidades para gestión del portapapeles (`wl-copy`, `wl-paste`)

  # ============================================================================
  #  UTILIDADES DE SISTEMA & NOTIFICACIONES
  # ============================================================================
  awww                          # Daemon ligero de wallpaper/fondos animados para Wayland (Wayland Wallpaper Wizard)
  libnotify                     # Biblioteca y comando (`notify-send`) para enviar notificaciones
  networkmanagerapplet          # Icono de bandeja y gestor de redes Wi-Fi/Ethernet (`nm-applet`)
  imagemagick                   # Manipulación y conversión de imágenes desde comandos (util en scripts)
  ];
}