# Dotfiles & Others Repository
---

## Installation:
1. Clone repository as `~/.dotfiles`
2. `cd` into repository
3. Run `install.sh`

However, I suggest that you use this more as inspiration than just installing everything for a full setup. Your configuration is *your* configuration.

## Scripts in `dotfiles/bin`:
Before you use a custom script, read what it does. Some may be a bit buggy, I haven't tested them on all systems.
If you read a script and see some improvements that could be made, let me know. I'm always down to learn more stuff.

Scripts:
* `AMSTracker`: Retrieves x, y, and z values from AMS (Apple Motion Sensor) hardware.
* `anythingtogif`: converts (almost) anything to a gif. Usage: `anythingtogif clip.mov clip.gif`. Backed by ffmpeg.
* `class-dump`: dumps classes from binary file
* `clonedisk`: clones one disk to another
* `Desktop Changer.app`: an Automator application that changes the desktop background to a random image on login
* `epub-convert`: uses Calibre's ebook converter program to convert anything to an epub
* `executable`: my first script. Makes any file executable, along with further options. Usage: `executable file.sh`
* `gfx2gfx`: convert SWF into PDF. Usage: `gfx2gfx page.swf -o page.pdf`
* `icalBuddy`: can extract information about events from the iCal application
* `itunes_style_getter`: can find and set the genre in a track in iTunes (along with its Ruby helper), using the Discogs database (you need an API key). Usage: click/play a track in iTunes, and run the program.
* `linkdir`: symlink all files/folders from source dir to target dir. Usage: `linkdir $source` to create symlinks in cwd, `linkdir $source $target` otherwise.
* `mdvl`: markdown renderer in Python 
* `modified_cfscrape.py`: can scrape and download CloudFlare-protected websites. Usage: `python3 modified_cfscrape.py http://url.com`
* `mp3tagger.jar`: a Java application to tag MP3 files
* `percerr.rb`: a very simple thing for calculating percent error. Just run the Ruby script.
* `play`: a command line music player. Shows album art, or a visualiser if there is no album art. Set a $MUSIC_DIR in your profile, then run `play`.
* `radio`: a command-line radio player, can play various music streams from the internet. Also has a visualiser, turn it off by passing `-n` on startup.
* `smack.pl`: change macos spaces by smacking the side of your screen (if you have a laptop). Yeah, like physically.
* `strip-html-tags`: remove HTML tags from a file
* `tag`: a command-line `mp3tagger.jar`. Usage: `tag filename.mp3`
* `topdf`: converts a file to a PDF using cupsfilter. Works well on docx files. Usage: `topdf file [file2 file3 file4...]`
* `updatemaster`: the ultimate all-in-one update script (Brew, Cask, MAS, pip, etc.). Run with `-h` to see options.
* `upx.out`: Fixes a fucked CORE keygen. Check Info.plist in bundle. If the version is lower than system version, and the crash log says "UPX compressed binary", just run `upx.out -d $coreKeygenBinaryPath` and you good.
* `usbmux`, `tcprelay`: port forwarding. If you want to SSH to a jailbroken iPhone over USB, you can run `tcprelay 22:2222` to forward local port 2222 to the iPhone's SSH port (22), and then `ssh -p 2222 root@localhost`.
* `wattpad-scrape`: downloads a Wattpad book as an EPUB file. Usage: `wattpad-scrape $wattpad_url`
* `xld`: X lossless decoder CLI.
