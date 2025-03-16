#!/bin/python

# Author: Simone Gentili (gensimone)

import os
from typing import List
from subprocess import run, PIPE

# the file to create/update
HERE = os.path.dirname(os.path.abspath(__file__))
PKGS = f'{HERE}/pkgs'

# remove orphaned packages
run('sudo xbps-remove -Oo', check=True, shell=True)

# list installed packages
completed_process = run('xbps-query -l', stdout=PIPE, check=True, shell=True)

# strips the version from the package name.
# wireshark-qt-4.4.2_1 => wireshark-qt
# xf86-input-libinput-1.4.0_1 => xf86-input-libinput
def strip_version(pkg: str) -> str:
    return '-'.join(pkg.split()[1].split('-')[:-1])

"""
xbps-query man page says:
  - ii Package is installed.
  - uu Package is unpacked but must be configured with xbps-reconfigure(1).
  - hr Package is half-removed, and can be fully removed with xbps-remove(1).
  - ?? Package state is unknown.
"""
pkgs: List[str] = []
for pkg in completed_process.stdout.decode().split('\n'):
    if pkg.startswith('ii'):
        pkgs.append(strip_version(pkg))

print(f'Updating {PKGS}')
with open(PKGS, mode='w') as f:
    f.write('\n'.join(pkgs))
print('Done')
