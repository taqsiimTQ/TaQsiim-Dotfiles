#!/bin/bash

# --- Auto-Pilot Check ---
AUTOPILOT=0
if [[ "$1" == "--auto" || "$1" == "-a" ]]; then
    AUTOPILOT=1
    echo "🚀 Auto-pilot mode engaged! Skipping all prompts."
    echo "------------------------------------------------"
fi

# --- Helper Function for Prompts ---
# Returns 0 (success/yes) or 1 (fail/no)
ask_user() {
    local prompt="$1"
    if [[ $AUTOPILOT -eq 1 ]]; then
        echo "$prompt [Auto: YES]"
        return 0
    fi

    read -p "$prompt [Y/n]: " choice
    case "$choice" in
        n|N ) return 1 ;;
        * ) return 0 ;;
    esac
}
# --- 1. Stow Configurations ---
echo -e "\n📦 Setting up Stow configs..."
CONFIGS=("hypr" "kitty" "matugen" "fastfetch" "nvim" "tmux")

# Create a backup directory just in case
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"

for config in "${CONFIGS[@]}"; do
    if ask_user "Do you want to stow $config?"; then

        # Check if the config already exists in ~/.config and is NOT a symlink
        if [ -e "$HOME/.config/$config" ] && [ ! -L "$HOME/.config/$config" ]; then
            echo "⚠️  Conflict detected: ~/.config/$config already exists."
            echo "Moving existing config to $BACKUP_DIR/$config..."

            mkdir -p "$BACKUP_DIR"
            mv "$HOME/.config/$config" "$BACKUP_DIR/"
        fi

        # If it IS a symlink but broken or old, we can safely remove it
        if [ -L "$HOME/.config/$config" ]; then
            rm "$HOME/.config/$config"
        fi

        echo "Stowing $config..."
        stow -v -t ~ "$config"
    else
        echo "Skipping $config."
    fi
done

# Clean up the backup directory if it's empty
if [ -d "$BACKUP_DIR" ] && [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    rmdir "$BACKUP_DIR"
fi


# --- 3. Zram Script ---
echo -e "\n💾 Setting up Zram..."
if ask_user "Do you want to run the Zram configuration script?"; then
    ZRAM_SCRIPT="./scripts/ZramConfig"
    if [[ -f "$ZRAM_SCRIPT" ]]; then
        echo "Running $ZRAM_SCRIPT..."
        bash "$ZRAM_SCRIPT"
    else
        echo "Error: Could not find $ZRAM_SCRIPT. Please check the name and path."
    fi
else
    echo "Skipping Zram script."
fi
# --- 4. Yay & Packages ---
echo -e "\n🛠️ Setting up Packages..."
if ask_user "Do you want to install yay (if missing) and packages from pkglist.txt?"; then

    echo "Running system update..."
    sudo pacman -Syu --noconfirm

    # Check if yay exists, build if it doesn't
    if ! command -v yay &> /dev/null; then
        echo "Yay not found. Cloning and building yay..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay || exit
        makepkg -si --noconfirm
        cd - || exit
        rm -rf /tmp/yay
    else
        echo "Yay is already installed."
    fi

    # Install packages
    if [[ -f "pkglist.txt" ]]; then
        echo "Installing packages from pkglist.txt..."
        yay -S --needed --noconfirm - < pkglist.txt
    else
        echo "Error: pkglist.txt not found in the current directory."
    fi
else
    echo "Skipping packages."
fi

# --- 5. Zen Browser Mods ---
echo -e "\n🌐 Setting up Zen Browser Mods..."
if ask_user "Do you want to copy the Zen mods JSON file?"; then
    if [[ -f "Zen/zen-mods-export.json" ]]; then
        # Find the default Zen profile dynamically
        ZEN_PROFILE=$(find ~/.zen -maxdepth 1 -type d -name "*.default*" | head -n 1)

        if [[ -n "$ZEN_PROFILE" ]]; then
            echo "Found Zen profile at: $ZEN_PROFILE"
            cp Zen/zen-mods-export.json "$ZEN_PROFILE/"
            echo "Copied zen-mods-export.json to your Zen profile."
        else
            echo "Warning: Zen Browser profile not found. Have you launched Zen at least once?"
        fi
    else
        echo "Error: Zen/zen-mods-export.json not found."
    fi
else
    echo "Skipping Zen mods."
fi

echo -e "\n🎉 Setup script finished!"
