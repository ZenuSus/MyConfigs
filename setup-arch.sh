#!/bin/bash
if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
    echo "Welcome to zenusus's configs auto-installer for arch! Dependencies will be installed now"
    sleep 1
    sudo pacman -S --needed --noconfirm waybar rofi mako wlogout hyprlock hyprpaper

    if pacman -Q waybar &>/dev/null && \
       pacman -Q rofi &>/dev/null && \
       pacman -Q mako &>/dev/null && \
       pacman -Q wlogout &>/dev/null && \
       pacman -Q hyprlock &>/dev/null && \
       pacman -Q hyprpaper &>/dev/null; then
        
        echo "Dependencies installed! Cloning repository..."
        sleep 1

        cd /tmp || exit
        git clone https://github.com/ZenuSus/MyConfigs
        cd MyConfigs || exit
        
        echo "Cloned! Copying configs..."

        mkdir -p "$HOME/.config"
        cp -r hypr "$HOME/.config/"
        cp -r mako "$HOME/.config/"
        cp -r rofi "$HOME/.config/"
        cp -r waybar "$HOME/.config/"
        cp -r wlogout "$HOME/.config/"
        
        echo "Configs copied! Copying other things..."
        
        mkdir -p "$HOME/Pictures"
        cp -r Wallpapers "$HOME/Pictures/"
        
        mkdir -p "$HOME/.misc"
        echo "Hello!" > "$HOME/.misc/readme.txt"
        
        sleep 1
        echo "All done! Press enter to logout (this is necessary to apply the changes). Or logout by yourself."

        while true; do
            read -r -p "> " input
            if [[ -z "$input" ]]; then
                echo "Exiting..."
                sleep 1
                logout
                exit
            else
                echo "Press enter!"
            fi
        done
    else
        echo "Error: Not all dependencies were installed! Script cannot continue."
        exit 1
    fi
else
    echo "You are not in Hyprland, the script cannot be run."
    exit 1
fi