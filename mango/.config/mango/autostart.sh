#!/usr/bin/env bash
set +e

dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

swaybg -i /usr/share/wallpapers/Mountain/contents/images_dark/5120x2880.png &

wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --type text --watch cliphist store &

hypridle -q &

if ! pgrep -x hypridle >/dev/null; then
    hypridle -c ~/.config/hypr/hypridle.conf &
fi

echo "Xft.dpi: 150" | xrdb -merge
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5

export LANG=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export TZ=Europe/Warsaw
waybar -c ~/.config/mango/config.jsonc -s ~/.config/mango/style.css &
