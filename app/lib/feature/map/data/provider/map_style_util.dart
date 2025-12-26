import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
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

  Future<String> getStyle({required MapColorScheme colorScheme}) async {
    final json = {
      'version': 8,
      'name': 'EQMonitor Light',
      'sources': {
        'world': {
          'type': 'vector',
          'url': 'pmtiles://https://v2.map.eqmonitor.app/world.pmtiles',
        },
        'japan': {
          'type': 'vector',
          'url': 'pmtiles://https://v2.map.eqmonitor.app/japan.pmtiles',
        },
        'overview': {
          'type': 'vector',
          'url': 'pmtiles://https://v2.map.eqmonitor.app/overview.pmtiles',
        },
      },
      'layers': [
        {
          'id': 'background',
          'type': 'background',
          'paint': {'background-color': '#ffffff'},
        },
        {
          'id': 'countries',
          'type': 'line',
          'source': 'world',
          'source-layer': 'countries',
          'paint': {'line-color': '#cccccc', 'line-width': 1},
        },
        {
          'id': 'areaForecastLocalE',
          'type': 'line',
          'source': 'japan',
          'source-layer': 'areaForecastLocalE',
          'paint': {'line-color': '#666666', 'line-width': 1},
        },
        {
          'id': 'areaForecastLocalEew',
          'type': 'line',
          'source': 'japan',
          'source-layer': 'areaForecastLocalEew',
          'paint': {'line-color': '#ff9900', 'line-width': 1},
        },
        {
          'id': 'areaInformationCityQuake',
          'type': 'line',
          'source': 'japan',
          'source-layer': 'areaInformationCityQuake',
          'paint': {'line-color': '#ff0033', 'line-width': 1},
        },
        {
          'id': 'areaTsunami',
          'type': 'line',
          'source': 'japan',
          'source-layer': 'areaTsunami',
          'paint': {
            'line-color': '#3366cc',
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
