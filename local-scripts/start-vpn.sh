#!/bin/bash

API_ENDPOINT="[YOU AWS API ENDPOINT]"
API_KEY_GET="[YOUR API KEY FOR THE /get ENDPOINT]"
API_KEY_START="[YOUR API KEY FOR THE /start ENDPOINT ]"
AWS_REGION="[YOUR_REGION]"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

VPNIP=$(curl -s -X GET \
  https://$API_ENDPOINT.execute-api.$AWS_REGION.amazonaws.com/prod/get-vpn-ip \
  -H "x-api-key: $API_KEY_GET")
echo "VPN IP: $VPNIP"

if [ "$VPNIP" = "instance down" ];
then
    printf "Sending VPN start request:"
    curl -s -X GET \
    https://$API_ENDPOINT.execute-api.$AWS_REGION.amazonaws.com/prod/start-vpn \
    -H "x-api-key: $API_KEY_START"
    printf "\nWaiting for instance to start"
    for i in {1..4}
    do
      printf "."
      sleep 5
    done
fi

VPNIP=$(curl -s -X GET \
  https://$API_ENDPOINT.execute-api.$AWS_REGION.amazonaws.com/prod/get-vpn-ip \
  -H "x-api-key: $API_KEY_GET")
echo "VPN IP: $VPNIP"

if [ "$VPNIP" = "instance down" ];
then exit
fi

sed -i "/^remote /c\remote $VPNIP 443" $DIR/client.ovpn

sudo openvpn --config $DIR/client.ovpn