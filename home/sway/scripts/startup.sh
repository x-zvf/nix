#!/bin/sh

set -x
systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME NIXOS_OZONE_WL
systemctl --user start dunst

execifn() {
    if [ -z "$(pgrep $1)" ];
    then
        shift
        $@ &
    fi
}

systemctl --user restart kanshi.service

pkill waybar; waybar &

execifn pasystray pasystray
execifn nm-applet nm-applet

execifn wpaper wpaperd -d
execifn kwalletd6 kwalletd6 -d

execifn wl-paste wl-paste --watch cliphist store

swaymsg 'workspace number 1; layout tabbed'
execifn firefox firefox

swaymsg 'workspace number 2; layout tabbed'

execifn ferdium ferdium
signal-desktop --password-store="kwallet6"
execifn thunderbird thunderbird

swaymsg 'workspace number 3'


if [ -z "$(pgrep swayidle)" ];
then
    swayidle -w before-sleep "loginctl lock-session $XDG_SESSION_ID" lock "playerctl -a pause && swaylock" &
fi

