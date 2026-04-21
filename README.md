# Arch Scripts

A collection of personal utility scripts for Arch Linux. While originally built for my own use, anyone is free to use or adapt them for their own systems.

## Prerequisites & Dependencies

Some scripts require specific packages to be installed to function correctly. Most can be installed from the official Arch repositories or the AUR:

- `lm_sensors` - Required by `system-health.sh` to display CPU temperatures.
- `pacman-contrib` - Provides the `paccache` command used in `pacman/pkg_clean.sh`.
- `reflector` - Required by `pacman/reflector.sh` to update mirrorlists.
- `paru` - AUR helper used in `pacman/update.sh` for full system updates.
- `NetworkManager` - Provides `nmcli`, used in `dns-switch.sh`.

You can install the official repository dependencies using pacman:
```bash
sudo pacman -S lm_sensors pacman-contrib reflector
```
*(Note: `paru` must be installed separately from the AUR).*

## Usage

Make sure the scripts are executable before running them. You can do this by running:
```bash
chmod +x *.sh pacman/*.sh
```

To run a script, simply execute it from the terminal. Some scripts modify system settings or manage packages and will require `sudo` privileges.

### Included Scripts

#### `ls-script.sh`
An interactive menu that lists all available scripts in the directory and lets you easily execute them by selecting a number.

#### `dns-switch.sh`
A CLI tool that toggles your active network connection's DNS settings between Cloudflare (1.1.1.1, 1.0.0.1) and the default DHCP-assigned DNS. Requires `sudo`.

#### `system-health.sh`
Provides a quick overview of your system's health, including disk usage, memory/swap usage, CPU temperatures (if `lm_sensors` is installed), and lists any failed systemd services.

#### `pacman/update.sh`
Performs a full system update using the `paru` AUR helper, then checks for orphaned packages and failed systemd services.

#### `pacman/pkg_clean.sh`
Frees up disk space by cleaning the `pacman` cache (retains only the latest 2 versions of installed packages, removes all uninstalled packages) and empties the user `~/.cache/` directory. Requires `sudo`.

#### `pacman/reflector.sh`
Fetches and ranks the 10 fastest HTTPS mirrors using `reflector`, then saves the optimized list to `/etc/pacman.d/mirrorlist`. Requires `sudo`.
