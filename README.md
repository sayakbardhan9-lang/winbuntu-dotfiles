# Winbuntu Dotfiles

Custom dotfiles and desktop configurations for my Grade 9 discovery project. This repository contains dotfiles for my Kubuntu configuration, made to look identical to Windows. This is aimed to help new Linux users transitioning from Windows to Linux for the first time.

## Overview
This repository contains my personal Linux configuration files (`.bashrc` and `.config`), tailored to customize Ubuntu KDE with a seamless desktop interface.

## What's Included
- **`.bashrc`**: Custom shell aliases, prompts, and environment settings.
- **`config/`**: KDE application settings and desktop theme configurations.
- **`install.sh`**: Automated installer script that handles configuration backups and symbolic linking.

## How to Apply
To apply these configurations to your system, open your terminal and run the following commands sequentially:

```bash
# 1. Clone the repository
git clone https://github.com/sayakbardhan9-lang/winbuntu-dotfiles.git

# 2. Enter the project folder
cd winbuntu-dotfiles

# 3. Run the installer script
./install.sh
```

### What the installer does behind the scenes:
* **Automatic Backups:** Creates a dated backup folder (`~/winbuntu_backup_...`) containing your original settings so you never lose data.
* **Smart Symlinking:** Links the repository files directly to your system's `~/.config` directory.
* **Desktop Auto-Refresh:** Restarts the KDE Plasma shell automatically so the Windows layout renders instantly without needing to log out.


## 📷 Desktop Screenshots
<img width="1440" height="900" alt="Screenshot 2026-10-26 at 12 35 54" src="https://github.com/user-attachments/assets/0d68f535-1b9a-4021-abc2-49abdbd62e14" />

<img width="1440" height="900" alt="Screenshot 2026-10-26 at 12 36 30" src="https://github.com/user-attachments/assets/1de34647-8249-4120-82d5-9928827b73cd" />

<img width="1440" height="900" alt="Screenshot 2026-10-26 at 12 38 14" src="https://github.com/user-attachments/assets/31dde92f-e723-47ce-9945-b0b0c6489383" />

