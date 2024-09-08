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


