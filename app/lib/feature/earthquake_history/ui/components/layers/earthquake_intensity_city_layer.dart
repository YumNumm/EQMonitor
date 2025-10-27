import 'package:eqmonitor/core/util/color_converter.dart';
import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

/// 地震履歴の市区町村単位の震度を表示するレイヤー
class EarthquakeIntensityCityLayer extends HookConsumerWidget
    implements MapLayer {
  const EarthquakeIntensityCityLayer({
    required this.eventId,
    this.visible = true,
    super.key,
  });

  final int eventId;
  final bool visible;

  @override
  String get layerId => _getLayerId(JmaIntensity.values.first);

  Iterable<JmaIntensity> get allowedIntensities =>
      JmaIntensity.values.where((e) => e != JmaIntensity.fiveUpperNoInput);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapLibreInherited.of(context);
    final intensityColor = ref.watch(intensityColorProvider);

    final earthquake = ref.watch(
      earthquakeHistoryDetailsNotifierProvider(eventId),
    );

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async {
            if (earthquake.value == null) {
              return;
            }
            final style = controller.style;
            if (style == null) return;

            await controller.synchronized(() async {
              final cities = _transformCities(earthquake.value!);
              await [
                for (final intensity in allowedIntensities)
                  // レイヤーを追加
                  style.addLayer(
                    FillStyleLayer(
                      id: _getLayerId(intensity),
                      sourceId: 'eqmonitor_map',
                      paint: {
                        'fill-color':
                            intensityColor
                                .fromJmaIntensity(intensity)
                                .background
                                .toHexStringRGB(),
                      },
                      layout: {
                        'visibility': visible ? 'visible' : 'none',
                      },
                    ),
                    belowLayerId: BaseLayer.areaForecastLocalELine.name,
                  ),
              ].wait;
            });
            isInitialized.value = true;
          },
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    // 地震情報の状態が変更されたときの処理
    ref.listen(earthquakeHistoryDetailsNotifierProvider(eventId), (
      _,
      next,
    ) async {
      if (!isInitialized.value || next.value == null) {
        return;
      }
      final style = controller.style;
      if (style == null) return;

      unawaited(
        controller.synchronized(() async {
          final cities = _transformCities(next.value!);

          // レイヤーを削除して再追加で更新
          await [
            for (final intensity in allowedIntensities)
              () async {
                try {
                  await style.removeLayer(_getLayerId(intensity));
                } catch (_) {
                  // Layer doesn't exist, ignore
                }
                await style.addLayer(
                  FillStyleLayer(
                    id: _getLayerId(intensity),
                    sourceId: 'eqmonitor_map',
                    paint: {
                      'fill-color':
                          intensityColor
                              .fromJmaIntensity(intensity)
                              .background
                              .toHexStringRGB(),
                    },
                    layout: {
                      'visibility': visible ? 'visible' : 'none',
                    },
                  ),
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
              }(),
          ].wait;
        }),
      );
    });

    useEffect(() {
      final style = controller.style;
      if (style == null || !isInitialized.value) return null;
      
      unawaited(
        controller.synchronized(() async {
          if (earthquake.value == null) return;
          final cities = _transformCities(earthquake.value!);
          await [
            for (final intensity in allowedIntensities)
              () async {
                try {
                  await style.removeLayer(_getLayerId(intensity));
                } catch (_) {}
                await style.addLayer(
                  FillStyleLayer(
                    id: _getLayerId(intensity),
                    sourceId: 'eqmonitor_map',
                    paint: {
                      'fill-color':
                          intensityColor
                              .fromJmaIntensity(intensity)
                              .background
                              .toHexStringRGB(),
                    },
                    layout: {
                      'visibility': visible ? 'visible' : 'none',
                    },
                  ),
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
              }(),
          ].wait;
        }),
      );
      return null;
    }, [visible]);

    return const SizedBox.shrink();
  }

  // 各震度ごとのレイヤーID
  static String _getLayerId(JmaIntensity intensity) {
    final base = intensity.type
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('!5-', 'unknown');
    return 'earthquake-intensity-city-fill-$base';
  }

  // 地震履歴の震度市区町村情報を変換
  Map<JmaIntensity, List<String>> _transformCities(
    EarthquakeV1Extended earthquake,
  ) {
    if (earthquake.intensityCities == null) {
      return {};
    }

    // 同じ市区町村をまとめる
    final citiesGrouped = <JmaIntensity, List<String>>{};
    for (final city in earthquake.intensityCities!) {
      if (city.intensity == null) {
        continue;
      }

      citiesGrouped.putIfAbsent(city.intensity!, () => []).add(city.code);
    }

    return citiesGrouped;
  }
}
