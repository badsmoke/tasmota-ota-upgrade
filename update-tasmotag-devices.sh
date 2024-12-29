#!/bin/bash

#new version
NEW_VERSION="14.4"

#Tasmota OTA URL
OTA_URL="http://ota.badcloud.eu/tasmota/$NEW_VERSION/tasmota-DE.bin"

# IP-Range
IP_RANGE="192.168.0.0/24"

# 
upgrade_tasmota() {
    ip=$1
    URL=$2
    echo "Updating Tasmota device at $ip"
    
    # set OTA URL
    curl -s -X POST "http://$ip/cm?cmnd=OTAURL%20$URL" > /dev/null
    sleep 3
    # start updgrade
    curl -s -X POST "http://$ip/cm?cmnd=Upgrade%201" > /dev/null
}


# scan local network
for ip in  $(nmap -sn $IP_RANGE | grep 'Nmap scan report' | awk '{print $5}'); do
    #check if tasmota device
    response=$(curl -s -m 2 "$ip/")
     if echo $response | grep -q "minimal\|Tasmota"; then
        #get version
        VERSION=$(curl -s "$ip/cm?cmnd=status%202" | jq .StatusFWR.Version -r | cut -d "(" -f1)
        if  [[ $VERSION = "null" ]]; then
            echo $ip minimal
            upgrade_tasmota "$ip" "$OTA_URL"
        else
            echo $ip non minimal
            OTA_URL_MINIMAL="http://ota.tasmota.com/tasmota/release-$VERSION/tasmota-minimal.bin.gz"
            upgrade_tasmota "$ip" "$OTA_URL_MINIMAL"       
        fi
    fi
done
