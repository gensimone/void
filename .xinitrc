#!/bin/bash
#
# ██╗  ██╗██╗███╗   ██╗██╗████████╗
# ╚██╗██╔╝██║████╗  ██║██║╚══██╔══╝
#  ╚███╔╝ ██║██╔██╗ ██║██║   ██║
#  ██╔██╗ ██║██║╚██╗██║██║   ██║
# ██╔╝ ██╗██║██║ ╚████║██║   ██║
# ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝


# create a dbus session
# FIXME: --exit-with-session This option is not recommended, since it
#         will consume input from the terminal where it was started;
#         it is mainly provided for backwards compatibility [dbus-launch(1)]
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(/usr/bin/dbus-launch --exit-with-session --sh-syntax)"
fi

# set the wallpaper
if [ -f "$HOME/.fehbg" ]; then
  "$HOME/.fehbg"
else
  feh --bg-center "$HOME"/Pictures/Wallpapers/default.png
fi

pipewire &             # audio
clipmenud &            # clipboard daemon
picom &                # compositor
dunst &                # notification daemon
sxhkd &                # hotkey daemon
pcmanfm -d &           # file manager
statusbar  &           # dwm status bar daemon
batsignal -b -m 3 -e   # battery daemon
xautolock -time 10 -locker slock -corners 000- &  # automatic screen-locker

exec dwm
