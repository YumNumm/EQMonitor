import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

/// EEWの予想震度を表示するレイヤー
class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const EewEstimatedIntensityLayer({super.key});

  static const _baseLayerId = 'areaForecastLocalELine';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final intensityColor = ref.watch(intensityColorProvider);
    final manager = useMemoized(
      () => _EewEstimatedIntensityPaintManager(color: intensityColor),
      [intensityColor],
    );

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            // 各予想震度ごとにFill Layerを追加
            for (final intensity in JmaForecastIntensity.values) {
              final layerId = _getLayerId(intensity);
              await controller.style!.addLayer(
                FillStyleLayer(
                  id: layerId,
                  sourceId: 'eqmonitor_map',
                  paint: manager.getPaintForIntensity(intensity),
                ),
                belowLayerId: _baseLayerId,
              );
            }
            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
        unawaited(
          controller.synchronized(() async {
            for (final intensity in JmaForecastIntensity.values) {
              await controller.style!.removeLayer(_getLayerId(intensity));
            }
          }),
        );
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

      final activeEews = eews ?? [];
      final areas = _transformRegions(activeEews);

      unawaited(
        controller.synchronized(() async {
          for (final intensity in JmaForecastIntensity.values) {
            final layerId = _getLayerId(intensity);
            final codes = areas[intensity] ?? [];

            // レイヤーを更新
            await controller.style!.updateLayer(
              FillStyleLayer(
                id: layerId,
                sourceId: 'eqmonitor_map',
                paint: {...manager.getPaintForIntensity(intensity)},
                // layout: {
                //   'filter': [
                //     'in',
                //     ['get', 'code'],
                //     ['literal', codes],
                //   ],
                // },
              ),
            );
          }
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
  static Map<JmaForecastIntensity, List<String>> _transformRegions(
    List<EewV1> eews,
  ) {
    // 震度予測がないEEWを除外
    final regionsFromEews =
        eews
            .where((e) => !e.isCanceled)
            .map((e) => e.regions)
            .whereType<List<EstimatedIntensityRegion>>()
            .expand((e) => e)
            .toList();

    // 同じ地域をまとめる
    final regionsGrouped = <String, List<EstimatedIntensityRegion>>{};
    for (final region in regionsFromEews) {
      regionsGrouped.putIfAbsent(region.code, () => []).add(region);
    }

    // 予想震度が最も大きいものを取り出す
    final regionsIntensityMax = <String, ForecastMaxInt>{};
    for (final entry in regionsGrouped.entries) {
      if (entry.value.isEmpty) {
        continue;
      }

      ForecastMaxInt? max;
      for (final region in entry.value) {
        final forecastMaxInt = region.forecastMaxInt;

        if (max == null ||
            forecastMaxInt.toDisplayMaxInt().maxInt.index >
                max.toDisplayMaxInt().maxInt.index) {
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
      final key = entry.value.toDisplayMaxInt().maxInt;
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
    return {'fill-color': color.toHexStringRGB(), 'fill-opacity': 0.5};
  }

  /// 予想震度に対応する色を取得
  Color _getColorForIntensity(JmaForecastIntensity intensity) =>
      _color.fromJmaForecastIntensity(intensity).background;
}
