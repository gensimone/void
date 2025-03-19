#!/bin/bash

# ██████╗ ██╗   ██╗██╗     ███████╗███████╗
# ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
# ██████╔╝██║   ██║██║     █████╗  ███████╗
# ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
# ██║  ██║╚██████╔╝███████╗███████╗███████║
# ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

# Author: Simone Gentili (gensimone)

cat <<EOF | sudo tee /etc/polkit-1/rules.d/50-udiskie.rules 1>/dev/null
polkit.addRule(function(action, subject) {
  var YES = polkit.Result.YES;
  var permission = {
    "org.freedesktop.udisks2.filesystem-mount-system": YES,
    "org.freedesktop.udisks2.filesystem-mount": YES,
    "org.freedesktop.udisks2.encrypted-unlock": YES,
    "org.freedesktop.udisks2.eject-media": YES,
    "org.freedesktop.udisks2.power-off-drive": YES,
  };
  if (subject.isInGroup("storage")) {
    return permission[action.id];
  }
});
EOF
