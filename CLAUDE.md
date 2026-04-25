# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Configuration and automation toolkit for the **Focusrite Vocaster Two** audio interface on Fedora 41. Enables simultaneous audio routing from a Linux laptop and an Xbox Series X through the Vocaster's TRRS port via ALSA mixer controls and systemd user services.

## Architecture

The system has three layers:

1. **Presence detection** — `vocaster_present.timer` fires every 10 minutes (and 1 minute after boot), triggering `vocaster_present.sh` which checks if the Vocaster hardware is connected via `arecord -l`. It starts or stops the two monitoring services accordingly.

2. **Button monitors** — two long-running services that poll ALSA mixer controls in a tight loop (0.1s interval):
   - `vocaster_mic_monitor.sh` watches mixer control #21 (Line In 2 DSP Capture Switch / guest enhance button). When active, sets Mix A+B input volumes to 70%; when inactive, mutes them.
   - `vocaster_xbox_mute.sh` watches mixer control #37 (Line In 2 Mute Capture Switch / guest mute button). When muted, sets Mix C+D to 0%; when unmuted, sets them to 85%.

3. **ALSA state** — `vocaster_two.state` persists the hardware mixer state (loaded via `alsactl restore`).

All scripts dynamically locate the Vocaster device by name rather than hardcoding a card index.

## Deployment

Installation symlinks the systemd unit files into `~/.config/systemd/user/` and enables the timer:

```bash
bash install.sh
```

Or remotely:

```bash
curl -s https://raw.githubusercontent.com/nobler1050/my_vocaster/refs/heads/main/install.sh | bash
```

## Common systemd Commands

```bash
# Check service status
systemctl --user status vocaster_present.timer
systemctl --user status vocaster_mic_monitor.service
systemctl --user status vocaster_xbox_mute.service

# View logs
journalctl --user -u vocaster_mic_monitor.service -f
journalctl --user -u vocaster_xbox_mute.service -f

# Manually trigger presence check
systemctl --user start vocaster_present.service

# Reload after editing unit files
systemctl --user daemon-reload

# Save current ALSA mixer state
alsactl --user store -f vocaster_two.state

# Restore ALSA mixer state
alsactl --user restore -f vocaster_two.state
```

## External Dependencies

- `alsa-utils` — provides `arecord`, `amixer`, `alsactl`
- `alsa-scarlett-gui` — GUI for Focusrite mixer controls
- `alsa-ucm-conf` — ALSA UCM configuration for the Vocaster

## Key ALSA Controls

| Control # | Name | Purpose |
|-----------|------|---------|
| 21 | Line In 2 DSP Capture Switch | Guest enhance button → mic monitor toggle |
| 37 | Line In 2 Mute Capture Switch | Guest mute button → Xbox audio mute |
