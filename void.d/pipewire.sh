#!/bin/bash

# ██████╗ ██╗██████╗ ███████╗██╗    ██╗██╗██████╗ ███████╗
# ██╔══██╗██║██╔══██╗██╔════╝██║    ██║██║██╔══██╗██╔════╝
# ██████╔╝██║██████╔╝█████╗  ██║ █╗ ██║██║██████╔╝█████╗
# ██╔═══╝ ██║██╔═══╝ ██╔══╝  ██║███╗██║██║██╔══██╗██╔══╝
# ██║     ██║██║     ███████╗╚███╔███╔╝██║██║  ██║███████╗
# ╚═╝     ╚═╝╚═╝     ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚══════╝

# Author: Simone Gentili (gensimone)

# Pipewire (https://docs.voidlinux.org/config/media/pipewire.html)
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo mkdir -p /etc/alsa/conf.d
sudo ln -sv /usr/share/examples/wireplumber/10-wireplumber.conf  /etc/pipewire/pipewire.conf.d/
sudo ln -sv /usr/share/examples/pipewire/20-pipewire-pulse.conf  /etc/pipewire/pipewire.conf.d/
sudo ln -sv /usr/share/alsa/alsa.conf.d/50-pipewire.conf         /etc/alsa/conf.d
sudo ln -sv /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
