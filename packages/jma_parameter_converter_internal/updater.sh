#!/usr/bin/env fish
rm earthquake* 2> /dev/null
rm tsunami* 2> /dev/null
curl -qL "https://api.dmdata.jp/v2/parameter/earthquake/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" > earthquake_parameter.json
curl -qL "https://api.dmdata.jp/v2/parameter/tsunami/station" -H "authorization: Basic $(echo "$DMDATA_TOKEN": | base64)" > tsunami_parameter.json
fvm dart run ./bin/jma_parameter_converter_internal.dart earthquake_parameter.json
fvm dart run ./bin/jma_parameter_converter_internal.dart tsunami_parameter.json

mv earthquake_parameter.buffer earthquake
mv tsunami_parameter.buffer tsunami

# check should continue or not from stdin
echo "========= Check hash of the files ========="
echo "downloading..."
wrangler r2 object get eqmonitor-prod/parameter/earthquake -f ./earthquake-old
wrangler r2 object get eqmonitor-prod/parameter/tsunami -f ./tsunami-old

echo "========= Check hash of the files ========="
echo "hash of earthquake old"
set EARTHQUAKE_OLD_HASH $(md5sum earthquake-old | awk '{print $1}')
echo $EARTHQUAKE_OLD_HASH
echo "hash of earthquake new"
set EARTHQUAKE_NEW_HASH $(md5sum earthquake | awk '{print $1}')

echo "hash of tsunami old"
set TSUNAMI_OLD_HASH $(md5sum tsunami-old | awk '{print $1}')
echo $TSUNAMI_OLD_HASH
echo "hash of tsunami new"
set TSUNAMI_NEW_HASH $(md5sum tsunami | awk '{print $1}')

echo "========= Check has is same or not ========="
# check if the hash is same or not
# if hash is same, then exit
if test $EARTHQUAKE_OLD_HASH = $EARTHQUAKE_NEW_HASH -a $TSUNAMI_OLD_HASH = $TSUNAMI_NEW_HASH
  echo "hash is same. exit"
  exit 0
end


wrangler r2 object put eqmonitor-prod/parameter/earthquake -f ./earthquake --ct application/octet-stream
wrangler r2 object put eqmonitor-prod/parameter/tsunami -f ./tsunami --ct application/octet-stream
