#!/usr/bin/env fish
rm earthquake*
rm tsunami*
curl "https://api.dmdata.jp/v2/parameter/earthquake/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" >earthquake_parameter.json
curl "https://api.dmdata.jp/v2/parameter/tsunami/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" >tsunami_parameter.json
fvm dart run ./bin/jma_parameter_converter_internal.dart earthquake_station.json
fvm dart run ./bin/jma_parameter_converter_internal.dart tsunami_station.json
