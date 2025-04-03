import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

/// EEWの予想震度を表示するレイヤー
class EewEstimatedIntensityLayer extends HookConsumerWidget
    implements MapLayer {
  const EewEstimatedIntensityLayer({super.key});

  @override
  String get layerId => _getLayerId(JmaForecastIntensity.values.first);

  Iterable<JmaForecastIntensity> get allowedIntensities =>
      JmaForecastIntensity.values.where(
        (e) =>
            e != JmaForecastIntensity.unknown && e != JmaForecastIntensity.zero,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final intensityColor = ref.watch(intensityColorProvider);
    final manager = useMemoized(
      () => _EewEstimatedIntensityPaintManager(color: intensityColor),
      [intensityColor],
    );

    final eews = ref.watch(eewAliveTelegramProvider);

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            unawaited(
              controller.synchronized(() async {
                final areas = _transformRegions(eews ?? []);
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
                            ['literal', areas[intensity] ?? []],
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

    // EEWの状態が変更されたときの処理
    ref.listen(eewProvider.select((value) => value.valueOrNull), (
      _,
      eews,
    ) async {
      if (!isInitialized.value) {
        return;
      }

      unawaited(
        controller.synchronized(() async {
          final areas = _transformRegions(eews ?? []);

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
                      ['literal', areas[intensity] ?? []],
                    ],
                  },
                ),
                sourceLayer: 'areaForecastLocalE',
              ),
          ].wait;
        }),
      );
    });

    return const SizedBox.shrink();
  }

  // 各予想震度ごとのレイヤーID
  static String _getLayerId(JmaForecastIntensity intensity) {
    final base = intensity.type
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('不明', 'unknown');
    return 'eew-estimated-intensity-fill-$base';
  }

  // EEWの予想震度地域情報を変換
  Map<JmaForecastIntensity, List<String>> _transformRegions(List<EewV1> eews) {
    // 震度予測がないEEWを除外
    final regionsFromEews =
        eews
            .where((e) => !e.isCanceled)
            .map((e) => e.regions)
            .nonNulls
            .expand((e) => e)
            .toList();

    // 同じ地域をまとめる
    final regionsGrouped = <String, List<EstimatedIntensityRegion>>{};
    for (final region in regionsFromEews) {
      regionsGrouped.putIfAbsent(region.code, () => []).add(region);
    }

    // 予想震度が最も大きいものを取り出す
    final regionsIntensityMax = <String, JmaForecastIntensity>{};
    for (final entry in regionsGrouped.entries) {
      if (entry.value.isEmpty) {
        continue;
      }

      JmaForecastIntensity? max;
      for (final region in entry.value) {
        final forecastMaxInt = region.forecastMaxInt.toDisplayMaxInt().maxInt;

        if (max == null || forecastMaxInt.index > max.index) {
          max = forecastMaxInt;
        }
      }

      if (max != null) {
        regionsIntensityMax[entry.key] = max;
      }
    }

    // Map<予想震度, List<地域コード>> に変換する
    final regionsIntensityGrouped = <JmaForecastIntensity, List<String>>{};
    for (final entry in regionsIntensityMax.entries) {
      final key = entry.value;
      regionsIntensityGrouped.putIfAbsent(key, () => []).add(entry.key);
    }

    return regionsIntensityGrouped;
  }
}

/// 予想震度ごとの塗りつぶし色を管理するクラス
class _EewEstimatedIntensityPaintManager {
  _EewEstimatedIntensityPaintManager({required IntensityColorModel color})
    : _color = color;

  final IntensityColorModel _color;

  Map<String, Object> getPaintForIntensity(JmaForecastIntensity intensity) {
    final color = _getColorForIntensity(intensity);
    return {'fill-color': color.toHexStringRGB()};
  }

  /// 予想震度に対応する色を取得
  Color _getColorForIntensity(JmaForecastIntensity intensity) =>
      _color.fromJmaForecastIntensity(intensity).background;
}
