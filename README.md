# TaQsiim-Dotfiles

A sleek, functional, and highly customized Arch Linux setup featuring Hyprland, LazyVim, and a workflow-oriented terminal experience.

![Arch Linux](https://img.shields.io/badge/OS-Arch%20Linux-blue?logo=arch-linux&logoColor=white)
![WM](https://img.shields.io/badge/WM-Hyprland-brightgreen)
![Shell](https://img.shields.io/badge/Shell-Fish-blue)
![Editor](https://img.shields.io/badge/Editor-LazyVim-purple?logo=neovim)

##  Features

- **Window Manager:** [Hyprland](https://hyprland.org/) - A dynamic tiling Wayland compositor.
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/) - Fast, feature-rich, GPU-based terminal.
- **Shell:** [Fish](https://fishshell.com/) - Friendly Interactive Shell with Starship prompt.
- **Editor:** [LazyVim](https://www.lazyvim.org/) - A Neovim setup powered by `lazy.nvim`.
- **Colorscheme:** [Matugen](https://github.com/InioAsman/matugen) - Material You color generator.
- **System Info:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch) - Modern and fast system info tool.
- **Multiplexer:** [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer for persistent sessions.
- **Browser:** [Zen Browser](https://zen-browser.app/) - Firefox-based browser with custom mods.

##  Installation

### 1. Prerequisites

Ensure you have the following installed on your Arch Linux system:

- **[end-4/dots-hyprland (Illogical Impulse)](https://github.com/end-4/dots-hyprland)**: This configuration is built on top of the "Illogical Impulse" setup. Ensure it is installed and configured first.
- `git`
- `stow` (for managing dotfiles)
- `base-devel` (for building AUR packages)

### 2. Clone the Repository

```bash
git clone https://github.com/TaQsiim/TaQsiim-Dotfiles.git
cd TaQsiim-Dotfiles
```

### 3. Run the Install Script

The provided `install.sh` script automates stowing configurations, setting up ZRAM, installing `yay`, and fetching all required packages.

```bash
chmod +x install.sh
./install.sh
```

**Options:**
- `--auto` or `-a`: Engage auto-pilot mode (skips all prompts and applies defaults).

### 4. Manual Steps (If needed)

If the script skips any components, you can manually stow them:

```bash
stow -v -t ~ fish
stow -v -t ~ nvim
# etc.
```

## Fonts & Typography

The repository includes a collection of Windows fonts to ensure compatibility and a polished look across applications.
To install them, you can copy them to your local fonts directory:
```bash
mkdir -p ~/.local/share/fonts
cp -r Fonts/* ~/.local/share/fonts/
fc-cache -fv
```

##  Key Components & Scripts

### ZRAM Configuration
The repository includes a helper script to optimize your memory usage by setting up a 12GB ZRAM swap.
```bash
./scripts/ZramConfig
```

### Package List
A comprehensive list of packages (including AUR) is maintained in `pkglist.txt`. You can install them manually using `yay`:
```bash
yay -S --needed - < pkglist.txt
```

### Zen Browser Mods
The setup includes a custom JSON export for Zen Browser mods. The install script attempts to copy this to your default Zen profile automatically.

##  Keybindings & Interaction
See `hypr/.config/hypr/custom/` for details.*

### Core Keybinds (Customized)
- `Super + B`: Open Browser (Zen/Firefox)
- `Super + C`: Open Code Editor (VS Code/Antigravity)
- `Ctrl + Shift + Esc`: Open Task Manager (System Monitor/Btop)
- `Alt + F4`: Close active window
- `Super + Shift + F`: Toggle floating
- `Super + Win + Space`: Toggle Keyboard Layout (US/Arabic)

### Gestures (Touchpad)
- **4-Finger Swipe:** Move window
- **3-Finger Pinch:** Toggle float
- **3-Finger Horizontal:** Switch workspace
- **3-Finger Down:** Toggle workspace overview

##  Language Support
This configuration includes built-in support for dual keyboard layouts:
- **English (US)**
- **Arabic (ara)**
- Use `Super + Space` to switch between them.


*Maintained by [TaQsiim](https://github.com/TaQsiimUwU)*
