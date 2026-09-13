# ❄️ NixOS Configuration (Flakes)

Configuración modular y declarativa de NixOS gestionada con **Nix Flakes**, **Git** y **KDE Plasma**.

---

## 📂 Estructura del Repositorio

```text
├── flake.nix                  # Punto de entrada de la Flake y dependencias
├── flake.lock                 # Versiones bloqueadas de las fuentes (inputs)
├── configuration.nix          # Módulo principal e importaciones del sistema
├── hardware-configuration.nix # Detección autogenerada de componentes y discos
└── modules/
    ├── audio.nix              # Configuración de PipeWire
    ├── boot.nix               # Gestor de arranque (GRUB/Systemd-boot)
    ├── desktop.nix            # Entorno gráfico y servidor de despliegue
    ├── networking.nix         # Redes y firewall
    ├── nvidia.nix             # Controladores y parámetros de GPU
    ├── users.nix              # Usuarios y permisos
    ├── programs/              # Aplicaciones de usuario y entorno
    │   ├── browsers.nix
    │   ├── communication.nix
    │   ├── development.nix
    │   ├── gaming.nix
    │   ├── kde.nix
    │   ├── obs.nix
    │   ├── steam.nix
    │   ├── suwayomi.nix        # Servidor de manga con overlay v2.3.2243
    │   ├── system.nix
    │   └── terminal.nix
    └── services/              # Servicios de sistema
        └── flatpak.nix        # Integración con Flathub


## Instalación

> **Nota:** Antes de empezar, asegúrate de tener `git` instalado en el sistema. Si no lo tienes, instálalo con:
> ```bash
> nix-shell -p git
> ```
> o agrégalo temporalmente a tu configuración antes de continuar.

### 1. Clonar el repositorio

```bash
git clone https://github.com/shizukutakahashi55-del/nixos-config.git ~/nixos-config
cd ~/nixos-config
```

### 2. Reemplazar/Copiar la configuración de hardware

> **Importante:** Cada PC tiene componentes y discos distintos. Debes mantener el `hardware-configuration.nix` generado por la nueva máquina.

```bash
cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
```

### 3. Registrar el archivo en Git

```bash
git add hardware-configuration.nix
```

### 4. Aplicar la configuración
> Nota: Asegúrate de estar ubicado en la carpeta ~/nixos-config antes de ejecutar este comando.
> Reemplaza #nixos por el host de tu maquina.

```bash
sudo nixos-rebuild switch --flake .#nixos
```
