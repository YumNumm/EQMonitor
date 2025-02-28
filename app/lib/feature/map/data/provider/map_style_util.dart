import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_style_util.g.dart';

@Riverpod(keepAlive: true)
MapStyleUtil mapStyleUtil(Ref ref) => MapStyleUtil();

class MapStyleUtil {
  Future<String> _saveStyleJson(
    Map<String, dynamic> json,
  ) async {
    final jsonStr = jsonEncode(json);
    final hash =
        sha256.convert(utf8.encode(jsonStr)).toString();

    final dir = await getApplicationDocumentsDirectory();
    final documentDir = dir.path;
    final stylesDir = '$documentDir/styles';

    await Directory(stylesDir).create(recursive: true);
    final styleFile = File('$stylesDir/$hash.json');
    await styleFile.writeAsString(jsonEncode(json));
    return styleFile.path;
  }

  Future<String> getStyle({
    required MapColorScheme colorScheme,
  }) async {
    if (kIsWeb) {
      return 'https://v2.map.eqmonitor.app/style-light.json';
    }
    final json = {
      'version': 8,
      'name': 'EQMonitor Style',
      'center': [139.767125, 35.681236],
      'zoom': 5,
      'sources': {
        'eqmonitor_map': {
          'type': 'vector',
          'url':
              'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles',
          'attribution': '© 気象庁, Natural Earth',
        },
        'osm': {
          'type': 'raster',
          'tiles': [
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ],
          'tileSize': 256,
          'attribution': '© OpenStreetMap contributors',
          'maxzoom': 19,
        },
      },
      'sprite': '',
      'glyphs':
          'https://glyphs.geolonia.com/{fontstack}/{range}.pbf',
      'layers': [
        {
          'id': BaseLayer.background.name,
          'type': 'background',
          'paint': {
            'background-color':
                colorScheme.backgroundColor
                    .toHexStringRGB(),
          },
        },
        // {
        //   'id': 'osm',
        //   'type': 'raster',
        //   'source': 'osm',
        //   'paint': {
        //     'raster-opacity': 0.1,
        //   },
        // },
        {
          'id': BaseLayer.countriesFill.name,
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'type': 'fill',
          'layout': {'visibility': 'visible'},
          'paint': {
            'fill-color':
                colorScheme.worldLandColor.toHexStringRGB(),
          },
        },
        {
          'id': BaseLayer.countriesLines.name,
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'type': 'line',
          'layout': {'visibility': 'visible'},
          'paint': {
            'line-color':
                colorScheme.worldLineColor.toHexStringRGB(),
            'line-width': [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0.5,
              5.5,
              1,
            ],
          },
        },
        {
          'id': BaseLayer.areaForecastLocalEFill.name,
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'type': 'fill',
          'paint': {
            'fill-color':
                colorScheme.japanLandColor.toHexStringRGB(),
          },
        },
        // areaForecastLocalEew_line
        {
          'id': BaseLayer.areaForecastLocalEewLine.name,
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalEew',
          'type': 'line',
          'layout': {
            'line-cap': 'round',
            'line-join': 'round',
          },
          'paint': {
            'line-color':
                colorScheme.japanLineColor.toHexStringRGB(),
            'line-width': [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0.5,
              5.5,
              1,
            ],
          },
        },
        {
          'id': BaseLayer.areaForecastLocalELine.name,
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'type': 'line',
          'layout': {
            'line-cap': 'round',
            'line-join': 'round',
          },
          'paint': {
            'line-color':
                colorScheme.japanLineColor.toHexStringRGB(),
            'line-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0,
              5,
              0.2,
              5.5,
              1,
            ],
            'line-width': 0.5,
          },
        },
        // areaInformationCityQuake
        {
          'id': BaseLayer.areaInformationCityQuakeLine.name,
          'source': 'eqmonitor_map',
          'source-layer': 'areaInformationCityQuake',
          'type': 'line',
          'layout': {
            'line-cap': 'round',
            'line-join': 'round',
          },
          'paint': {
            'line-color':
                colorScheme.japanLineColor.toHexStringRGB(),
            'line-width': 0.5,
            'line-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              7,
              0,
              9.5,
              0.3,
            ],
          },
        },
      ],
    };

    return _saveStyleJson(json);
  }
}

enum BaseLayer {
  background,
  countriesLines,
  countriesFill,
  areaForecastLocalEFill,
  areaForecastLocalEewLine,
  areaForecastLocalELine,
  areaInformationCityQuakeLine,
}
