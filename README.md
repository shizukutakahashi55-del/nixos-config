# NixOS Configuration

Personal **NixOS** configuration managed with **Nix Flakes** and a modular `.nix` structure.

> **Important:** this configuration currently **does not use Home Manager**.
> Packages, services, and system configuration are managed directly through NixOS modules.
> User services, such as Tachidesk/Suwayomi, can also be declared from NixOS using `systemd.user.services`.

---

## ✨ Features

- ❄️ NixOS + Nix Flakes
- 🧩 Modular configuration using `.nix` modules
- 🪟 Hyprland + Wayland ecosystem
- 🖥️ KDE Plasma 6 + SDDM
- 🟩 NVIDIA graphics with acceleration and codec support
- 🔊 PipeWire with ALSA, PulseAudio, and 32-bit support
- 🎮 Steam, Lutris, Wine, ProtonPlus, MangoHud, Protontricks, and gaming tools
- 🎥 OBS Studio with CUDA support
- 🌐 NetworkManager + Bluetooth
- 📦 Flatpak + Flathub
- 📖 Suwayomi/Tachidesk as an on-demand user service
- 🛠️ Development tools for Nix, Python, C/C++, and Git
- 💻 Ghostty, Kitty, WezTerm, Foot, Neovim, Zsh, Starship, Yazi, and CLI utilities
- 🌈 Matugen, Waybar, Rofi, Quickshell, and other Hyprland customization tools

---

## 📁 Structure

```text
nixos-config/
├── flake.nix
├── flake.lock
├── configuration.nix
├── hardware-configuration.nix
├── README.md
│
└── modules/
    ├── boot.nix
    ├── networking.nix
    ├── desktop.nix
    ├── audio.nix
    ├── nvidia.nix
    ├── users.nix
    ├── hyprland.nix
    │
    ├── programs/
    │   ├── browsers.nix
    │   ├── communication.nix
    │   ├── development.nix
    │   ├── gaming.nix
    │   ├── kde.nix
    │   ├── media.nix
    │   ├── obs.nix
    │   ├── steam.nix
    │   ├── suwayomi.nix
    │   ├── system.nix
    │   └── terminal.nix
    │
    └── services/
        └── flatpak.nix
```

### Main files

| File | Purpose |
|---|---|
| `flake.nix` | Defines the configuration, external inputs, and the `nixos` host. |
| `flake.lock` | Pins the exact versions of the flake inputs. |
| `configuration.nix` | Main entry point; imports the configuration modules. |
| `hardware-configuration.nix` | Hardware and filesystem configuration specific to the machine. |
| `modules/*.nix` | Configuration split by responsibility. |

---

# 🧩 Modules

## System

### `modules/boot.nix`

Configures:

- systemd-boot
- EFI
- the stable Nixpkgs kernel

### `modules/networking.nix`

Configures:

- NetworkManager
- Bluetooth
- Blueman
- firmware
- hostname
- timezone
- locale
- keyboard layout

Current machine-specific values include:

```text
hostname: nixos
timezone: America/Phoenix
locale:   en_US.UTF-8
keyboard: us
```

Review these values if you reuse this configuration on another machine.

### `modules/users.nix`

Declares the main user:

```text
oozenix
```

with the following groups:

```text
networkmanager
wheel
```

Change the username if you reuse this configuration on another installation.

### `modules/audio.nix`

Configures PipeWire with:

- ALSA
- 32-bit ALSA support
- PulseAudio compatibility
- WirePlumber
- RTKit

---

# 🖥️ Desktop

## `modules/desktop.nix`

Configures general desktop components:

- X11
- SDDM
- printing
- JetBrains Mono fonts
- JetBrains Mono Nerd Font

## `modules/hyprland.nix`

Provides the Hyprland environment through the Hyprland flake input.

Includes:

- Hyprland
- UWSM
- XWayland
- Hyprland XDG Desktop Portal
- Polkit
- Waybar
- Rofi
- Wlogout
- Quickshell
- Hyprpaper
- Hyprshot
- Hyprsunset
- Hyprshutdown
- Hyprsysteminfo
- Hypridle
- Hyprlock
- Matugen
- Waypaper
- awww
- qt6ct
- Cava
- Pavucontrol
- mpvpaper
- grim/slurp
- wl-clipboard
- libnotify
- NetworkManager applet
- Wayland utilities

This module provides the software required by the Hyprland desktop configuration.

> The visual configuration, keybinds, window rules, Waybar configuration, Rofi configuration, etc. can live in your Hyprland dotfiles. This repository primarily provides the environment and required packages through NixOS.

---

# 🟩 NVIDIA

## `modules/nvidia.nix`

Configures the proprietary NVIDIA driver and graphics support for:

- OpenGL
- Vulkan
- 32-bit graphics
- VA-API
- VDPAU
- NVIDIA video acceleration

It also defines environment variables used by applications such as browsers, OBS, and Wayland compositors:

```text
LIBVA_DRIVER_NAME=nvidia
__GLX_VENDOR_LIBRARY_NAME=nvidia
NVD_BACKEND=direct
```

The module uses the stable NVIDIA driver available for the selected kernel.

> **Important:** this module is intended for a machine using NVIDIA graphics. If you use AMD or Intel, adapt or remove this module.

---

# 🎮 Gaming

## `modules/programs/steam.nix`

Configures Steam and uses Millennium as the Steam package.

It also enables the firewall rules required for:

- Steam Remote Play
- Steam Dedicated Server

## `modules/programs/gaming.nix`

Includes gaming tools:

```text
gamemode
lutris
mangohud
prismlauncher
protonplus
wine
protontricks
goverlay
```

---

# 🎥 Multimedia

## `modules/programs/obs.nix`

Installs OBS Studio with CUDA support and configures:

```text
LD_LIBRARY_PATH=/run/opengl-driver/lib
```

to make the required graphics libraries available.

## `modules/programs/media.nix`

Includes:

- MPV
- VLC
- Nomacs

## `modules/programs/communication.nix`

Includes:

- Telegram Desktop
- Spotify
- Vesktop
- Sonora

## `modules/programs/browsers.nix`

Includes:

- Brave
- LibreWolf
- Vivaldi

---

# 📖 Suwayomi / Tachidesk

## `modules/programs/suwayomi.nix`

Suwayomi is manually pinned to:

```text
v2.3.2243
```

using an overlay that downloads the official `.jar` release from GitHub.

The configuration currently **does not use `services.suwayomi-server`** as a system service.

Instead, the server is declared as a **user-level systemd service**:

```text
systemd.user.services.tachidesk
```

This keeps the server stopped until it is needed.

### Commands

```bash
tachidesk start
tachidesk stop
tachidesk restart
tachidesk status
```

You can also inspect the service directly with systemd:

```bash
systemctl --user status tachidesk.service
```

The service has no `wantedBy`, so it **does not start automatically when the system boots**.

When running, Suwayomi is normally available at:

```text
http://localhost:4567
```

> The configuration is prepared for a future Rofi launcher/toggle that can start and stop Suwayomi directly from the desktop.

---

# 💻 Terminal & CLI

## `modules/programs/terminal.nix`

Includes:

- Ghostty
- Kitty
- WezTerm
- Foot
- Neovim
- Zsh
- Starship
- Yazi
- btop
- eza
- fastfetch
- fd
- fzf
- ripgrep

## `modules/programs/system.nix`

Additional utilities:

- jq
- playerctl
- swayosd

---

# 🛠️ Development

## `modules/programs/development.nix`

Includes development and NixOS administration tools:

```text
git
gh
lazygit
curl
wget
direnv
nix-direnv
nixd
nixfmt-rfc-style
nix-search-cli
vscodium
python3
pip
uv
ruff
gcc
gnumake
cmake
pkg-config
jdk17
jdk21
```

It also includes Qt-related and AppImage tools.

---

# 📦 Flatpak

## `modules/services/flatpak.nix`

Enables Flatpak and automatically registers Flathub through a systemd service.

After applying the configuration, verify it with:

```bash
flatpak remotes
```

---

# 🔗 Flake Inputs

`flake.nix` uses several external inputs:

- `nixpkgs` — NixOS and package base
- `millennium` — Steam Millennium
- `kwin-effects-better-blur-dx` — KWin effect
- `prismlauncher` — Prism Launcher
- `sonora` — Spotify client
- `hyprland` — Hyprland and its portal

Exact input versions are stored in:

```text
flake.lock
```

To update the inputs:

```bash
nix flake update
```

Review the changes before applying them to the system.

---

# 🚀 Installation

## 1. Clone the repository

```bash
git clone <REPOSITORY_URL>
cd nixos-config
```

If the repository is already cloned:

```bash
cd nixos-config
```

---

## 2. Review the hardware configuration

`hardware-configuration.nix` is specific to the machine where it was generated.

Do not blindly reuse it on another computer.

To generate a new hardware configuration:

```bash
sudo nixos-generate-config
```

If installing from scratch, review the generated files before applying the configuration.

---

## 3. Review machine-specific settings

Before running `nixos-rebuild`, review at least:

```text
modules/users.nix
modules/networking.nix
modules/nvidia.nix
hardware-configuration.nix
flake.nix
```

In particular, check:

- username
- hostname
- timezone
- keyboard layout
- GPU
- filesystem configuration
- disk UUIDs
- the host name defined in `flake.nix`

---

## 4. Check the flake

From the repository root:

```bash
nix flake check
```

You can also test the configuration without switching to it:

```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

This helps catch evaluation and build errors before applying the configuration.

---

## 5. Apply the configuration

```bash
sudo nixos-rebuild switch --flake .#nixos
```

The `nixos` host corresponds to:

```nix
nixosConfigurations.nixos
```

in `flake.nix`.

---

# 🔄 Updating the System

First update the flake inputs:

```bash
nix flake update
```

Then test the configuration:

```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

Finally apply it:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

NixOS keeps system generations, allowing you to return to an earlier configuration if needed.

---

# ↩️ Rolling Back

List the available system generations:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

You can also reboot and select an older generation from systemd-boot.

To switch back to the previous generation from the current system:

```bash
sudo nixos-rebuild switch --rollback
```

---

# 🧹 Cleaning the Nix Store

To remove old generations:

```bash
sudo nix-collect-garbage -d
```

> Do not run this if you still need old generations for rollback.

You can check the size of the Nix store with:

```bash
du -sh /nix/store
```

---

# 🏠 Home Manager

This configuration **currently does not use Home Manager**.

Packages and system configuration are managed directly through NixOS, primarily using:

```nix
environment.systemPackages
```

User-level services can also be declared directly from NixOS modules. For example, Tachidesk uses:

```nix
systemd.user.services.tachidesk
```

Therefore, Home Manager is not required to use this repository.

If Home Manager is added in the future, it would make sense to clearly separate:

- system configuration → NixOS
- user packages/configuration → Home Manager
- Hyprland visual configuration → dotfiles

For now, the repository is intentionally designed to work without Home Manager.

---

# ⚠️ Before Reusing This Configuration

This configuration was created for a specific machine. Before using it elsewhere, review at least:

### Hardware

```text
hardware-configuration.nix
modules/nvidia.nix
```

### User

```text
modules/users.nix
```

### Networking and localization

```text
modules/networking.nix
```

### Flake / host

```text
flake.nix
```

The current host is:

```text
nixos
```

and is built with:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### External inputs

Some modules depend on external flakes. If one of them changes, becomes outdated, or stops working, the configuration may need to be adapted.

---

# 📌 Recommended Workflow

For normal configuration changes:

```bash
# 1. Edit the configuration
$EDITOR modules/some-module.nix

# 2. Check the flake
nix flake check

# 3. Test the build
sudo nixos-rebuild dry-build --flake .#nixos

# 4. Apply the configuration
sudo nixos-rebuild switch --flake .#nixos

# 5. Check for failed services
systemctl --failed
```

To update dependencies:

```bash
nix flake update
sudo nixos-rebuild dry-build --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

---

## 🗂️ Configuration Philosophy

The main goal is to keep `configuration.nix` small and organize the system into independent modules:

```text
configuration.nix
       │
       ├── system
       │    ├── boot
       │    ├── networking
       │    ├── audio
       │    ├── nvidia
       │    └── users
       │
       ├── desktop
       │    ├── KDE
       │    └── Hyprland
       │
       ├── programs
       │    ├── terminal
       │    ├── gaming
       │    ├── browsers
       │    ├── development
       │    ├── media
       │    ├── Steam
       │    └── Suwayomi
       │
       └── services
            └── Flatpak
```

This means that adding or removing software usually only requires changing the corresponding module instead of turning `configuration.nix` into one large file.

---

## 📄 License

This is a personal configuration. If you reuse parts of it, also review the licenses and terms of the external projects used by the flake inputs.
