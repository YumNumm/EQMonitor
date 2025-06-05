import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_configuration.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/notifier/intensity_color_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:synchronized/extension.dart';

/// 地震履歴の震度を表示するレイヤー
class EarthquakeIntensityRegionLayer extends HookConsumerWidget
    implements MapLayer {
  const EarthquakeIntensityRegionLayer({
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
    final intensityColor = ref.watch(intensityColorNotifierProvider).colorModel;
    final manager = useMemoized(
      () => _EarthquakeIntensityRegionPaintManager(color: intensityColor),
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
            if (earthquake.value == null) {
              return;
            }

            unawaited(
              controller.synchronized(() async {
                final areas = _transformRegions(earthquake.value!);
                await [
                  for (final intensity in allowedIntensities)
                    // レイヤーを追加
                    controller.addLayer(
                      _getLayerId(intensity),
                      'eqmonitor_map',
                      FillLayerProperties(
                        fillColor: manager
                            ._getColorForIntensity(intensity)
                            .toHexStringRGB(),
                      ),
                      filter: [
                        'in',
                        ['get', 'code'],
                        ['literal', areas[intensity] ?? []],
                      ],
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
      if (!isInitialized.value || next.value == null) {
        return;
      }

      unawaited(
        controller.synchronized(() async {
          final areas = _transformRegions(next.value!);

          await [
            for (final intensity in allowedIntensities)
            // レイヤーを更新
            ...[
              controller.setLayerProperties(
                _getLayerId(intensity),
                FillLayerProperties(
                  fillColor: manager
                      ._getColorForIntensity(intensity)
                      .toHexStringRGB(),
                ),
              ),
              controller.setFilter(_getLayerId(intensity), {
                'filter': [
                  'in',
                  ['get', 'code'],
                  ['literal', areas[intensity] ?? []],
                ],
              }),
            ],
          ].wait;
        }),
      );
    });

    useEffect(() {
      unawaited(
        controller.synchronized(
          () async => JmaIntensity.values
              .map(
                (intensity) => controller.setLayerVisibility(
                  _getLayerId(intensity),
                  visible,
                ),
              )
              .wait,
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
    return 'earthquake-intensity-fill-$base';
  }

  // 地震履歴の震度地域情報を変換
  Map<JmaIntensity, List<String>> _transformRegions(
    EarthquakeV1Extended earthquake,
  ) {
    if (earthquake.intensityRegions == null) {
      return {};
    }

    // 同じ地域をまとめる
    final regionsGrouped = <JmaIntensity, List<String>>{};
    for (final region in earthquake.intensityRegions!) {
      if (region.intensity == null) {
        continue;
      }

      regionsGrouped.putIfAbsent(region.intensity!, () => []).add(region.code);
    }

    return regionsGrouped;
  }
}

/// 震度ごとの塗りつぶし色を管理するクラス
class _EarthquakeIntensityRegionPaintManager {
  _EarthquakeIntensityRegionPaintManager({required IntensityColorModel color})
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
