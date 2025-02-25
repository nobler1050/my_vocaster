#!/bin/bash

DEVICE_NAME="Vocaster Two USB"
VOLUME="65%"
SLEEP="0.1"

check_monitor_state() {
  # numid=21,iface=MIXER,name='Line In 2 DSP Capture Switch'
  local card=$(find_device)
  local monitor_state=$(amixer -c $card cget numid=21)
  if [[ $monitor_state =~ "values=on" ]]; then
    echo true
  elif [[ $monitor_state =~ "values=off" ]]; then
    echo false
  else
    echo "could not determine mic monitor status"
    exit 1
  fi
}

find_device() {
  local card=$(aplay -l | grep "$DEVICE_NAME" | head -n1 | awk '{print $2}' | sed 's/://g')
  echo $card
}

set_volume() {
  # numid=81,iface=MIXER,name='Mix A Input 01 Playback Volume'
  # numid=93,iface=MIXER,name='Mix B Input 01 Playback Volume'
  local card=$(find_device)
  amixer -c $card cset numid=81 $1
  amixer -c $card cset numid=93 $1
}

toggle_mic_monitor() {
  if [[ $1 == "true" ]]; then
    set_volume $VOLUME
  elif [[ $1 == "false" ]]; then
    set_volume "0%"
  fi
}

# Main loop
while true; do
  current_state=$(check_monitor_state)
  if [[ $current_state != "$previous_state" ]]; then
    echo "State changed to: $current_state"
    toggle_mic_monitor $current_state
  fi
  previous_state=$current_state
  sleep $SLEEP
done
