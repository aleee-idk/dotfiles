#!/usr/bin/env bash

# Usage of this script:
# You need the below awesome function
# Then you pass positional argument to this script to send to awesome as follow:
# $1 Main text of the notification
# $2 Title of the notification
# $3 Position of the notification, can be:
# "top_right", "top_left", "bottom_left", "bottom_right", "top_middle", "bottom_middle"

#Change array field separator to $1, the rest are the parameters
join () {
    local IFS="$1"
    shift
    echo "$*"
}

# Parse script arguments to array
parameters=("$@")

# Add escapped quotes as pre and suffix
parameters=( "${parameters[@]/#/\"}" )
parameters=( "${parameters[@]/%/\"}" )

# Change space separated to comma separated
data=$(join , "${parameters[@]}")

# Send data to awesome, the above trouble make it dynamic
awesome-client "require(\"utils\").create_notification(${data[@]})"
