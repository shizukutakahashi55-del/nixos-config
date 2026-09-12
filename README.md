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
```bash
sudo nixos-rebuild switch --flake .#nixos
```
