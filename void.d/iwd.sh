#!/bin/bash

# Author: Simone Gentili (gensimone)

# iwd: https://docs.voidlinux.org/config/network/iwd.html
# By default, IWD will create and destroy the wireless interfaces (e.g. wlan0) that it manages.
# This can interfere with udevd, which may attempt to rename the interface using its rules for
# persistent network interface names. A simple fix is to prevent IWD from manipulating the network
# interfaces in this way by adding UseDefaultInterface=true to the [General] section of
# /etc/iwd/main.conf. An alternative approach is to disable the use of persistent network interface
# names by udevd. This may be accomplished either by adding net.ifnames=0 to your kernel cmdline or
# by creating a symbolic link to /dev/null at /etc/udev/rules.d/80-net-name-slot.rules to mask the
# renaming rule. This alternative approach will affect the naming of all network devices

cat <<EOF | sudo tee /etc/iwd/main.conf 1>/dev/null
# ██╗██╗    ██╗██████╗
# ██║██║    ██║██╔══██╗
# ██║██║ █╗ ██║██║  ██║
# ██║██║███╗██║██║  ██║
# ██║╚███╔███╔╝██████╔╝
# ╚═╝ ╚══╝╚══╝ ╚═════╝

[General]
UseDefaultInterface=true
EOF
