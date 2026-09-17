{ config, pkgs, inputs, ... }:

{

  # ============================================================================
  #  HYPRLAND
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

    # ==========================================================================
    #  DESKTOP ENVIRONMENT & SHELL (Hyprland Ecosystem)
    # ==========================================================================

    waybar                        # Customizable top/bottom status bar
    swaynotificationcenter        # Notification center and control panel (SwayNC)
    rofi                          # Application launcher and dynamic menu
    wlogout                       # Graphical menu for logout, reboot, and shutdown
    quickshell                    # QML framework for creating custom widgets and interfaces


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

    hyprlock                      # Native screen locker for Hyprland
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