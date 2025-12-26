#!/usr/bin/env fish
rm earthquake* 2> /dev/null
rm tsunami* 2> /dev/null
curl -qL "https://api.dmdata.jp/v2/parameter/earthquake/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" > earthquake_parameter.json
curl -qL "https://api.dmdata.jp/v2/parameter/tsunami/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" > tsunami_parameter.json
dart run ./bin/jma_parameter_converter_internal.dart earthquake_parameter.json
dart run ./bin/jma_parameter_converter_internal.dart tsunami_parameter.json

mv earthquake_parameter.buffer earthquake
mv tsunami_parameter.buffer tsunami
