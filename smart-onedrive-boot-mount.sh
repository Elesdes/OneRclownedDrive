#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
ICONS_DIR="$SCRIPT_DIR/icons"
ICON_HAPPY="$ICONS_DIR/icons8-happy-cloud-48.png"
ICON_SAD="$ICONS_DIR/icons8-sad-cloud-48.png"
ICON_SYNC="$ICONS_DIR/icons8-sync-cloud-48.png"
MOUNT_POINT="$HOME/OneDrive"
MIN_RETRY_DELAY=5
MAX_RETRY_DELAY=60

# Function to send desktop notification
notify() {
    local message="$1"
    local icon="$2"
    notify-send "OneDrive Mount" "$message" -i "$icon"
}

# Function to check internet connectivity
check_internet() {
    wget -q --spider http://google.com
}

# Function to check if OneDrive is mounted
is_mounted() {
    mountpoint -q "$MOUNT_POINT"
}

# Function to mount OneDrive
mount_onedrive() {
    rclone mount onedrive: "$MOUNT_POINT" \
        --file-perms=0777 \
        --vfs-cache-mode=full \
        --network-mode \
        --buffer-size=0 \
        --daemon

    sleep $MIN_RETRY_DELAY

    if is_mounted; then
        notify "OneDrive mounted successfully at '$MOUNT_POINT'" "$ICON_HAPPY"
        return 0
    fi
    return 1
}

# Wait for internet connection with exponential backoff
wait_for_internet() {
    local retry_delay=$MIN_RETRY_DELAY
    until check_internet; do
        notify "Waiting for internet connection... Next check in $retry_delay seconds." "$ICON_SYNC"
        sleep $retry_delay
        retry_delay=$(( retry_delay < MAX_RETRY_DELAY ? retry_delay * 2 : MAX_RETRY_DELAY ))
    done
}

# Attempt to mount OneDrive with retry
mount_with_retry() {
    local attempt=1
    local retry_delay=$MIN_RETRY_DELAY

    until mount_onedrive; do
        notify "Mount attempt $attempt failed. Retrying in $retry_delay seconds..." "$ICON_SAD"
        sleep $retry_delay
        retry_delay=$(( retry_delay < MAX_RETRY_DELAY ? retry_delay * 2 : MAX_RETRY_DELAY ))
        ((attempt++))
    done
}

wait_for_internet

if is_mounted; then
    notify "OneDrive is already mounted at '$MOUNT_POINT'" "$ICON_HAPPY"
else
    notify "Attempting to mount OneDrive..." "$ICON_SYNC"
    mount_with_retry
fi
