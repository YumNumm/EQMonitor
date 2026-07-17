import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_style_util.g.dart';

@Riverpod(keepAlive: true)
MapStyleUtil mapStyleUtil(Ref ref) => MapStyleUtil();

class MapStyleUtil {
  Future<String> _saveStyleJson(Map<String, dynamic> json) async {
    final jsonStr = jsonEncode(json);
    final hash = sha256.convert(utf8.encode(jsonStr)).toString();

    final dir = await getApplicationDocumentsDirectory();
    final documentDir = dir.path;
    final stylesDir = '$documentDir/styles';

    await Directory(stylesDir).create(recursive: true);
    final styleFile = File('$stylesDir/$hash.json');
    await styleFile.writeAsString(jsonStr);
    return styleFile.path;
  }

  Future<String> getStyle({required MapColors mapColors}) async {
    final mapSourceUrl = kIsWeb
        ? 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles'
        : switch (defaultTargetPlatform) {
            .android ||
            .iOS => 'pmtiles://asset://earthquake_tsunami_all.pmtiles',
            _ => 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles',
          };
    final json = {
      'version': 8,
      'name': 'EQMonitor Style',
      'glyphs': 'https://glyphs.geolonia.com/{fontstack}/{range}.pbf',
      'sources': {
        'eqmonitor_map': {'type': 'vector', 'url': mapSourceUrl},
      },
      'layers': [
        // 背景
        {
          'id': BaseLayer.background.name,
          'type': 'background',
          'paint': {'background-color': mapColors.background.toHexStringRGB()},
        },
        // 世界地図（塗りつぶし）
        {
          'id': BaseLayer.countriesFill.name,
          'type': 'fill',
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'layout': {'visibility': 'visible'},
          'paint': {'fill-color': mapColors.worldLand.toHexStringRGB()},
        },
        // 世界地図（境界線）
        {
          'id': BaseLayer.countriesLine.name,
          'type': 'line',
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'layout': {'visibility': 'visible'},
          'paint': {
            'line-color': mapColors.worldLine.toHexStringRGB(),
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
        // 日本地図（塗りつぶし）- areaForecastLocalE
        {
          'id': BaseLayer.areaForecastLocalEFill.name,
          'type': 'fill',
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'paint': {'fill-color': mapColors.japanLand.toHexStringRGB()},
        },
        // 緊急地震速報用区域（境界線）
        {
          'id': BaseLayer.areaForecastLocalEewLine.name,
          'type': 'line',
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalEew',
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': mapColors.japanLine.toHexStringRGB(),
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
        // 日本地図（境界線）- areaForecastLocalE
        {
          'id': BaseLayer.areaForecastLocalELine.name,
          'type': 'line',
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': mapColors.japanLine.toHexStringRGB(),
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
        // 市区町村（境界線）
        {
          'id': BaseLayer.areaInformationCityQuakeLine.name,
          'type': 'line',
          'source': 'eqmonitor_map',
          'source-layer': 'areaInformationCityQuake',
          'layout': {'line-cap': 'round', 'line-join': 'round'},
          'paint': {
            'line-color': mapColors.japanLine.toHexStringRGB(),
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
  countriesFill,
  countriesLine,
  areaForecastLocalEFill,
  areaForecastLocalEewLine,
  areaForecastLocalELine,
  areaInformationCityQuakeLine,
}
