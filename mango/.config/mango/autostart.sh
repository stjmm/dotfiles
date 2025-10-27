#!/usr/bin/env bash
set +e

dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

swaybg -i /usr/share/wallpapers/Mountain/contents/images_dark/5120x2880.png &

waybar &

wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --type text --watch cliphist store &

swayidle -w \
    timeout 300 'brightnessctl -s set 10%' \
    resume 'brightnessctl -r' \
    timeout 300 'swaylock -f -c 000000' \
    timeout 600 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    timeout 600 'systemctl suspend' \
    before-sleep 'swaylock -f -c 000000' &

echo "Xft.dpi: 150" | xrdb -merge
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
