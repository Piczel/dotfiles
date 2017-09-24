#!/usr/bin/env bash
#
# rotsix - (c) wtfpl 2017
# polybar manager

launch_polybar () {
  log="$HOME/log/polybar-$1.log"
  echo "Launching polybar $1"
  mv "$log" "$log.save"
  date '+%d.%m.%Y %H:%M' > "$log"
  polybar "$1" --log=info -r &>> "$log" &
}

kill_polybar () {
  echo "Killing polybar $1"
  killall -q polybar &>/dev/null ; shift
  local i=0;
  while (( ++i < 5 )) && pgrep -x polybar >/dev/null; do sleep 1; done
}

reload_polybar () {
  echo "Reloading polybar $1"
  pkill -10 polybar || launch_polybar "$1"
}

"$1"_polybar "$2" || echo "Mh, add this in manager.sh"

