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
  - [LazyVim](https://github.com/LazyVim/LazyVim)
  - [VSCode](https://code.visualstudio.com/)
- **Shell**: [ZSH](https://ohmyz.sh/)
- **Application Launcher**: [Rofi](https://github.com/davatorium/rofi)
- **Status Bar**: [noctalia shell](https://github.com/noctalia-dev/noctalia-shell)
- **Theming**: [Stylix](https://github.com/danth/stylix)

## 📁 Project Structure

My configuration is organized into logical directories to make maintenance and customization straightforward:

```
.
├── flake.nix             # Main flake configuration
├── hosts/                # Host-specific configurations
│   ├── common/           # Shared configurations
│   ├── cyberia/          # Laptop
│   ├── navi/             # Desktop
│   └── core/             # Server
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

## 🙏 Credits
This configuration draws inspiration from many sources. While some files include credits to their original authors, other components have been adapted and modified from various repositories across the NixOS and ricing community.
