#!/bin/sh

# Check the operating system
os=$(uname -s)
case "$os" in
    Linux*)
        echo "Operating System: Linux"
        # Linux-specific actions
        case "$(cat /etc/*release)" in
            *"Arch Linux"*)
                echo "Distribution: Arch Linux"
                # Actions for Arch Linux
                ;;
            *)
                echo "Unsupported distribution"
                exit 1
                ;;
        esac
        ;;
    Darwin*)
        echo "Operating System: macOS"
        # macOS-specific actions
        ;;
    *)
        echo "Unsupported operating system: $os"
        exit 1
        ;;
esac

# Check the system architecture and perform architecture-specific actions
architecture=$(uname -m)
case "$architecture" in
    "x86_64")
        # Actions for x86_64 architecture
        echo "This is a 64-bit x86 architecture."
        ;;
    "arm")
        # Actions for ARM architecture
        echo "This is an ARM architecture."
        ;;
    *)
        # Actions for other architectures
        echo "Unsupported architecture: $architecture"
        ;;
esac



pkgs=()

# Check if the package list is not empty
if [ ${#pkgs[@]} -gt 0 ]; then
    # Update packages only if the package list is not empty
    sudo pacman -Syyu "${pkgs[@]}"
fi


# Path to the dotfiles directory
dotfiles_dir="$HOME/dotfiles"

# Check if dotfiles directory exists
if [ ! -d "$dotfiles_dir" ]; then
    echo "Error: Dotfiles directory does not exist: $dotfiles_dir"
    exit 1
fi

# # Copy .bashrc if it doesn't exist in the home directory
# if [ ! -f "$HOME/.bashrc" ]; then
#     cp "$dotfiles_dir/bashrc/.bashrc" "$HOME/.bashrc"
#     echo "Copied .bashrc to home directory."
# fi
#
# # Copy .bash_profile if it doesn't exist in the home directory
# if [ ! -f "$HOME/.bash_profile" ]; then
#     cp "$dotfiles_dir/bashrc/.bash_profile" "$HOME/.bash_profile"
#     echo "Copied .bash_profile to home directory."
# fi
#

# Copy .environment if it doesn't exist in the /etc directory
if [ ! -f "/etc/environment" ]; then
    sudo cp "$dotfiles_dir/etc/environment" "/etc/environment"
    echo "Copied etc/environment to /etc directory"
fi



# .config

# List of directories to link
directories=("nushell" "termusic" "zathura" "vale" "sxhkd" "wal" "fish" "wezterm"  "dunst"  "git" "gtk-2.0" "gtk-3.0" "kitty" "lobster" "mpv" "nvim" "picom" "polybar" "presenterm" "qtile" "scripts" "starship.toml" "yazi")

# Loop through the list
for dir in "${directories[@]}"; do
    # Check if the directory exists in the .config directory
    if [ -d "/home/pc/.config/$dir" ]; then
        # If it exists, delete it
        echo "Deleting existing directory: /home/pc/.config/$dir"
        rm -rf "/home/pc/.config/$dir"
    fi
    
    # Create symbolic link
    ln -sf "$dotfiles_dir/$dir" "/home/pc/.config/$dir"
    echo "Restore Done!"
done
