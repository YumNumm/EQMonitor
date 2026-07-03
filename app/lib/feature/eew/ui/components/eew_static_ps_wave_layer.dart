import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

/// 電文発表時刻基準での静的PS波到達円レイヤー
class EewStaticPsWaveLayer extends HookConsumerWidget {
  const EewStaticPsWaveLayer({
    required this.eew,
    super.key,
  });

  final EewTelegramItem? eew;

  static const _pWaveSourceId = 'eew-static-p-wave';
  static const _sWaveSourceId = 'eew-static-s-wave';
  static const _pWaveLayerId = 'eew-static-p-wave-line';
  static const _sWaveLayerId = 'eew-static-s-wave-line';
  static const _sWaveFillLayerId = 'eew-static-s-wave-fill';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final travelTimeMap = ref.watch(travelTimeDepthMapProvider);
    // レイヤー初期化処理のFuture。更新・破棄処理が初期化完了を待つために保持する
    final initFuture = useRef<Future<void>?>(null);

    // source / layer の追加は styleController が変化したときに一度だけ行う。
    // eew / travelTimeMap の変化で再初期化すると、非同期なクリーンアップ完了前に
    // addSource が走り「already exists」例外となるため、初期化と更新を分離する。
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        final future = _initializeLayers(styleController);
        initFuture.value = future;

        return () {
          initFuture.value = null;
          unawaited(() async {
            await future;
            await _removeLayers(styleController);
          }());
        };
      },
      [styleController],
    );

    // eew / travelTimeMap の変化に追従してデータのみ更新する
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await initFuture.value;
          await _updateLayers(
            styleController,
            eew,
            travelTimeMap,
          );
        }());

        return null;
      },
      [styleController, eew, travelTimeMap],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayers(StyleController styleController) async {
    // ホットリロードや前インスタンスの破棄処理との競合により既に source/layer が
    // 残っている場合に「already exists」例外となるため、追加前に削除を試みる。
    await _removeLayers(styleController);
    await (
      styleController.addSource(
        GeoJsonSource(
          id: _pWaveSourceId,
          data: jsonEncode({
            'type': 'FeatureCollection',
            'features': <Map<String, dynamic>>[],
          }),
        ),
      ),
      styleController.addSource(
        GeoJsonSource(
          id: _sWaveSourceId,
          data: jsonEncode({
            'type': 'FeatureCollection',
            'features': <Map<String, dynamic>>[],
          }),
        ),
      ),
    ).wait;

    await (
      styleController.addLayer(
        const LineStyleLayer(
          id: _pWaveLayerId,
          sourceId: _pWaveSourceId,
          paint: {
            'line-color': '#0000FF',
            'line-width': 1,
          },
        ),
      ),
      styleController.addLayer(
        const LineStyleLayer(
          id: _sWaveLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'line-color': ['get', 'lineColor'],
            'line-width': 2,
          },
        ),
      ),
      styleController.addLayer(
        const FillStyleLayer(
          id: _sWaveFillLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'fill-color': ['get', 'fillColor'],
            'fill-opacity': 0.2,
          },
        ),
        belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
      ),
    ).wait;
  }

  Future<void> _removeLayers(StyleController styleController) async {
    // layer は source を参照するため、layer → source の順で削除する。
    // 存在しない場合の例外は無視する。
    for (final layerId in [_pWaveLayerId, _sWaveLayerId, _sWaveFillLayerId]) {
      try {
        await styleController.removeLayer(layerId);
      } on Exception {
        // ignore
      }
    }
    for (final sourceId in [_pWaveSourceId, _sWaveSourceId]) {
      try {
        await styleController.removeSource(sourceId);
      } on Exception {
        // ignore
      }
    }
  }

  Future<void> _updateLayers(
    StyleController styleController,
    EewTelegramItem? eew,
    TravelTimeDepthMap travelTimeMap,
  ) async {
    if (eew == null) {
      await _clearLayers(styleController);
      return;
    }

    final hypocenter = eew.hypocenter;
    if (hypocenter == null ||
        hypocenter.latitude == null ||
        hypocenter.longitude == null) {
      await _clearLayers(styleController);
      return;
    }

    final depth = hypocenter.depth;
    final originTime = eew.originTime;

    if (depth == null || originTime == null || eew.isPlum) {
      await _clearLayers(styleController);
      return;
    }

    final elapsed = eew.reportTime.difference(originTime).inMilliseconds / 1000;
    final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

    final lat = hypocenter.latitude!;
    final lng = hypocenter.longitude!;

    final isWarning = eew.isWarning ?? false;
    final lineColor = isWarning ? '#FF0000' : '#FFA500';
    final fillColor = isWarning ? '#FF0000' : '#FFA500';

    final pWaveFeatures = <Map<String, dynamic>>[];
    final sWaveFeatures = <Map<String, dynamic>>[];

    if (travelTime.pDistance != null && travelTime.pDistance! > 0) {
      pWaveFeatures.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            _generateCircleCoordinates(lat, lng, travelTime.pDistance!),
          ],
        },
        'properties': <String, dynamic>{},
      });
    }

    if (travelTime.sDistance != null && travelTime.sDistance! > 0) {
      sWaveFeatures.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            _generateCircleCoordinates(lat, lng, travelTime.sDistance!),
          ],
        },
        'properties': {
          'lineColor': lineColor,
          'fillColor': fillColor,
        },
      });
    }

    await (
      styleController.updateGeoJsonSource(
        id: _pWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': pWaveFeatures,
        }),
      ),
      styleController.updateGeoJsonSource(
        id: _sWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': sWaveFeatures,
        }),
      ),
    ).wait;
  }

  Future<void> _clearLayers(StyleController styleController) async {
    await (
      styleController.updateGeoJsonSource(
        id: _pWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
      styleController.updateGeoJsonSource(
        id: _sWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    ).wait;
  }

  List<List<double>> _generateCircleCoordinates(
    double lat,
    double lng,
    double radiusKm,
  ) {
    const distance = latlong2.Distance();
    final center = latlong2.LatLng(lat, lng);
    final coordinates = <List<double>>[];

    for (var bearing = 0; bearing < 360; bearing += 4) {
      final point = distance.offset(center, radiusKm * 1000, bearing);
      coordinates.add([point.longitude, point.latitude]);
    }

    coordinates.add(coordinates.first);

    return coordinates;
  }
}
