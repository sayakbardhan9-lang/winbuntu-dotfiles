#!/bin/bash

echo "=== Starting Snap Removal ==="

# Stop snap services to prevent file locks
echo "[1/5] Stopping snapd services..."
sudo systemctl stop snapd.service snapd.socket snapd.seeded.service 2>/dev/null

# Iteratively remove all installed snap packages
echo "[2/5] Removing installed snap packages..."
for s in $(snap list 2>/dev/null | awk 'NR>1 {print $1}'); do
    sudo snap remove --purge "$s" 2>/dev/null
done

# Purge the snapd daemon
echo "[3/5] Purging snapd package..."
sudo apt purge -y snapd

# Clean leftover directories
echo "[4/5] Removing snap directories..."
rm -rf ~/snap
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd

# Block snapd from being reinstalled during updates
echo "[5/5] Adding apt pin preference..."
sudo bash -c 'cat <<EOF> /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF'

echo "=== Snap has been completely removed! ==="
