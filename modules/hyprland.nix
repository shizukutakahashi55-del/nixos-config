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

  # If you want to enable PAM instead of program module,
  # you can use this instead:
  # security.pam.services.hyprlock = {};


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
    swaynotificationcenter        # Notification center and control panel (SwayNC)
    rofi                          # Application launcher and dynamic menu
    wlogout                       # Graphical menu for logout, reboot, and shutdown


    # ==========================================================================
    #  WALLPAPER MANAGEMENT & AESTHETICS (Matugen / Wallpapers)
    # ==========================================================================

    hyprpaper                     # Wallpaper management daemon for Hyprland
    waypaper                      # GUI for easily changing wallpapers
    matugen                       # Dynamic color palette generator (Material You)
    qt6Packages.qt6ct             # Theme configuration tool and integration for Qt6


    # ==========================================================================
    #  SCREEN LOCKING & POWER / SESSION MANAGEMENT
    # ==========================================================================

    # hyprlock no hace falta aquí ya que `programs.hyprlock.enable = true` lo instala automáticamente.
    hypridle                      # Daemon for sleep, screen timeout, and inactivity
    kdePackages.polkit-kde-agent-1 # Polkit authentication agent


    # ==========================================================================
    #  AUDIO & MULTIMEDIA CONTROL
    # ==========================================================================

    pavucontrol                   # PipeWire/PulseAudio volume control
    cava                          # Real-time audio visualizer


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

  ];

}