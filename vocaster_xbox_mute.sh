#!/bin/bash

# numid=36,iface=MIXER,name='Line In 1 Mute Capture Switch'
# numid=37,iface=MIXER,name='Line In 2 Mute Capture Switch'
# numid=6,iface=MIXER,name='Line In 1 DSP Capture Switch'
# numid=21,iface=MIXER,name='Line In 2 DSP Capture Switch'

DEVICE_NAME="Vocaster Two USB"
VOLUME="85%"
SLEEP="0.1"

check_mute_state() {
  # numid=37,iface=MIXER,name='Line In 2 Mute Capture Switch'
  local card=$(find_device)
  local mute_state=$(amixer -c $card cget numid=37)
  if [[ $mute_state =~ "values=on" ]]; then
    echo true
  elif [[ $mute_state =~ "values=off" ]]; then
    echo false
  else
    echo "could not determine mute status"
    exit 1
  fi
}

find_device() {
  local card=$(aplay -l | grep "$DEVICE_NAME" | head -n1 | awk '{print $2}' | sed 's/://g')
  echo $card
}

set_volume() {
  local card=$(find_device)
  # numid=105,iface=MIXER,name='Mix C Input 01 Playback Volume'
  # numid=117,iface=MIXER,name='Mix D Input 01 Playback Volume'
  amixer -c $card cset numid=105 $1
  amixer -c $card cset numid=117 $1
}

toggle_mute() {
  if [[ $1 == "true" ]]; then
    set_volume "0%"
  elif [[ $1 == "false" ]]; then
    set_volume $VOLUME
  fi
}

# Main loop
while true; do
  current_state=$(check_mute_state)
  if [[ $current_state != "$previous_state" ]]; then
    echo "State changed to: $current_state"
    toggle_mute $current_state
  fi
  previous_state=$current_state
  sleep $SLEEP
done
