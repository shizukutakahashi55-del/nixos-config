# ❄️ NixOS Configuration (Flakes) + NVIDIA

Modular, declarative **NixOS** configuration, managed with **Nix Flakes**, **Git**, and **KDE Plasma**, on an **NVIDIA** GPU.

> This repository covers **system-level** configuration (packages, drivers, services, hardware). User-level configuration (Hyprland, Waybar, Rofi, themes, etc.) lives separately in [dotfiles-nix](https://github.com/shizukutakahashi55-del/dotfiles-nix).

---

## 🚀 Installation

> **Requirement:** you need `git`. If you don't have it: `nix-shell -p git` (temporary), or add it permanently to your NixOS configuration.

### 1. Clone the repository

```bash
git clone https://github.com/shizukutakahashi55-del/nixos-config.git ~/nixos-config
cd ~/nixos-config
```

### 2. Generate your `hardware-configuration.nix`

> **Important:** this file is specific to each machine (disks, filesystems, hardware). **Don't reuse the one from another PC.**

* **Fresh install (minimal ISO):** generate the file and replace the one in the repo:

  ```bash
  sudo nixos-generate-config
  cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
  ```

* **Graphical install (Calamares or another GUI installer):** you'll usually already have a `hardware-configuration.nix` generated at `/etc/nixos/`. Skip the command above and just copy it the same way (`cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix`) before continuing.

### 3. Stage the changes in Git

```bash
git add hardware-configuration.nix
```

If it's a new machine and you also modified other modules:

```bash
git add .
```

### 4. Apply the configuration

```bash
cd ~/nixos-config
sudo nixos-rebuild switch --flake .#nixos
```

> `nixos` is the hostname defined in `flake.nix` (`nixosConfigurations.nixos`) and in `modules/networking.nix` (`networking.hostName`). If you use a different hostname, update **both** files and replace `nixos` with that name in the command.

---

## 🔄 Updating the system

```bash
nix flake update                          # updates the flake inputs
sudo nixos-rebuild switch --flake .#nixos # applies the new configuration
```

## 🧪 Testing changes without making them permanent

```bash
sudo nixos-rebuild test --flake .#nixos
```

Applies the configuration only until the next reboot, so you can catch errors before using `switch`.

---

## 📂 Repository structure

```text
nixos-config/
├── flake.nix                   # Flake entry point and external inputs
├── flake.lock                  # Locked versions of the inputs
├── configuration.nix           # Main module: imports everything else
├── hardware-configuration.nix  # Auto-generated, machine-specific
└── modules/
    ├── audio.nix                # PipeWire (ALSA + 32-bit + Pulse compat)
    ├── boot.nix                 # systemd-boot + stable kernel
    ├── desktop.nix               # X11, KDE Plasma 6, SDDM, printing, fonts
    ├── hyprland.nix              # Hyprland + ecosystem (see detail below)
    ├── networking.nix            # Bluetooth, NetworkManager, hostname, timezone, keyboard
    ├── nvidia.nix                 # Proprietary drivers, VA-API/VDPAU, environment variables
    │                              # ⚠️ See "NVIDIA environment variables" note below —
    │                              # these can overlap with dotfiles-nix's Hyprland env config.
    ├── users.nix                  # System user and personal packages
    │
    ├── programs/
    │   ├── browsers.nix          # Firefox, Brave, Chromium, LibreWolf
    │   ├── communication.nix     # Discord, Telegram, Spotify
    │   ├── development.nix       # See "Development packages" below
    │   ├── gaming.nix             # Gamemode, Lutris, MangoHud, PrismLauncher, ProtonPlus, Wine
    │   ├── kde.nix                 # Kvantum + improved KWin blur (external flake)
    │   ├── obs.nix                  # OBS Studio with CUDA support (NVIDIA)
    │   ├── spicetify.nix            # Spotify with Catppuccin Mocha theme via spicetify-nix
    │   ├── steam.nix                # Steam (Millennium client), Remote Play, dedicated server
    │   ├── suwayomi.nix             # Suwayomi manga server, pinned to v2.3.2243
    │   ├── system.nix               # CLI utilities (jq)
    │   └── terminal.nix             # Alacritty, Kitty, Zsh, Starship, Fastfetch, eza, fd, fzf, ripgrep, vim
    │
    └── services/
        └── flatpak.nix            # Flatpak + Flathub repo added automatically
```

### Hyprland (`modules/hyprland.nix`)

Installs Hyprland (with UWSM and XWayland) and the whole ecosystem consumed by the [dotfiles](https://github.com/shizukutakahashi55-del/dotfiles-nix): Waybar, SwayNC, Rofi, Wlogout, QuickShell, Hyprpaper, Waypaper, Matugen, Hyprlock, Hypridle, Cava, screenshot tools (grim/slurp), Wayland clipboard, and more. If you're going to use the dotfiles, this is the module that provides the packages they configure.

### NVIDIA environment variables (`modules/nvidia.nix`)

This module sets, among other things, the following system-wide environment variables so applications (OBS, browsers, screen compositors) correctly detect and use the NVIDIA GPU and its codecs:

```nix
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
```

> ⚠️ **Possible duplication if you also use `dotfiles-nix`:** `environment.sessionVariables` writes these variables to `/etc/set-environment`, loaded via PAM for normal login sessions. Depending on how Hyprland is launched (systemd user session, greetd/tuigreet, a graphical display manager, or `Hyprland` straight from a TTY), the compositor doesn't always reliably inherit that environment — which is why the Hyprland config in `dotfiles-nix` (under `.config/hypr/modules/hardware/`) commonly re-declares the *same* three variables via `env = VAR,value` lines.
>
> This isn't necessarily a bug — it's a defensive redundancy that's common in Hyprland+NVIDIA setups precisely because propagation of `environment.sessionVariables` to the compositor isn't guaranteed across every startup path. But it **is** a maintenance risk: if you change a value on one side and forget the other, you'll get inconsistent behavior that's hard to diagnose (e.g. VA-API working for apps launched from a terminal but not from the Hyprland launcher, or vice versa). If you keep both, make sure the **values match exactly** on both sides — or pick one as the single source of truth and comment out the other.

### Development packages (`modules/programs/development.nix`)

```text
curl · direnv · git · gh · lazygit · python3 + pip
vscodium · nixd · nixfmt-rfc-style · nix-direnv
nix-search-cli · ruff · tree · uv · wget
```

> `nix-search-cli` is precisely the optional dependency used by the package-search keybind in the dotfiles (`nix-rofi`) — it's already included here.

---

## 📌 Features

* ❄️ Declarative NixOS, managed with **Nix Flakes**
* 🧩 Modular configuration (one file per responsibility)
* 🖥️ **KDE Plasma 6** + SDDM, with Kvantum and improved KWin blur
* 🪟 **Hyprland** with the full ecosystem (Waybar, Rofi, SwayNC, QuickShell...)
* 🟩 **NVIDIA**: proprietary drivers, VA-API/VDPAU, variables for OBS/browsers
* 🔊 **PipeWire** (ALSA + 32-bit support for gaming)
* 🎮 Gaming: Steam (Millennium), Lutris, Wine, PrismLauncher, MangoHud
* 🎥 OBS Studio with CUDA acceleration
* 🎵 Spotify + Spicetify (Catppuccin Mocha theme)
* 📖 Suwayomi manga server (port 4567)
* 📦 Flatpak / Flathub
* 🌐 Network, Bluetooth, timezone (`America/Phoenix` by default) and keyboard, all configurable
* 🛠️ Full development environment (see above)

---

## ⚠️ Considerations

This configuration is built for my own machine; before using it on another one, review especially:

* `hardware-configuration.nix` — always regenerate, never reuse
* `modules/nvidia.nix` — assumes an NVIDIA GPU; on AMD/Intel, remove or adapt this module (see the environment-variable note above too)
* `modules/users.nix` — hardcoded `oozenix` user, replace it with your own
* `modules/networking.nix` — hostname `nixos`, timezone `America/Phoenix`, keyboard `us`
* The hostname in `flake.nix` (`nixosConfigurations.nixos`) must match `networking.hostName` and the `--flake .#<host>` flag
* `modules/programs/steam.nix` and `modules/programs/kde.nix` depend on third-party external flakes (Millennium, kwin-effects-better-blur-dx) — check that they're still maintained before using them

Don't apply this configuration directly on a production machine without first reviewing the modules and the specific system hardware.
