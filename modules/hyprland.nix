{ config, pkgs, inputs, ... }:

{
  # ============================================================================
  # HYPRLAND & HYPR ECOSYSTEM
  # ============================================================================

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}
        .xdg-desktop-portal-hyprland;
  };

  # Screen locker
  programs.hyprlock.enable = true;

  # Idle / power management
  # programs.hypridle.enable = true;

  # XDG desktop portal for Hyprland
  systemd.user.services."xdg-desktop-portal-hyprland" = {
    environment = {
      QT_STYLE_OVERRIDE = "Fusion";
    };
  };

  # ============================================================================
  # POLKIT
  # ============================================================================

  security.polkit.enable = true;


  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================

  environment.systemPackages = with pkgs; [

    # --------------------------------------------------------------------------
    # QUICKSHELL
    # --------------------------------------------------------------------------

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
    #   HYPRLAND ECOSYSTEM
    # ==========================================================================

    hyprpaper
    hyprshot
    hyprsunset
    hyprshutdown
    hyprsysteminfo
    hypridle
    

    # ==========================================================================
    # DESKTOP 
    # ==========================================================================

    waybar
    rofi
    wlogout

    # ==========================================================================
    # WALLPAPERS / THEMING
    # ==========================================================================

    awww
    waypaper
    matugen
    qt6Packages.qt6ct

    # ==========================================================================
    # POLKIT / SESSION
    # ==========================================================================

    kdePackages.polkit-kde-agent-1
    

    # ==========================================================================
    # AUDIO / MULTIMEDIA
    # ==========================================================================

    pavucontrol
    cava
    ffmpeg
    mpvpaper
    socat

    # ==========================================================================
    # SCREENSHOTS / CLIPBOARD
    # ==========================================================================

    grim
    slurp
    wl-clipboard

    # ==========================================================================
    # NOTIFICATIONS / SYSTEM UTILITIES
    # ==========================================================================

    libnotify
    networkmanagerapplet
    imagemagick

    # ==========================================================================
    # WAYLAND UTILITIES
    # ==========================================================================

    wtype
    wev
  ];
}