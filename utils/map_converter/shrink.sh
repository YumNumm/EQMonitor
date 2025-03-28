#!/bin/bash

if [ -d "data/geojson_shrinked" ]; then
    rm -rf data/geojson_shrinked
fi

cp -r data/geojson data/geojson_shrinked

for file in data/geojson_shrinked/*.geojson; do
    mv $file $file.tmp
    echo "Shrinking $file"
    # CityQuakeだけデカすぎてエラー出るので https://mapshaper.org/ からやる
    mapshaper-xl 20gb $file.tmp -simplify dp 1% -o $file
    rm $file.tmp
done
