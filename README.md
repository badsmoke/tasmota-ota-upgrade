# Update Tasmota Devices Script

This Bash script allows you to quickly and easily update Tasmota devices in your network.

## Dependencies

To run the script, you need the following tool:

- [jq](https://stedolan.github.io/jq/)

## Customization

Before running the script, customize the firmware version and the IP range:

```bash
VERSION=14.4.1
IP_RANGE="192.168.0.0/24"
```

## Usage

1. To flash all devices to the minimum firmware, run the script once:

   ```bash
   bash update-tasmota-devices.sh
   ```

2. To flash the specified firmware version, run the script again:

   ```bash
   bash update-tasmota-devices.sh
   ```

Good luck updating your Tasmota devices!
