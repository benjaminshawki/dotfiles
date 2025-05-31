#!/bin/bash

# Battery notification script that sends alerts at 20%, 10%, and 5% levels
# Designed to work with dunst for notifications

# Configuration
BATTERY_PATH="/sys/class/power_supply/BAT0" # This may need adjustment based on your system
CRITICAL_LEVEL=5
WARNING_LEVEL=10
NOTICE_LEVEL=20

# State file to track notification states across runs
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/battery_monitor_state"

# Icons for notifications (using Unicode characters)
ICON_CRITICAL="🔴"
ICON_WARNING="🟠"
ICON_NOTICE="🟡"

# Function to send notification
send_notification() {
	local level=$1
	local icon=$2
	local urgency=$3

	notify-send -u "$urgency" "$icon Battery Low: $level%"
}

# Load notification state from file
if [ -f "$STATE_FILE" ]; then
	source "$STATE_FILE"
else
	# Default values if no state file exists
	CRITICAL_NOTIFIED=0
	WARNING_NOTIFIED=0
	NOTICE_NOTIFIED=0
fi

# Check if battery exists
if [ ! -d "$BATTERY_PATH" ]; then
	echo "Battery not found at $BATTERY_PATH"
	exit 1
fi

# Get current battery status
BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
CHARGING_STATUS=$(cat "$BATTERY_PATH/status")

# Reset notification flags when charging
if [ "$CHARGING_STATUS" = "Charging" ] || [ "$CHARGING_STATUS" = "Full" ]; then
	CRITICAL_NOTIFIED=0
	WARNING_NOTIFIED=0
	NOTICE_NOTIFIED=0
# Only notify if discharging
elif [ "$CHARGING_STATUS" = "Discharging" ]; then
	# Check battery levels and notify accordingly
	if [ "$BATTERY_LEVEL" -le "$CRITICAL_LEVEL" ] && [ "$CRITICAL_NOTIFIED" -eq 0 ]; then
		send_notification "$BATTERY_LEVEL" "$ICON_CRITICAL" "critical"
		CRITICAL_NOTIFIED=1
		WARNING_NOTIFIED=1 # Mark lower levels as notified too
		NOTICE_NOTIFIED=1
	elif [ "$BATTERY_LEVEL" -le "$WARNING_LEVEL" ] && [ "$WARNING_NOTIFIED" -eq 0 ]; then
		send_notification "$BATTERY_LEVEL" "$ICON_WARNING" "critical"
		WARNING_NOTIFIED=1
		NOTICE_NOTIFIED=1 # Mark lower level as notified too
	elif [ "$BATTERY_LEVEL" -le "$NOTICE_LEVEL" ] && [ "$NOTICE_NOTIFIED" -eq 0 ]; then
		send_notification "$BATTERY_LEVEL" "$ICON_NOTICE" "normal"
		NOTICE_NOTIFIED=1
	fi
fi

# Save state
echo "CRITICAL_NOTIFIED=$CRITICAL_NOTIFIED" >"$STATE_FILE"
echo "WARNING_NOTIFIED=$WARNING_NOTIFIED" >>"$STATE_FILE"
echo "NOTICE_NOTIFIED=$NOTICE_NOTIFIED" >>"$STATE_FILE"
