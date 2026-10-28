#!/bin/bash

echo "=== Starting Snap Removal ==="

# 1. Remove all installed snap packages (handles dependencies dynamically)
echo "[1/4] Removing installed snap packages..."
while [ "$(snap list 2>/dev/null | wc -l)" -gt 0 ]; do
    for s in $(snap list 2>/dev/null | awk 'NR>1 {print $1}'); do
        sudo snap remove --purge "$s" 2>/dev/null
    done
done

# 2. Stop snapd services and purge the daemon
echo "[2/4] Purging snapd daemon..."
sudo systemctl stop snapd.service snapd.socket snapd.seeded.service 2>/dev/null
sudo apt purge -y snapd

# 3. Clean leftover directories
echo "[3/4] Removing snap directories..."
rm -rf ~/snap
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd

# 4. Block snapd from being reinstalled during updates
echo "[4/4] Adding apt pin preference..."
sudo bash -c 'cat <<EOF > /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF'

echo "=== Snap has been completely removed! ==="
