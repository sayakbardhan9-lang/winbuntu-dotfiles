# 🗑️ Snap Removal Guide

This guide explains why you might want to remove Canonical's Snap package system and how to automate its removal using the scripts in this repository.

---

## 🤔 Why Remove Snaps?

While Snap packages provide sandboxing and easy updates, they introduce several performance trade-offs for desktop users:

* **High Memory Overhead:** `snapd` and background services (like the Snap Store) often consume **200MB–400MB+ of idle RAM**, taking away resources from your system.
* **Storage Bloat:** Snaps bundle their own redundant dependencies and automatically store legacy backup revisions, eating up extra gigabytes of storage over time.
* **Slower Launch Times:** Snaps are compressed SquashFS files that must be decompressed and mounted at launch, making app startup noticeably slower compared to native `.deb` packages.
* **Cluttered Mounts:** Every installed snap registers as a loopback device, cluttering terminal tools like `lsblk` and `df`.

---

## ⚡ Automated Removal

Simply run the included debloating script from your local repository folder:

```bash
./nosnap.sh
