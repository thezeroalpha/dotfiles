#!/bin/sh
if command -v bat >/dev/null 2>&1; then
  { [ -f ~/.config/dark-theme ] && theme=1337; } || theme=GitHub
  pagercmd="bat --color=always --theme=$theme"
else
  pagercmd="less -FRiX"
fi

case "$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')" in
  *.pickle) python -mpickle "$1";;
  *.tgz|*.tar.gz) tar tzf "$1";;
  *.tar.bz2|*.tbz2) tar tjf "$1";;
  *.tar.txz|*.txz) xz --list "$1";;
  *.deb) dpkg -c "$1";;
  *.tar) tar tf "$1";;
  *.zip|*.jar|*.war|*.ear|*.oxt|*.apkg|*.apk) unzip -l "$1";;
  *.rar) unrar l "$1";;
  *.7z) 7z l "$1";;
  *.[1-8]) man "$1" | col -b ;;
  *.o) objdump -d "$1" ;; #nm "$1" | less ;;
  # *.torrent) transmission-show "$1";;
  # *.iso) iso-info --no-header -l "$1";;
  *.epub|*.rtf|*.doc|*.docx|*.otd|*.ods|*.odp|*.sxw)
    pandoc -s -t markdown -- "$1" | $pagercmd
    exit 1
    ;;
  *.json)
    if command -v jq >/dev/null; then
      if command -v bat >/dev/null; then jq < "$1" | $pagercmd --file-name "$1"
      else jq < "$1" | $pagercmd; fi
    else $pagercmd "$1"; fi
    ;;
  *.csv) sed s/,/\\n/g "$1";;
  *.pdf)
    CACHE=$(mktemp)
    pdftoppm -png -f 1 -singlefile "$1" "$CACHE"
    imgpreview "$CACHE.png"
    rm "$CACHE"
    ;;
  *.bmp|*.jpg|*.jpeg|*.png|*.xpm|*.gif|*.svg)
    imgpreview "$1"
    ;;
  *.wav|*.mp3|*.flac|*.m4a|*.wma|*.ape|*.ac3|*.og[agx]|*.spx|*.opus|*.as[fx])
    exiftool "$1"
    ;;
  *.avi|*.mp4|*.wmv|*.dat|*.3gp|*.ogv|*.mkv|*.mpg|*.mpeg|*.vob|*.fl[icv]|*.m2v|*.mov|*.webm|*.ts|*.mts|*.m4v|*.r[am]|*.qt|*.divx)
    CACHE=$(mktemp)
    ffmpegthumbnailer -i "$1" -o "$CACHE" -s 0
    imgpreview "$CACHE"
    rm "$CACHE"
    ;;
  *.db)
    case $(file --mime-type "$1" -bL) in
      application/x-sqlite3) command -v sqlite3 >/dev/null && sqlite3 "$1" '.schema';;
      *) ;;
    esac
    ;;
  *)
    case $(file --mime-type "$1" -bL) in
      application/x-executable) readelf -h "$1" ;;
      *)
        $pagercmd "$1"
        ;;
    esac
    ;;
esac

