#!/bin/bash
if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
    echo "Welcome to zenusus's configs auto-installer for debian and ubuntu! Dependencies will be installed now"
    sleep 1
    sudo add-apt-repository ppa:nschloe/waybar
    sudo apt-get install -y --no-install-recommends waybar rofi mako wlogout build-essential cmake
    echo "Dependencies installed! Now, dependencies that are not in apt..."
    sleep 0.3
    echo "Cloning repos..."
    git clone https://github.com/hyprwm/Hyprlock.git /tmp
    git clone https://github.com/hyprwm/Hyprpaper.git /tmp
    cd /tmp
    cd Hyprlock
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
    cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
    sudo cmake --install build
    
    cd /tmp
    cd Hyprpaper
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
    cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
    cmake --install ./build

    

    if dpkg-query -W waybar &>/dev/null && \
       dpkg-query -W rofi &>/dev/null && \
       dpkg-query -W mako &>/dev/null && \
       dpkg-query -W wlogout &>/dev/null && \
       dpkg-query -W hyprlock &>/dev/null; then
        
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
        echo "Reloading configurations..."	
	killall waybar 
        killall hyprpaper
        rm -rf /tmp/MyConfigs
        
        sleep 1
        echo "All done! You can close the terminal (super+c)"
        nohup waybar
        nohup hyprpaper

        while true; do
            read -r -p "> " input
            if [[ -z "$input" ]]; then
                echo "Exiting..."
                sleep 1	
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
