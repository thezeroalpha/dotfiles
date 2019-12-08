#!/usr/bin/env bash
die() {
  echo "$1" >&2
  exit 1
}

[ $# -ge 1 ] || die "Argument required"
nvideos=$(cat "$1" | jq length)

for i in `seq 0 $nvideos`; do
  name="$(cat "$1" | jq "keys[$i]")"
  url="$(cat "$1" | jq ."$name")"
  echo "$name: $url"

  youtube-dl -o "$(echo $name | tr -d '"' | sed 's/.mp4//').mp4" "$(echo $url | tr -d '"')" &>/dev/null &
  echo "Downloading $name"

  if [ $(expr $i % 4) -eq 0 ]; then
    echo "Waiting..."
    wait
  fi
done

for f in *.mp4; do ffmpeg -i "$f" -acodec libmp3lame -vn -b:a 320k "${f%.mp4}.mp3"; done
