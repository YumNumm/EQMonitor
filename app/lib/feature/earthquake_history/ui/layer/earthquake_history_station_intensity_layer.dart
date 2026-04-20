import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart'
    show IntensityIconType;
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart'
    show IntensityValueIcon;
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
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
/// アイコンは [IntensityIconType.small]（通常表示）/ [IntensityIconType.smallWithoutText]（縮小表示）に対応。
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
  /// true のとき:
  ///   - [StationDisplayMode.normal]: 全観測点に `IntensityIconType.small` アイコン（数字あり）
  ///   - [StationDisplayMode.maxFocused]: 最大震度観測点に small、その他に smallWithoutText
  ///   - [StationDisplayMode.allMinimized]: 全観測点に smallWithoutText（数字なし）
  final bool showIntensityIcon;

  static const _sourceId = 'eq-history-station-intensity';
  static const _circleLayerId = 'eq-history-station-intensity-circle';
  static const _iconLayerId = 'eq-history-station-intensity-icon';
  static const _labelLayerId = 'eq-history-station-intensity-label';

  // アイコン画像 ID（region icon の eq-history-intensity-icon- とは別 prefix で衝突回避）
  static const _iconSmallPrefix = 'eq-station-sm-';
  static const _iconSmallNoTextPrefix = 'eq-station-sm-nt-';
  static const _lpgmIconSmallPrefix = 'eq-station-lpgm-sm-';
  static const _lpgmIconSmallNoTextPrefix = 'eq-station-lpgm-sm-nt-';

  static const _iconLogicalSize = 64.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

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
              await _registerIcons(styleController, colorModel);
              await styleController.addLayer(
                const SymbolStyleLayer(
                  id: _iconLayerId,
                  sourceId: _sourceId,
                  layout: {
                    'icon-image': ['get', 'iconId'],
                    'icon-allow-overlap': true,
                    'icon-ignore-placement': true,
                    'icon-size': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      3,
                      0.1,
                      7,
                      0.35,
                      12,
                      0.75,
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
      ],
    );

    return const SizedBox.shrink();
  }

  // ---------------------------------------------------------------------------
  // アイコン登録: IntensityValueIcon.small / smallWithoutText に対応する
  // 非 Consumer ヘルパーウィジェットを addImageFromWidget で登録する
  // ---------------------------------------------------------------------------

  Future<void> _registerIcons(
    StyleController styleController,
    IntensityColorModel colorModel,
  ) async {
    const size = Size(_iconLogicalSize, _iconLogicalSize);

    if (showingLpgmIntensity) {
      for (final lpgm in JmaLpgmIntensity.values) {
        final cs = colorModel.fromJmaLpgmIntensity(lpgm);
        await styleController.addImageFromWidget(
          id: '$_lpgmIconSmallPrefix${lpgm.name}',
          widget: _IntensitySmallIcon(
            bgColor: cs.background,
            fgColor: cs.foreground,
            mainText: lpgm.label,
            suffix: '',
          ),
          logicalSize: size,
        );
        await styleController.addImageFromWidget(
          id: '$_lpgmIconSmallNoTextPrefix${lpgm.name}',
          widget: _IntensitySmallWithoutTextIcon(
            bgColor: cs.background,
            fgColor: cs.foreground,
          ),
          logicalSize: size,
        );
      }
    } else {
      for (final jmaIntensity in JmaIntensity.values) {
        final cs = colorModel.fromJmaIntensity(jmaIntensity);
        final suffix = jmaIntensity.label.contains('-')
            ? '-'
            : jmaIntensity.label.contains('+')
            ? '+'
            : '';
        await styleController.addImageFromWidget(
          id: '$_iconSmallPrefix${jmaIntensity.name}',
          widget: _IntensitySmallIcon(
            bgColor: cs.background,
            fgColor: cs.foreground,
            mainText: jmaIntensity.mainText,
            suffix: suffix,
          ),
          logicalSize: size,
        );
        await styleController.addImageFromWidget(
          id: '$_iconSmallNoTextPrefix${jmaIntensity.name}',
          widget: _IntensitySmallWithoutTextIcon(
            bgColor: cs.background,
            fgColor: cs.foreground,
          ),
          logicalSize: size,
        );
      }
    }
  }

  // ---------------------------------------------------------------------------
  // GeoJSON 構築
  // ---------------------------------------------------------------------------

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

// -----------------------------------------------------------------------------
// アイコン描画ヘルパーウィジェット（非 Consumer）
// IntensityValueIcon.small / smallWithoutText の見た目を再現する。
// addImageFromWidget で使用するため Riverpod 不使用。
// -----------------------------------------------------------------------------

/// [IntensityValueIcon] の `IntensityIconType.small` に対応する非 Consumer 版。
/// 丸アイコンに震度数字（+ 弱/強 の符号 `-`/`+`）を表示する。
class _IntensitySmallIcon extends StatelessWidget {
  const _IntensitySmallIcon({
    required this.bgColor,
    required this.fgColor,
    required this.mainText,
    required this.suffix,
  });

  final Color bgColor;
  final Color fgColor;
  final String mainText;

  /// `intensity.label` から導出した符号（`-`, `+`, or `''`）
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.lerp(bgColor, fgColor, 0.3)!;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          border: Border.all(color: borderColor, width: 5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                      color: fgColor,
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.notoSansMono,
                    ),
                  ),
                  if (suffix.isNotEmpty)
                    Text(
                      suffix,
                      style: TextStyle(
                        color: fgColor,
                        fontSize: 80,
                        fontFamily: FontFamily.notoSansMono,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// [IntensityValueIcon] の `IntensityIconType.smallWithoutText` に対応する非 Consumer 版。
/// テキストなしの丸アイコンを表示する。
class _IntensitySmallWithoutTextIcon extends StatelessWidget {
  const _IntensitySmallWithoutTextIcon({
    required this.bgColor,
    required this.fgColor,
  });

  final Color bgColor;
  final Color fgColor;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.lerp(bgColor, fgColor, 0.3)!;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          border: Border.all(color: borderColor, width: 5),
        ),
      ),
    );
  }
}
