import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_style.g.dart';

@Riverpod(keepAlive: true)
MapStyle mapStyle(Ref ref) => MapStyle();

class MapStyle {
  Future<String> _saveStyleJson(
    Map<String, dynamic> json,
    String prefix,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final documentDir = dir.path;
    final stylesDir = '$documentDir/styles';

    await Directory(stylesDir).create(recursive: true);
    final styleFile = File('$stylesDir/${prefix}style.json');
    await styleFile.writeAsString(jsonEncode(json));
    return styleFile.path;
  }

  Future<String> getStyle({
    required bool isDark,
    required ColorScheme scheme,
  }) async {
    if (kIsWeb) {
      return 'https://v2.map.eqmonitor.app/style-light.json';
    }
    final colorScheme = isDark
        ? MapColorScheme.dark()
        : MapColorScheme.light();
    final json = {
      'version': 8,
      'name': 'EQMonitor Style',
      'center': [
        139.767125,
        35.681236,
      ],
      'zoom': 5,
      'sources': {
        'eqmonitor_map': {
          'type': 'vector',
          'url': 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles',
          'attribution': '© 気象庁, Natural Earth',
        },
        'osm': {
          'type': 'raster',
          'tiles': ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
          'tileSize': 256,
          'attribution': '© OpenStreetMap contributors',
          'maxzoom': 19,
        },
      },
      'sprite': '',
      'glyphs': 'https://glyphs.geolonia.com/{fontstack}/{range}.pbf',
      'layers': [
        {
          'id': BaseLayer.background.name,
          'type': 'background',
          'paint': {
            'background-color': colorScheme.backgroundColor.toHexStringRGB,
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
            'fill-color': colorScheme.worldLandColor.toHexStringRGB,
          },
        },
        {
          'id': BaseLayer.countriesLines.name,
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'type': 'line',
          'layout': {'visibility': 'visible'},
          'paint': {
            'line-color': colorScheme.worldLineColor.toHexStringRGB,
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
            'fill-color': colorScheme.japanLandColor.toHexStringRGB,
          },
        },
        // areaForecastLocalEew_line
        {
          'id': BaseLayer.areaForecastLocalEewLine.name,
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalEew',
          'type': 'line',
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': colorScheme.japanLineColor.toHexStringRGB,
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
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': colorScheme.japanLineColor.toHexStringRGB,
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
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': colorScheme.japanLineColor.toHexStringRGB,
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
    return _saveStyleJson(json, 'maplibre-$isDark');
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
  ;
}

extension ColorCode on Color {
  /// sRGB色空間における Hexカラーコードを取得
  int get hex {
    // 色をsRGBに変換
    final color = withValues(colorSpace: ColorSpace.sRGB);
    // color.{r,g,b}は0~1までの値なので、255倍にする
    final r = (color.r * 255).toInt();
    final g = (color.g * 255).toInt();
    final b = (color.b * 255).toInt();
    return (r << 16) + (g << 8) + b;
  }
}
