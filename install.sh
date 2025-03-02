#!/bin/bash

# Configuration
REPO_URL="https://github.com/nobler1050/my_vocaster/"
REPO_NAME=$(basename "$REPO_URL" .git)
INSTALL_DIR="$HOME/git/$REPO_NAME"
CONFIG_DIR="$HOME/.config/systemd/user"

# Ensure directories exist
mkdir -p "$HOME/git"
mkdir -p "$CONFIG_DIR"

# Clone the repository
if [ ! -d "$INSTALL_DIR" ]; then
  echo "Cloning repository..."
  git clone "$REPO_URL" "$INSTALL_DIR" || { echo "Failed to clone repository."; exit 1; }
else
  echo "Repository already cloned."
fi

link_files() {
  local source_file="$1"
  local target_file="$2"

  if [ -f "$INSTALL_DIR/$source_file" ]; then
    if [ ! -e "$CONFIG_DIR/$target_file" ]; then
      echo "Linking $source_file to $target_file..."
      ln -s "$INSTALL_DIR/$source_file" "$CONFIG_DIR/$target_file" || { echo "Failed to create link."; exit 1; }
    else
        echo "$CONFIG_DIR/$target_file already exists, skipping link creation."
    fi
  else
    echo "Source file $INSTALL_DIR/$source_file not found."
  fi
}

link_files "vocaster_mic_monitor.service" "vocaster_mic_monitor.service"
link_files "vocaster_xbox_mute.service" "vocaster_xbox_mute.service"
link_files "vocaster_present.service" "vocaster_present.service"
link_files "vocaster_present.timer" "vocaster_present.timer"

enable_services() {
  local service_name="$1"

  if [ -f "$CONFIG_DIR/$service_name" ]; then
    echo "Enabling service $service_name..."
    systemctl --user enable "$service_name" || { echo "Failed to enable service $service_name."; exit 1; }
  else
    echo "Service file $CONFIG_DIR/$service_name not found, skipping enable."
  fi
}

enable_services "vocaster_present.timer"

echo "Installation complete."

exit 0
