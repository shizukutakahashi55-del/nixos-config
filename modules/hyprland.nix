{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [

# ============================================================================
  #  DESKTOP ENVIRONMENT & SHELL (Hyprland Ecosystem)
  # ============================================================================
  waybar                        # Customizable top/bottom status bar
  swaynotificationcenter        # Notification center and control panel (SwayNC)
  rofi                          # Application launcher and dynamic menu
  wlogout                       # Graphical menu for logout, reboot, and shutdown
  quickshell                    # QML framework for creating custom widgets and interfaces

  # ============================================================================
  #  WALLPAPER MANAGEMENT & AESTHETICS (Matugen / Wallpapers)
  # ============================================================================
  hyprpaper                     # Wallpaper management daemon for Hyprland
  waypaper                      # GUI for easily changing wallpapers
  matugen                       # Dynamic color palette generator (Material You)
  qt6Packages.qt6ct             # Theme configuration tool and integration for Qt6

  # ============================================================================
  #  SCREEN LOCKING & POWER / SESSION MANAGEMENT
  # ============================================================================
  hyprlock                      # Native screen locker utility for Hyprland
  hypridle                      # Daemon for sleep, screen timeout, and inactivity
  kdePackages.polkit-kde-agent-1 # Polkit authentication agent (root password prompts)

  # ============================================================================
  #  AUDIO & MULTIMEDIA CONTROL
  # ============================================================================
  pavucontrol                   # Graphical volume control and mixer for PipeWire/PulseAudio
  cava                          # Real-time audio visualizer for terminal or bar
  waybar-mpris                  # MPRIS module/integration to show media player in Waybar

  # ============================================================================
  #  SCREENSHOTS & CLIPBOARD
  # ============================================================================
  grim                          # Screenshot utility for Wayland
  slurp                         # On-screen region selector (used alongside grim)
  wl-clipboard                  # Clipboard management utilities (`wl-copy`, `wl-paste`)

  # ============================================================================
  #  SYSTEM UTILITIES & NOTIFICATIONS
  # ============================================================================
  awww                          # Lightweight wallpaper/animated background daemon for Wayland (Wayland Wallpaper Wizard)
  libnotify                     # Library and command (`notify-send`) for sending notifications
  networkmanagerapplet          # Tray icon and manager for Wi-Fi/Ethernet networks (`nm-applet`)
  imagemagick                   # Image manipulation and conversion CLI utility (useful for scripts)
  ];
}