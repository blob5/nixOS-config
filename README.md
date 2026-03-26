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
  - [Neovim-wrapper-module](https://github.com/BirdeeHub/nix-wrapper-modules)
  - [VSCode](https://code.visualstudio.com/)
- **Shell**: [ZSH](https://ohmyz.sh/)
- **Application Launcher**: [Rofi](https://github.com/davatorium/rofi)
- **Status Bar**: [noctalia shell](https://github.com/noctalia-dev/noctalia-shell)
- **Theming**: Native Home Manager GTK/Qt theming

## ✅ Requirements

- Nix with Flakes enabled
- `git` and `gpg` (optional for signing)
- A target host definition under `hosts/`


## ⚙️ Installation

Prefer to do things yourself? Follow these steps:

**1. Generate SSH key** *(optional, for GitHub access)*
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**2. Clone the repo**
```bash
# HTTPS
git clone https://github.com/blob5/nixos-config.git --depth 1
# or SSH
git clone git@github.com:blob5/nixOS-config.git --depth 1
cd nixos-config
```

**3. Create a host from the template**
```bash
cp -r hosts/template hosts/<name>
```

**4. Generate and save hardware config**
```bash
sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix
```

**5. Configure your host**
```bash
$EDITOR hosts/<name>/settings.nix   # set hostname, user, WM, etc.
$EDITOR flake.nix                   # add your host to the hosts list
```

**6. Build**

*Subsequent rebuilds* (substituters already active from `nix.conf`):
```bash
update
rebuild 
```

*First install* — pass substituters explicitly since `nix.conf` from this flake hasn't been applied yet:
```bash
SUBS="https://cache.nixos.org https://cache.flox.dev https://nix-community.cachix.org https://hyprland.cachix.org https://attic.xuyh0120.win/lantian https://cache.garnix.io"
KEYS="cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs= hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc= lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc= cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="

sudo nixos-install --flake .#<name> \
  --option substituters "$SUBS" \
  --option trusted-public-keys "$KEYS"
```

## 🧭 Hosts Overview

| Host     | Type    | Notes |
|----------|---------|-------|
| `navi`   | Desktop | Hyprland / AMD |
| `cyberia`| Laptop  | Niri / AMD |
| `core`   | Server  | Headless |
| `cache`  | Laptop  | Legacy |

> Details live in `hosts/<name>/configuration.nix` and `hosts/<name>/settings.nix`.

## 📁 Project Structure

```
.
├── flake.nix             # Main flake configuration
├── install.sh            # Interactive installer script
├── dev-shells            # Development shells
├── hosts/                # Host-specific configurations
│   ├── cyberia/          # Laptop
│   ├── navi/             # Desktop
│   ├── core/             # Server
│   ├── cache/            # Old Laptop
│   └── template/         # Base template for new hosts
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