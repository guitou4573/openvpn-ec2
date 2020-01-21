#!/bin/bash

API_ENDPOINT="[YOU AWS API ENDPOINT]"

curl -X GET \
  https://$API_ENDPOINT.execute-api.[YOUR_REGION].amazonaws.com/prod/stop-vpn \
  -H 'x-api-key: [YOUR_API_KEY_FOR_THE_/stop_ENDPOINT]'