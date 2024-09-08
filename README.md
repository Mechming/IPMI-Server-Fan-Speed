# Dynamic Fan Speed Control for Motherboard with IPMI support

This project provides a solution for dynamically controlling fan speeds on a Supermicro X11SSM-F motherboard using `ipmitool` and temperature sensors. The script continuously monitors the system's temperatures and adjusts the fan speeds accordingly, ensuring efficient cooling based on real-time data.

## Features

- Monitors critical temperature sensors such as `CPU Temp`, `System Temp`, and `Peripheral Temp`.
- Dynamically adjusts fan speeds based on the highest detected temperature:
  - **< 40°C** → Low speed (20%)
  - **40°C - 59°C** → Medium speed (50%)
  - **≥ 60°C** → High speed (100%)
- Runs as a background service on Proxmox (or any Linux-based system).
- Logs temperature readings and fan speed adjustments.

## Requirements

- **Proxmox VE** (or any Debian-based system)
- `ipmitool` installed
- `bc` utility for floating-point arithmetic
- motherboard with IPMI support

## Installation

- Create script file at /usr/local/bin/monitor_fan_speed.sh
- add contents to the script file using vi or nano
- chmod +x /usr/local/bin/monitor_fan_speed.sh
- Create a systemd service file at /etc/systemd/system/monitor_fan_speed.service
- add contents to the service file using vi or nano
- enable and start the service
- systemctl enable monitor_fan_speed.service && systemctl start monitor_fan_speed.service
- Check the status of the service to ensure it's running correctly
- systemctl status monitor_fan_speed.service
