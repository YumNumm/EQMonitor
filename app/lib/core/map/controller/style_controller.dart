import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/map/model/map_style_config.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'style_controller.g.dart';

/// マップのスタイルを制御するコントローラー
@riverpod
class MapStyleController extends _$MapStyleController {
  @override
  Future<MapStyleConfig> build() async {
    // デフォルトのスタイル設定
    return MapStyleConfig(
      theme: MapStyleTheme.light,
      colorScheme: MapStyleColorScheme.light(),
      styleString: await _generateStyle(MapStyleColorScheme.light()),
    );
  }

  /// スタイルを更新
  Future<void> updateStyle(MapStyleTheme theme) async {
    final colorScheme = switch (theme) {
      MapStyleTheme.light => MapStyleColorScheme.light(),
      MapStyleTheme.dark => MapStyleColorScheme.dark(),
      MapStyleTheme.system => throw UnimplementedError(),
    };
    state = AsyncData(
      MapStyleConfig(
        theme: theme,
        colorScheme: colorScheme,
        styleString: await _generateStyle(colorScheme),
      ),
    );
  }

  /// スタイルJSONを生成
  Future<String> _generateStyle(MapStyleColorScheme colorScheme) async {
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
          'url': 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles',
          'attribution': '© 気象庁, Natural Earth',
        },
      },
      'sprite': '',
      'glyphs': 'https://glyphs.geolonia.com/{fontstack}/{range}.pbf',
      'layers': [
        {
          'id': 'background',
          'type': 'background',
          'paint': {
            'background-color': _colorToHex(colorScheme.backgroundColor),
          },
        },
        {
          'id': 'countries-fill',
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'type': 'fill',
          'paint': {
            'fill-color': _colorToHex(colorScheme.landColor),
          },
        },
        {
          'id': 'countries-line',
          'source': 'eqmonitor_map',
          'source-layer': 'countries',
          'type': 'line',
          'paint': {
            'line-color': _colorToHex(colorScheme.lineColor),
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
          'id': 'japan-fill',
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'type': 'fill',
          'paint': {
            'fill-color': _colorToHex(colorScheme.japanLandColor),
          },
        },
        {
          'id': 'japan-line',
          'source': 'eqmonitor_map',
          'source-layer': 'areaForecastLocalE',
          'type': 'line',
          'paint': {
            'line-color': _colorToHex(colorScheme.japanLineColor),
            'line-width': 0.5,
          },
        },
      ],
    };

    return _saveStyleJson(json);
  }

  /// スタイルJSONをファイルに保存
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

  /// ColorをHex文字列に変換
  String _colorToHex(Color color) =>
      '#${color.hex.toRadixString(16).padLeft(6, '0')}';
}
