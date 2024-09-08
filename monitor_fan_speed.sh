#!/bin/bash

# Function to set fan speed based on temperature
set_fan_speed() {
    local temp=$1
    
    if (( $(echo "$temp < 40" | bc -l) )); then
        # Set fan speed to low (20%)
        ipmitool raw 0x30 0x70 0x66 0x01 0x00 0x14
    elif (( $(echo "$temp < 60" | bc -l) )); then
        # Set fan speed to medium (50%)
        ipmitool raw 0x30 0x70 0x66 0x01 0x00 0x32
    else
        # Set fan speed to high (100%)
        ipmitool raw 0x30 0x70 0x66 0x01 0x00 0x64
    fi
}

while true; do
    # Gettemperature readings
    cpu_temp=$(ipmitool sensor | grep "CPU Temp" | awk '{print $4}')
    system_temp=$(ipmitool sensor | grep "System Temp" | awk '{print $4}')
    peripheral_temp=$(ipmitool sensor | grep "Peripheral Temp" | awk '{print $4}')
    
    # Find the highest temperature 
    highest_temp=$cpu_temp
    if (( $(echo "$system_temp > $highest_temp" | bc -l) )); then
        highest_temp=$system_temp
    fi
    if (( $(echo "$peripheral_temp > $highest_temp" | bc -l) )); then
        highest_temp=$peripheral_temp
    fi

    # Ensure numeric
    if [[ "$highest_temp" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        set_fan_speed $highest_temp

        # Log action
        echo "Highest Temp: $highest_temp°C, Fan speed adjusted at $(date)" >> /var/log/fan_control.log
    fi

    # Changes frequency of checking temp
    sleep 60
done
