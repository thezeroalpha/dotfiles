# Dotfiles & Others Repository
---

## Installation:
1. Clone repository as `~/.dotfiles`
2. `cd` into repository
3. Run `install.sh`


Remember: your configuration is *your* configuration (and this is mine).

However, if you _do_ decide to use this, I suggest that you do so more as inspiration, rather than installing everything for a full setup.
That's why I wrote `scripts/conf` -- to allow modular configuration.
You choose which configs you want to install, and it'll only install those (and back up your old files too).
Get more info by running `scripts/conf -h`, and investigate the dotfile mappings in `./dot.map`.

## Scripts in `dotfiles/scripts`:
Before you use a custom script, read what it does.
Scripts are described in a short comment at the top of the file.
Some may be a bit buggy, I haven't tested them on all systems.
If you read a script and see some improvements that could be made, let me know. I'm always down to learn more stuff.

## Binaries in `dotfiles/bin`:
These are third-party binaries that I didn't write. I don't take credit for any of them. I only have them in the folder for convenience.

* `find-photo-in-albums.app`: find the albums that contain a photo in Apple Photos
* `wal-init.app`: an app that runs at login to set up pywal
* `AMSTracker`: Retrieves x, y, and z values from AMS (Apple Motion Sensor) hardware.
* `bfg.jar`: the big gun. A repo cleaner to remove sensitive data.
* `class-dump`: dumps classes from binary file
* `gfx2gfx`: convert SWF into PDF. Usage: `gfx2gfx page.swf -o page.pdf`
* `icalBuddy`: can extract information about events from the iCal application
* `k2pdfopt`: a tool to optimise pdfs for mobile readers
* `upx.out`: Fixes a fucked CORE keygen. Check Info.plist in bundle. If the version is lower than system version, and the crash log says "UPX compressed binary", just run `upx.out -d $coreKeygenBinaryPath` and you good.
* `xld`: X lossless decoder CLI.
