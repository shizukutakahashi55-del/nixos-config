# ❄️ NixOS Configuration (Flakes) + NVIDIA

Configuración modular y declarativa de **NixOS** gestionada con **Nix Flakes**, **Git** y **KDE Plasma**.

---

## 📂 Estructura del repositorio

```text
nixos-config/
├── flake.nix                   # Punto de entrada de la Flake y dependencias
├── flake.lock                  # Versiones bloqueadas de las fuentes (inputs)
├── configuration.nix           # Módulo principal e importaciones del sistema
├── hardware-configuration.nix  # Configuración autogenerada de hardware y discos
└── modules/
    ├── audio.nix               # Configuración de PipeWire
    ├── boot.nix                # Gestor de arranque
    ├── desktop.nix             # Entorno gráfico y escritorio
    ├── networking.nix          # Red y firewall
    ├── nvidia.nix              # Controladores y configuración de NVIDIA
    ├── users.nix               # Usuarios y permisos
    │
    ├── programs/               # Aplicaciones y entorno de usuario
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
    │
    └── services/               # Servicios del sistema
        └── flatpak.nix          # Integración con Flathub
```

---

## 🚀 Instalación

> **Nota:** Antes de comenzar, asegúrate de tener `git` instalado en el sistema.

Si no tienes Git disponible, puedes instalarlo temporalmente con:

```bash
nix-shell -p git
```

También puedes agregarlo permanentemente a tu configuración de NixOS.

### 1. Clonar el repositorio

```bash
git clone https://github.com/shizukutakahashi55-del/nixos-config.git ~/nixos-config
cd ~/nixos-config
```

### 2. Configurar el hardware

> **Importante:** `hardware-configuration.nix` es específico para cada máquina, ya que contiene información sobre sus discos, sistemas de archivos y hardware.
>
> **No debes reutilizar el archivo de otra PC.**

OJO, ESTE COMANDO ES SOLO SI HACES LA INSTALACION DE CERO, Si usaste la instalacion graph omite este comando y pasa al siguiente.
Genera el archivo correspondiente a tu instalación y reemplaza el del repositorio: 

```bash
sudo nixos-generate-config
```

Después, copia el archivo generado:

```bash
cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
```

### 3. Agregar los cambios a Git

```bash
git add hardware-configuration.nix
```

Si estás configurando una máquina nueva y modificaste otros archivos:

```bash
git add .
```

### 4. Aplicar la configuración

Asegúrate de estar dentro del repositorio:

```bash
cd ~/nixos-config
```

Después ejecuta:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

> **Nota:** `nixos` corresponde al nombre del host definido en `flake.nix`.
>
> Si tu máquina utiliza otro nombre de host, reemplaza `nixos` por el nombre correspondiente.

---

## 🔄 Actualizar el sistema

Para actualizar los inputs de la Flake:

```bash
nix flake update
```

Después aplica la nueva configuración:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

---

## 🧪 Probar cambios sin hacerlos permanentes

Puedes probar una configuración antes de cambiar el sistema activo:

```bash
sudo nixos-rebuild test --flake .#nixos
```

Esto permite comprobar cambios y detectar errores antes de utilizar `switch`.

---

## 📌 Características

* ❄️ **NixOS** con configuración declarativa
* 🧩 Configuración modular
* ❄️ **Nix Flakes** para gestionar dependencias
* 🖥️ **KDE Plasma**
* 🎮 Configuración para gaming
* 🎥 **OBS Studio**
* 🟩 **NVIDIA**
* 🔊 **PipeWire**
* 📦 **Flatpak / Flathub**
* 🌐 Configuración de red y firewall
* 🛠️ Herramientas de desarrollo
* 🐧 Configuración de terminal y herramientas del sistema

---

## ⚠️ Consideraciones

Esta configuración está diseñada principalmente para mi propio sistema, por lo que algunos módulos pueden requerir modificaciones antes de utilizarse en otra máquina.

En particular, revisa:

* `hardware-configuration.nix`
* `modules/nvidia.nix`
* `modules/users.nix`
* `modules/networking.nix`
* El nombre del host definido en `flake.nix`

No ejecutes esta configuración directamente en una máquina de producción sin revisar primero los módulos y dispositivos específicos del sistema.
