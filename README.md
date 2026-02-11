<p align="center"><img src="https://i.imgur.com/X5zKxvp.png" width=300px></p>

# 🌟 blob's NixOS Configuration

A modular, customizable NixOS configuration using Flakes that features multiple hosts and window managers.

#### ⚠️ Warning
This setup is modular but still tailored to my personal environment. While I don't recommend using it directly as a plug-and-play solution, you're welcome to copy and adapt specific parts that suit your needs.

## 🚀 Programs

- **Window Managers/Compositors**:
  - [Hyprland](https://hyprland.org/)
  - [Niri](https://github.com/sodiboo/niri-flake)
- **Terminal Emulators**:
  - [Kitty](https://sw.kovidgoyal.net/kitty/)
  - [WezTerm](https://wezfurlong.org/wezterm/)
- **Text Editors**:
  - [NixVim](https://github.com/nix-community/nixvim)
  - [VSCode](https://code.visualstudio.com/)
- **Shell**: [ZSH](https://ohmyz.sh/)
- **Application Launcher**: [Rofi](https://github.com/davatorium/rofi)
- **Status Bar**: [noctalia shell](https://github.com/noctalia-dev/noctalia-shell)
- **Theming**: [Stylix](https://github.com/danth/stylix)

## ✅ Requirements

- Nix with Flakes enabled
- `git` and `gpg` (optional for signing)
- A target host definition under `hosts/`

## ⚙️ Installation / Bootstrap

1. Generate SSH key (optional for GitHub):
   ```
   ssh-keygen -t ed25519 -C "your_email@example.com"
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

2. Clone:
   ```
   git clone https://github.com/blob5/nixos-config.git
   or
   git clone git@github.com:blob5/nixOS-config.git
   cd nixos-config
   ```

3. Create or copy a host:
   ```
   # copy the template and rename it
   cp -r hosts/template hosts/<name>
   ```

4. Generate hardware config and move it into the host:
   ```
   sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix
   ```

5. Update host settings:
   ```
   # edit the target host settings before building
   $EDITOR hosts/<name>/settings.nix
   ```

6. Build for a host (examples):
   ```
   sudo nixos-rebuild switch --flake .#navi
   sudo nixos-rebuild switch --flake .#cyberia
   ```

7. (Optional) Generate GPG key:
   ```
   gpg --full-generate-key
   ```


## 🧭 Hosts Overview

| Host     | Type    | Notes |
|----------|---------|------|
| `navi`   | Desktop | Hyprland / AMD |
| `cyberia`| Laptop  | Niri / AMD |
| `core`   | Server  | Headless |
| `cache`  | Laptop  | Legacy |

> Details live in `hosts/<name>/configuration.nix` and `hosts/<name>/settings.nix`.

## 📁 Project Structure

My configuration is organized into logical directories to make maintenance and customization straightforward:

```
.
├── flake.nix             # Main flake configuration
├── dev-shells            # Development shells
├── hosts/                # Host-specific configurations
│   ├── cyberia/          # Laptop
│   ├── navi/             # Desktop
│   ├── core/             # Server
│   └── cache/            # Old Laptop
├── modules/              # Modular configuration components
│   ├── core/             # Core system configurations
│   ├── desktop/          # Desktop environment configurations
│   ├── drivers/          # Hardware drivers (AMD, NVIDIA)
│   ├── packages/         # Packages and configurations
│   ├── programs/         # Application configurations
│   ├── services/         # System services
│   └── virtualization/   # VM and container support
└── wallpapers/           # Collection of system wallpapers
```

## 🛠️ Tips

- Host-specific settings live in `hosts/<name>/settings.nix`.
- Compositor configuration lives in `modules/desktop/compositors/`.
- Wallpaper credits are in `wallpapers/README.md`.

## 🙏 Credits
This configuration draws inspiration from many sources. While some files include credits to their original authors, other components have been adapted and modified from various repositories across the NixOS and ricing community.