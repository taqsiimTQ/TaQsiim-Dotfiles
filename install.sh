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
CONFIGS=("hypr" "kitty" "matugen" "fastfetch" "nvim")

for config in "${CONFIGS[@]}"; do
    if ask_user "Do you want to stow $config?"; then
        echo "Stowing $config..."
        stow -v -t ~ "$config"
    else
        echo "Skipping $config."
    fi
done

# --- 2. Fonts Installation ---
echo -e "\n🔤 Setting up Fonts..."
if ask_user "Do you want to copy fonts and update the font cache?"; then
    echo "Copying fonts..."
    sudo cp -r Fonts/* /usr/local/share/fonts/WindowsFonts/

    echo "Setting permissions (chmod 644)..."
    sudo chmod 644 /usr/local/share/fonts/WindowsFonts/*

    echo "Updating font cache..."
    fc-cache -fv
else
    echo "Skipping fonts."
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
