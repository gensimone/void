#!/bin/bash

# ██╗   ██╗ ██████╗ ██╗██████╗
# ██║   ██║██╔═══██╗██║██╔══██╗
# ██║   ██║██║   ██║██║██║  ██║
# ╚██╗ ██╔╝██║   ██║██║██║  ██║
#  ╚████╔╝ ╚██████╔╝██║██████╔╝
#   ╚═══╝   ╚═════╝ ╚═╝╚═════╝

# Author: Simone Gentili (gensimone)


here="$(cd "$(dirname "$0")" || exit 1; pwd -P)"

# # Upgrade the system and then install the packages listed in the ./pkgs file.
if sudo xbps-install -Suy; then
  if ! sudo xbps-install -y $(cat "$here"/pkgs); then
    exit 1
  fi
else
  exit 1
fi

# Utility function that iterates over the lines of
# the file at path $1 and invokes the $2 function
# on each of the lines that do not start with the
# '#' symbol.
exec_func() {
  while IFS= read -r line; do
    if ! [[ "$line" =~ ^[[:space:]]*# ]] && [ -n "$line" ]; then
      "$2" "$line"
    fi
  done < "$here/$1"
}

# Enable and start services using runit.
# See: https://docs.voidlinux.org/config/services/index.html
enable_service() {
  sudo ln -sv "/etc/sv/$1" /var/service
}

# Add $USER to the groups specified in ./groups
# See: https://docs.voidlinux.org/config/users-and-groups.html
add_groups() {
  sudo usermod -aG "$1" "$USER"
}

exec_func "$here/services" enable_service
exec_func "$here/groups"   add_groups

# Execute drop-in files inside void.d
if cd "$here"/void.d; then
  for file in *.sh; do
    ./"$file"
  done
fi

"$here"/dwm-setup/install.sh

feh --bg-fill "$here/wall/anime_skull.png"
