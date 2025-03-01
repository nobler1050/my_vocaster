#!/bin/bash

vocaster_present=$(arecord -l | grep -i "Vocaster")

if [ -n "$vocaster_present" ]; then
    # Vocaster is present
    systemctl --user start vocaster_xbox_mute.service
    systemctl --user start vocaster_mic_monitor.service
else
    # Vocaster is not present
    systemctl --user stop vocaster_xbox_mute.service
    systemctl --user stop vocaster_mic_monitor.service
fi
