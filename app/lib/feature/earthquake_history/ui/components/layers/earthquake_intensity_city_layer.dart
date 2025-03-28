import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
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
    final controller = MapController.of(context);
    final intensityColor = ref.watch(intensityColorProvider);
    final manager = useMemoized(
      () => _EarthquakeIntensityCityPaintManager(color: intensityColor),
      [intensityColor],
    );

    final earthquake = ref.watch(
      earthquakeHistoryDetailsNotifierProvider(eventId),
    );

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            if (earthquake.valueOrNull == null) {
              return;
            }

            unawaited(
              controller.synchronized(() async {
                final cities = _transformCities(earthquake.valueOrNull!);
                await [
                  for (final intensity in allowedIntensities)
                    // レイヤーを追加
                    controller.style!.addLayer(
                      FillStyleLayer(
                        id: _getLayerId(intensity),
                        sourceId: 'eqmonitor_map',
                        paint: manager.getPaintForIntensity(intensity),
                        layout: {
                          'filter': [
                            'in',
                            ['get', 'code'],
                            ['literal', cities[intensity] ?? []],
                          ],
                        },
                      ),
                      belowLayerId: BaseLayer.areaForecastLocalELine.name,
                      sourceLayer: 'areaForecastLocalE',
                    ),
                ].wait;
              }),
            );
            isInitialized.value = true;
          }),
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
      if (!isInitialized.value || next.valueOrNull == null) {
        return;
      }

      unawaited(
        controller.synchronized(() async {
          final cities = _transformCities(next.valueOrNull!);

          await [
            for (final intensity in allowedIntensities)
              // レイヤーを更新
              controller.style!.updateLayer(
                FillStyleLayer(
                  id: _getLayerId(intensity),
                  sourceId: 'eqmonitor_map',
                  paint: manager.getPaintForIntensity(intensity),
                  layout: {
                    'filter': [
                      'in',
                      ['get', 'code'],
                      ['literal', cities[intensity] ?? []],
                    ],
                  },
                ),
                sourceLayer: 'areaForecastLocalE',
              ),
          ].wait;
        }),
      );
    });

    useEffect(() {
      unawaited(
        controller.synchronized(
          () async => controller.style!.updateLayer(
            FillStyleLayer(
              id: _getLayerId(JmaIntensity.values.first),
              sourceId: 'eqmonitor_map',
              layout: {'visibility': visible ? 'visible' : 'none'},
            ),
          ),
        ),
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

/// 震度ごとの塗りつぶし色を管理するクラス
class _EarthquakeIntensityCityPaintManager {
  _EarthquakeIntensityCityPaintManager({required IntensityColorModel color})
    : _color = color;

  final IntensityColorModel _color;

  Map<String, Object> getPaintForIntensity(JmaIntensity intensity) {
    final color = _getColorForIntensity(intensity);
    return {'fill-color': color.toHexStringRGB()};
  }

  /// 震度に対応する色を取得
  Color _getColorForIntensity(JmaIntensity intensity) =>
      _color.fromJmaIntensity(intensity).background;
}
