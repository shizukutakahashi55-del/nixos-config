{ config, pkgs, inputs, ... }:

{

  # ============================================================================
  #  HYPRLAND & SCREEN LOCKER
  # ============================================================================

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Generates /etc/pam.d/hyprlock & enables pass authentication.
  programs.hyprlock.enable = true;

  systemd.user.services."xdg-desktop-portal-hyprland" = {
    environment = {
      QT_STYLE_OVERRIDE = "Fusion";
    };
  };

  # ============================================================================
  #  POLKIT
  # ============================================================================

  security.polkit.enable = true;

  # ============================================================================
  #  SYSTEM PACKAGES
  # ============================================================================

  environment.systemPackages = with pkgs; [

    # Quickshell wrapper with QML modules
    (symlinkJoin {
      name = "quickshell-wrapped";
      paths = [ quickshell ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/quickshell \
          --prefix QML2_IMPORT_PATH : "${qt6.qtdeclarative}/${qt6.qtbase.qtQmlPrefix}"
      '';
    })

    # ==========================================================================
    #  DESKTOP ENVIRONMENT & SHELL (Hyprland Ecosystem)
    # ==========================================================================

    waybar                        # Customizable top/bottom status bar
    rofi                          # Application launcher and dynamic menu
    wlogout                       # Graphical menu for logout, reboot, and shutdown


    # ==========================================================================
    #  WALLPAPER MANAGEMENT & AESTHETICS (Matugen / Wallpapers / Color Extraction)
    # ==========================================================================

    hyprpaper                     # Wallpaper management daemon for Hyprland
    waypaper                      # GUI for easily changing wallpapers
    matugen                       # Dynamic color palette generator (Material You)
    qt6Packages.qt6ct             # Theme configuration tool and integration for Qt6
    hyprpicker                    # Pipeta de color interactiva para Wayland/Hyprland


    # ==========================================================================
    #  SCREEN LOCKING & POWER / SESSION MANAGEMENT
    # ==========================================================================

    hypridle                      # Daemon for sleep, screen timeout, and inactivity
    kdePackages.polkit-kde-agent-1 # Polkit authentication agent


    # ==========================================================================
    #  AUDIO & MULTIMEDIA CONTROL
    # ==========================================================================

    pavucontrol                   # PipeWire/PulseAudio volume control
    cava                          # Real-time audio visualizer
    ffmpeg                        # Procesamiento de imágenes/videos para extracción de frames


    # ==========================================================================
    #  SCREENSHOTS & CLIPBOARD
    # ==========================================================================

    grim                          # Screenshot utility for Wayland
    slurp                         # On-screen region selector
    wl-clipboard                  # Clipboard management utilities


    # ==========================================================================
    #  SYSTEM UTILITIES & NOTIFICATIONS
    # ==========================================================================

    awww                          # Wayland Wallpaper Wizard
    libnotify                     # notify-send and notification library
    networkmanagerapplet          # NetworkManager tray applet
    imagemagick                   # Image manipulation utilities
    jq                            # Procesamiento de JSON (requerido para scripts de Hyprland/Quickshell)
    python3Packages.colorthief    # Extracción automática de paletas desde imágenes/video

  ];

}