import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/widget_to_image.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/station_intensity_icon_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の観測点震度レイヤー
///
/// [stationDisplayMode] に応じて観測点サイズを変更する。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級で色分けする。
/// [showLabel] が true の場合は観測点名ラベルを表示する。
/// [showIntensityIcon] が true の場合、観測点座標に震度アイコンを重ねて表示する（v2.6.0 互換）。
/// アイコンは [IntensityValueIcon] の [IntensityIconType.small]（通常）/
/// [IntensityIconType.smallWithoutText]（縮小）を使用する。
class EarthquakeHistoryStationIntensityLayer extends HookConsumerWidget {
  const EarthquakeHistoryStationIntensityLayer({
    required this.intensity,
    this.stationDisplayMode = StationDisplayMode.maxFocused,
    this.maxIntensity,
    this.showLabel = false,
    this.showingLpgmIntensity = false,
    this.showIntensityIcon = true,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final StationDisplayMode stationDisplayMode;

  /// 全観測点中の最大震度（maxFocused モードで比較に使用）
  final JmaIntensity? maxIntensity;
  final bool showLabel;
  final bool showingLpgmIntensity;

  /// 観測点に震度アイコンを重ねて表示するか（v2.6.0 互換）
  ///
  /// - [StationDisplayMode.normal]: 全観測点に `IntensityIconType.small`
  /// - [StationDisplayMode.maxFocused]: 最大震度観測点に `small`、その他に `smallWithoutText`
  /// - [StationDisplayMode.allMinimized]: 全観測点に `smallWithoutText`
  final bool showIntensityIcon;

  static const _sourceId = 'eq-history-station-intensity';
  static const _circleLayerId = 'eq-history-station-intensity-circle';
  static const _iconLayerId = 'eq-history-station-intensity-icon';
  static const _labelLayerId = 'eq-history-station-intensity-label';

  // アイコン画像 ID（region icon の eq-history-intensity-icon- と衝突しない prefix）
  static const _iconSmallPrefix = 'eq-station-sm-';
  static const _iconSmallNoTextPrefix = 'eq-station-sm-nt-';
  static const _lpgmIconSmallPrefix = 'eq-station-lpgm-sm-';
  static const _lpgmIconSmallNoTextPrefix = 'eq-station-lpgm-sm-nt-';

  /// v2.6.0 のレンダリングサイズに合わせた論理サイズ
  static const _iconLogicalSize = Size(50, 50);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        final container = ref.container;
        final cachedBytes = ref.read(stationIntensityIconBytesProvider);

        unawaited(() async {
          try {
            final geoJson = showingLpgmIntensity
                ? _buildLpgmGeoJson(intensity, colorModel)
                : _buildGeoJson(intensity, colorModel);

            await styleController.addSource(
              GeoJsonSource(id: _sourceId, data: geoJson),
            );

            await styleController.addLayer(
              CircleStyleLayer(
                id: _circleLayerId,
                sourceId: _sourceId,
                layout: const {
                  'circle-sort-key': ['get', 'sortKey'],
                },
                paint: {
                  'circle-radius': _buildRadiusExpression(),
                  'circle-color': ['get', 'color'],
                  'circle-stroke-color': '#ffffff',
                  'circle-stroke-width': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    4,
                    0.3,
                    10,
                    1.5,
                  ],
                },
              ),
            );

            if (showIntensityIcon) {
              await _registerIcons(
                styleController,
                container,
                pixelRatio,
                cachedBytes,
              );
              await styleController.addLayer(
                const SymbolStyleLayer(
                  id: _iconLayerId,
                  sourceId: _sourceId,
                  layout: {
                    'icon-image': ['get', 'iconId'],
                    'icon-allow-overlap': true,
                    'icon-ignore-placement': true,
                    // 高震度が上に描画されるよう sortKey（震度 index）を使用
                    'symbol-sort-key': ['get', 'sortKey'],
                    // v2.6.0 の iconSize 式 (zoom 3→0.04, zoom 7→0.3, zoom 20→1)
                    'icon-size': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      3,
                      0.04,
                      7,
                      0.3,
                      20,
                      1.0,
                    ],
                  },
                ),
              );
            }

            if (showLabel) {
              await styleController.addLayer(
                const SymbolStyleLayer(
                  id: _labelLayerId,
                  sourceId: _sourceId,
                  layout: {
                    'text-field': ['get', 'name'],
                    'text-size': 10,
                    'text-offset': [0, 1.2],
                    'text-anchor': 'top',
                    'text-allow-overlap': false,
                    'icon-allow-overlap': true,
                    'icon-ignore-placement': true,
                    'text-ignore-placement': true,
                  },
                  paint: {
                    'text-color': '#ffffff',
                    'text-halo-color': '#000000',
                    'text-halo-width': 1,
                  },
                ),
              );
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () async {
          try {
            if (showLabel) {
              await styleController.removeLayer(_labelLayerId);
            }
            if (showIntensityIcon) {
              await styleController.removeLayer(_iconLayerId);
            }
            await styleController.removeLayer(_circleLayerId);
            await styleController.removeSource(_sourceId);
          } on Exception catch (e) {
            talker.log(e);
          }
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        stationDisplayMode,
        maxIntensity,
        showLabel,
        showingLpgmIntensity,
        showIntensityIcon,
        pixelRatio,
      ],
    );

    return const SizedBox.shrink();
  }

  // ---------------------------------------------------------------------------
  // アイコン登録
  //
  // 起動時に EarthquakeHistoryStationIconPreloader が事前生成したバイト列が
  // StationIntensityIconBytes にあればそれを直接 addImage で登録する（高速）。
  // まだ生成されていないアイコンは renderWidgetToImageBytes でその場レンダリング
  // し、UncontrolledProviderScope(container) 経由で intensityColorProvider を
  // 参照できるようにする。
  // ---------------------------------------------------------------------------

  Future<void> _registerIcons(
    StyleController styleController,
    ProviderContainer container,
    double pixelRatio,
    Map<String, Uint8List> cachedBytes,
  ) async {
    final fromCache = <String, Uint8List>{};
    // その場レンダリングが必要なアイコン
    final toRender = <String, Widget>{};

    if (showingLpgmIntensity) {
      for (final lpgm in JmaLpgmIntensity.values) {
        for (final (prefix, type) in [
          (_lpgmIconSmallPrefix, IntensityIconType.small),
          (_lpgmIconSmallNoTextPrefix, IntensityIconType.smallWithoutText),
        ]) {
          final id = '$prefix${lpgm.name}';
          if (cachedBytes.containsKey(id)) {
            fromCache[id] = cachedBytes[id]!;
          } else {
            toRender[id] = UncontrolledProviderScope(
              container: container,
              child: LpgmIntensityIcon(
                intensity: lpgm,
                type: type,
              ),
            );
          }
        }
      }
    } else {
      for (final jma in JmaIntensity.values) {
        for (final (prefix, type) in [
          (_iconSmallPrefix, IntensityIconType.small),
          (_iconSmallNoTextPrefix, IntensityIconType.smallWithoutText),
        ]) {
          final id = '$prefix${jma.name}';
          if (cachedBytes.containsKey(id)) {
            fromCache[id] = cachedBytes[id]!;
          } else {
            toRender[id] = UncontrolledProviderScope(
              container: container,
              child: IntensityValueIcon(intensity: jma, type: type),
            );
          }
        }
      }
    }

    // キャッシュ済みは一括登録
    if (fromCache.isNotEmpty) {
      await styleController.addImages(fromCache);
    }

    // 未キャッシュはその場でレンダリング
    if (toRender.isNotEmpty) {
      final imageSize = Size(
        _iconLogicalSize.width * pixelRatio,
        _iconLogicalSize.height * pixelRatio,
      );
      for (final entry in toRender.entries) {
        final bytes = await renderWidgetToImageBytes(
          widget: entry.value,
          logicalSize: _iconLogicalSize,
          pixelRatio: pixelRatio,
        );
        if (bytes != null) {
          await styleController.addImage(entry.key, bytes);
        } else {
          // フォールバック: addImageFromWidget
          await styleController.addImageFromWidget(
            id: entry.key,
            widget: entry.value,
            logicalSize: _iconLogicalSize,
            imageSize: imageSize,
          );
        }
      }
    }
  }

  // ---------------------------------------------------------------------------
  // GeoJSON 構築
  // ---------------------------------------------------------------------------

  /// [stationDisplayMode] と [isFocused] に応じてアイコン ID を返す。
  String _iconIdForStation(String intensityName, bool isFocused) {
    final useSmall = switch (stationDisplayMode) {
      StationDisplayMode.normal => true,
      StationDisplayMode.maxFocused => isFocused,
      StationDisplayMode.allMinimized => false,
    };
    final prefix = useSmall ? _iconSmallPrefix : _iconSmallNoTextPrefix;
    return '$prefix$intensityName';
  }

  String _lpgmIconIdForStation(String lpgmName) {
    final useSmall = stationDisplayMode != StationDisplayMode.allMinimized;
    final prefix = useSmall ? _lpgmIconSmallPrefix : _lpgmIconSmallNoTextPrefix;
    return '$prefix$lpgmName';
  }

  String _buildGeoJson(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.intensityTree.entries) {
      final jmaIntensity = entry.key;
      final color = colorModel
          .fromJmaIntensity(jmaIntensity)
          .background
          .toHexStringRGB();
      final isFocused = maxIntensity != null && jmaIntensity == maxIntensity;
      final iconId = _iconIdForStation(jmaIntensity.name, isFocused);

      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final station = stationNode.station;
            if (!station.hasLatitude() || !station.hasLongitude()) {
              continue;
            }

            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.longitude, station.latitude],
              },
              'properties': {
                'color': color,
                'name': station.name,
                'isFocused': isFocused,
                'iconId': iconId,
                // 高震度が上に描画されるよう index をソートキーに使用
                'sortKey': jmaIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String _buildLpgmGeoJson(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.lpgmIntensityTree.entries) {
      final lpgmIntensity = entry.key;
      final color = colorModel
          .fromJmaLpgmIntensity(lpgmIntensity)
          .background
          .toHexStringRGB();
      final iconId = _lpgmIconIdForStation(lpgmIntensity.name);

      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final station = stationNode.station;
            if (!station.hasLatitude() || !station.hasLongitude()) {
              continue;
            }

            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.longitude, station.latitude],
              },
              'properties': {
                'color': color,
                'name': station.name,
                'isFocused': false,
                'iconId': iconId,
                // 高階級が上に描画されるよう index をソートキーに使用
                'sortKey': lpgmIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  // ---------------------------------------------------------------------------
  // 円サイズ expression (CircleStyleLayer 用)
  // ---------------------------------------------------------------------------

  List<Object> _buildRadiusExpression() {
    final smallRadius = [4, 1, 10, 3];
    final normalRadius = [4, 2, 10, 8];
    final largeRadius = [4, 3, 10, 10];

    switch (stationDisplayMode) {
      case StationDisplayMode.allMinimized:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          smallRadius[1],
          10,
          smallRadius[3],
        ];
      case StationDisplayMode.normal:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          normalRadius[1],
          10,
          normalRadius[3],
        ];
      case StationDisplayMode.maxFocused:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          [
            'case',
            ['get', 'isFocused'],
            largeRadius[1],
            smallRadius[1],
          ],
          10,
          [
            'case',
            ['get', 'isFocused'],
            largeRadius[3],
            smallRadius[3],
          ],
        ];
    }
  }
}
