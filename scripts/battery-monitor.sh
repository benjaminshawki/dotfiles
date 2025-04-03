#!/bin/bash

# Battery notification script that sends alerts at 20%, 10%, and 5% levels
# Designed to work with dunst for notifications

# Configuration
BATTERY_PATH="/sys/class/power_supply/BAT0" # This may need adjustment based on your system
CRITICAL_LEVEL=5
WARNING_LEVEL=10
NOTICE_LEVEL=20
CHECK_INTERVAL=300 # Check every 2 minutes

# Icons for notifications (using Unicode characters)
ICON_CRITICAL="🔴"
ICON_WARNING="🟠"
ICON_NOTICE="🟡"

# Function to send notification
send_notification() {
	local level=$1
	local icon=$2
	local urgency=$3

	notify-send -u "$urgency" "$icon Battery Low: $level%" "Connect charger soon to avoid data loss."
}

# Main loop
while true; do
	# Check if battery exists
	if [ ! -d "$BATTERY_PATH" ]; then
		echo "Battery not found at $BATTERY_PATH"
		exit 1
	fi

	# Get current battery status
	BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
	CHARGING_STATUS=$(cat "$BATTERY_PATH/status")

	# Only notify if discharging
	if [ "$CHARGING_STATUS" = "Discharging" ]; then
		# Check battery levels and notify accordingly
		if [ "$BATTERY_LEVEL" -le "$CRITICAL_LEVEL" ]; then
			send_notification "$BATTERY_LEVEL" "$ICON_CRITICAL" "critical"
		elif [ "$BATTERY_LEVEL" -le "$WARNING_LEVEL" ]; then
			send_notification "$BATTERY_LEVEL" "$ICON_WARNING" "critical"
		elif [ "$BATTERY_LEVEL" -le "$NOTICE_LEVEL" ]; then
			send_notification "$BATTERY_LEVEL" "$ICON_NOTICE" "normal"
		fi
	fi

	# Wait before checking again
	sleep "$CHECK_INTERVAL"
done
