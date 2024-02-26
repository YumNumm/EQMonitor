// ignore_for_file: provider_dependencies
import 'dart:developer';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart' as eqapi_types;
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/map/map_style.dart';
import 'package:eqmonitor/feature/earthquake_history_old/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/features/map/model/main_map_viewmodel_state.dart';
import 'package:eqmonitor/feature/home/features/travel_time/provider/travel_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre_gl/maplibre_gl.dart' as maplibre_gl;
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_map_viewmodel.freezed.dart';
part 'main_map_viewmodel.g.dart';

@Riverpod(
  keepAlive: true,
)
class MainMapViewModel extends _$MainMapViewModel {
  @override
  MainMapViewmodelState build() {
    ref
      ..listen(
        kmoniViewModelProvider,
        (_, value) {
          final analyzedPoints = value.analyzedPoints;
          if (analyzedPoints == null) {
            return;
          }
          _onKmoniStateChanged(analyzedPoints);
        },
      )
      ..listen(
        eewAliveTelegramProvider,
        (_, value) => _onEewStateChanged(value ?? []),
      )
      ..listen(
        estimatedIntensityProvider,
        (_, value) => _onEstimatedIntensityChanged(value),
      )
      ..listen(
        kmoniSettingsProvider.select((e) => e.useKmoni),
        (_, value) => _onKmoniSettingsChanged(value: value),
      );
    return MainMapViewmodelState(
      isHomePosition: true,
      homeBoundary: defaultBoundary,
    );
  }

  static LatLngBounds defaultBoundary = LatLngBounds(
    southwest: const LatLng(30, 128.8),
    northeast: const LatLng(45.8, 145.1),
  );

  MaplibreMapController? _controller;

  /// 実行前に `travelTimeDepthMapProvider`, `hypocenterIconRenderProvider`,
  /// `hypocenterLowPreciseIconRenderProvider` が初期化済みであることを確認すること
  Future<void> onMapControllerRegistered() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    _kmoniObservationPointService = _KmoniObservationPointService(
      controller: controller,
    );
    _eewHypocenterService = _EewHypocenterService(
      controller: controller,
    );
    _eewPsWaveService = _EewPsWaveService(
      controller: controller,
      travelTimeMap: ref.read(travelTimeDepthMapProvider).requireValue,
    );
    _eewEstimatedIntensityService = _EewEstimatedIntensityService(
      controller: controller,
    );

    await moveToHomeBoundary();

    await (
      _kmoniObservationPointService!.init(),
      _eewHypocenterService!.init(
        hypocenterIcon: ref.read(hypocenterIconRenderProvider)!,
        hypocenterLowPreciseIcon:
            ref.read(hypocenterLowPreciseIconRenderProvider)!,
      ),
      _eewPsWaveService!.init(),
      _eewEstimatedIntensityService!.init(
        ref.read(intensityColorProvider),
      ),
    ).wait;

    // 地図の移動を監視
    controller.addListener(() {
      final position = controller.cameraPosition;
      if (position != null && state.isHomePosition) {
        state = state.copyWith(
          isHomePosition: false,
        );
      }
    });
    ref.onDispose(() async {
      await (
        _kmoniObservationPointService!.dispose(),
        _eewHypocenterService!.dispose(),
        _eewPsWaveService!.dispose(),
        _eewEstimatedIntensityService!.dispose(),
      ).wait;
    });
  }

  Future<void> onTick(DateTime now) async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    if (_eewPsWaveService == null || _eewHypocenterService == null) {
      return;
    }
    try {
      await (
        _eewPsWaveService!.tick(now: now),
        _eewHypocenterService!.tick(),
      ).wait;
      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }

  // *********** EEW Related ***********
  bool _isEewInitialized = false;

  _EewHypocenterService? _eewHypocenterService;
  _EewPsWaveService? _eewPsWaveService;
  _EewEstimatedIntensityService? _eewEstimatedIntensityService;

  Future<void> _onEewStateChanged(List<EarthquakeHistoryItem> values) async {
    // 初期化が終わっていない場合は何もしない
    if (!_isEewInitialized) {
      return;
    }
    final aliveBodies = values
        .map((e) => e.latestEew)
        .whereType<TelegramVxse45Body>()
        .where((e) => e.hypocenter != null && e.hypocenter!.coordinate != null)
        .toList();
    final normalEews = values
        .where(
          (e) =>
              e.latestEewTelegram != null && e.latestEew is TelegramVxse45Body,
        )
        .map(
          (e) => (e.latestEewTelegram!, e.latestEew! as TelegramVxse45Body),
        )
        .where((e) => !(e.$2.isIpfOnePoint || e.$2.isLevelEew || e.$2.isPlum))
        .map(
          (e) => (e.$2, (e.$1.headline ?? '').contains('強い揺れ')),
        )
        .toList();
    _eewPsWaveService!.update(normalEews);
    await _eewHypocenterService!.update(aliveBodies);
    final transformed = _EewEstimatedIntensityService.transform(
      aliveBodies
          .map((e) => e.regions)
          .whereType<List<EewRegion>>()
          .flattened
          .toList(),
    );
    await _eewEstimatedIntensityService!.update(transformed);
  }

  Future<void> _onEstimatedIntensityChanged(
    List<AnalyzedKmoniObservationPoint> points,
  ) async {
    final boundary = _getEstimatedIntensityBoundary(points);
    try {
      await changeHomeBoundaryWithAnimation(
        bounds: boundary ?? defaultBoundary,
      );
    } on Exception catch (e) {
      log('error $e');
    }
  }

  LatLngBounds? _getEstimatedIntensityBoundary(
    List<AnalyzedKmoniObservationPoint> points,
  ) {
    if (points.isEmpty) {
      return null;
    }
    final aliveEews = ref.read(eewAliveTelegramProvider);

    final telegrams = aliveEews
        ?.map(
          (e) => e.latestEew,
        )
        .whereType<TelegramVxse45Body>();
    final coords =
        telegrams?.map((e) => e.hypocenter?.coordinate).whereNotNull() ?? [];

    final first = points.first;
    if (first.intensityValue == null) {
      return null;
    }

    final latLngs = [
      ...points
          .where((e) => first.intensityValue! < e.intensityValue! + 2)
          .where((e) => e.intensityValue! > 1)
          .map((e) => e.point.latLng),
      ...coords.map(
        (e) => lat_lng.LatLng(
          e.lat + 3,
          e.lon + 3,
        ),
      ),
      ...coords.map(
        (e) => lat_lng.LatLng(
          e.lat - 3,
          e.lon - 3,
        ),
      ),
    ];
    return latLngs.toBounds;
  }

  // *********** Kyoshin Monitor Related ***********
  _KmoniObservationPointService? _kmoniObservationPointService;
  Future<void> _onKmoniStateChanged(
    List<AnalyzedKmoniObservationPoint> values,
  ) async {
    if (_controller == null) {
      return;
    }
    if (!ref.read(kmoniSettingsProvider).useKmoni) {
      await _kmoniObservationPointService?.update([]);
      return;
    }

    await _kmoniObservationPointService?.update(values);
  }

  Future<void> _onKmoniSettingsChanged({required bool value}) async {
    if (value) {
      await _kmoniObservationPointService?.dispose();
      _kmoniObservationPointService = _KmoniObservationPointService(
        controller: _controller!,
      );
      await _kmoniObservationPointService?.init();
    } else {
      await _kmoniObservationPointService?.dispose();
      _kmoniObservationPointService = null;
    }
  }

  Future<void> startUpdateEew() async {
    if (_isEewInitialized || _controller == null) {
      return;
    }

    _isEewInitialized = true;
    // 初回EEW State更新
    await _onEewStateChanged(
      ref.read(eewAliveTelegramProvider) ?? [],
    );
  }

  // *********** Utilities ***********
  Future<void> updateImage({
    required String name,
    required Uint8List bytes,
  }) async =>
      _controller?.addImage(name, bytes);

  // ignore: use_setters_to_change_properties
  void registerMapController(MaplibreMapController controller) {
    // ignore: void_checks
    _controller = controller;
  }

  bool isMapControllerRegistered() => _controller != null;

  Future<void> moveCameraToDefaultPosition({
    double bottom = 0,
    double left = 0,
    double right = 0,
    double top = 0,
  }) async {
    if (_controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    await _controller!.moveCamera(
      CameraUpdate.newLatLngBounds(
        defaultBoundary,
        bottom: bottom,
        left: left,
        right: right,
        top: top,
      ),
    );
  }

  Future<void> animateCameraToDefaultPosition({
    double bottom = 50,
    Duration duration = const Duration(
      milliseconds: 250,
    ),
  }) async {
    final controller = _controller;
    if (controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        defaultBoundary,
        bottom: bottom,
      ),
      duration: duration,
    );
  }

  // *********** Map Boundary Utilities ***********
  Future<void> changeHomeBoundaryWithAnimation({
    required LatLngBounds bounds,
    double bottom = 50,
    double left = 20,
    double right = 20,
    double top = 20,
    Duration duration = const Duration(
      milliseconds: 250,
    ),

    /// 現在の表示領域を破棄し、強制的に新しい表示領域を適用するかどうか
    bool isForce = false,
  }) async {
    final controller = _controller;
    if (controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    // 現在のホームポジションから変更がない場合は何もしない
    if (!isForce && state.isHomePosition && state.homeBoundary == bounds) {
      return;
    }
    // 強制移動 もしくは ホームから移動していない場合(=isHomePosition == true)の場合は
    // アニメーションを実行する
    if (isForce || state.isHomePosition) {
      state = state.copyWith(
        homeBoundary: bounds,
      );
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          bottom: bottom,
          left: left,
          right: right,
          top: top,
        ),
        duration: duration,
      );
      state = state.copyWith(
        isHomePosition: true,
      );
    } else {
      state = state.copyWith(
        homeBoundary: bounds,
      );
    }
  }

  Future<void> animateToHomeBoundary({
    double bottom = 150,
    double left = 10,
    double right = 10,
    double top = 10,
    Duration duration = const Duration(
      milliseconds: 250,
    ),
  }) async {
    final controller = _controller;
    if (controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        state.homeBoundary,
        bottom: bottom,
        left: left,
        right: right,
        top: top,
      ),
      duration: duration,
    );
    state = state.copyWith(
      isHomePosition: true,
    );
  }

  Future<void> moveToHomeBoundary({
    double bottom = 100,
    double left = 10,
    double right = 10,
    double top = 10,
  }) async {
    final controller = _controller;
    if (controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    await controller.moveCamera(
      CameraUpdate.newLatLngBounds(
        state.homeBoundary,
        bottom: bottom,
        left: left,
        right: right,
        top: top,
      ),
    );
    state = state.copyWith(
      isHomePosition: true,
    );
  }
}

class _KmoniObservationPointService {
  _KmoniObservationPointService({required this.controller});

  final MaplibreMapController controller;

  Future<void> init() async {
    await dispose();
    await controller.addGeoJsonSource(
      layerId,
      {
        'type': 'FeatureCollection',
        'features': <void>[],
      },
    );
    await controller.addCircleLayer(
      layerId,
      layerId,
      CircleLayerProperties(
        circleRadius: [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          1,
          10,
          10,
        ],
        circleColor: [
          'get',
          'color',
        ],
        circleStrokeColor: Colors.grey.toHexStringRGB(),
        circleStrokeWidth: [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          0.2,
          10,
          1,
        ],
      ),
      sourceLayer: layerId,
      //      belowLayerId: BaseLayer.areaForecastLocalELine.name,
    );
  }

  Future<void> update(List<AnalyzedKmoniObservationPoint> points) =>
      controller.setGeoJsonSource(
        layerId,
        createGeoJson(points),
      );

  Future<void> dispose() async {
    await controller.removeLayer(layerId);
    await controller.removeSource(layerId);
  }

  static const String layerId = 'kmoni-circle';

  Map<String, dynamic> createGeoJson(
    List<AnalyzedKmoniObservationPoint> points,
  ) =>
      {
        'type': 'FeatureCollection',
        'features': points
            .where((e) => e.intensityValue != null)
            .map(
              (e) => {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [e.point.latLng.lon, e.point.latLng.lat],
                },
                'properties': {
                  'color': e.intensityValue != null
                      ? e.intensityColor?.toHexStringRGB()
                      : null,
                  'intensity': e.intensityValue,
                },
              },
            )
            .toList(),
      };
}

class _EewEstimatedIntensityService {
  _EewEstimatedIntensityService({required this.controller});

  final MaplibreMapController controller;
  Future<void> init(IntensityColorModel colorModel) async {
    await dispose();
    await [
      // 各予想震度ごとにFill Layerを追加
      for (final intensity in JmaForecastIntensity.values)
        controller.addLayer(
          'eqmonitor_map',
          getFillLayerId(intensity),
          FillLayerProperties(
            fillColor: colorModel
                .fromJmaForecastIntensity(intensity)
                .background
                .toHexStringRGB(),
          ),
          filter: [
            'in',
            ['get', 'code'],
            [
              'literal',
              <String>[],
            ]
          ],
          sourceLayer: 'areaForecastLocalE',
          belowLayerId: BaseLayer.areaForecastLocalELine.name,
        ),
    ].wait;
  }

  /// 予想震度を更新する
  /// [areas] は Map<予想震度, List<地域コード>>
  Future<void> update(Map<JmaForecastIntensity, List<String>> areas) => [
        // 各予想震度ごとにFill Layerを追加
        for (final intensity in JmaForecastIntensity.values)
          controller.setFilter(
            getFillLayerId(intensity),
            [
              'in',
              ['get', 'code'],
              [
                'literal',
                areas[intensity] ?? [],
              ]
            ],
          ),
      ].wait;

  Future<void> dispose() => [
        for (final intensity in JmaForecastIntensity.values)
          controller.removeLayer(getFillLayerId(intensity)),
      ].wait;

  Future<void> onIntensityColorModelChanged(IntensityColorModel model) =>
      dispose().then(
        (_) => init(model),
      );
  static Map<JmaForecastIntensity, List<String>> transform(
    List<EewRegion> regions,
  ) {
    // 同じ地域をまとめる
    final regionsGrouped = regions.groupListsBy(
      (e) => e.code,
    );
    // 予想震度が最も大きいものを取り出す
    final regionsIntensityMax = <String, ForecastMaxInt>{};
    for (final entry in regionsGrouped.entries) {
      final max = entry.value
          .map((e) => e.forecastMaxInt)
          .whereType<ForecastMaxInt>()
          .reduce(
            (value, element) => value.toDisplayMaxInt().maxInt >
                    element.toDisplayMaxInt().maxInt
                ? value
                : element,
          );
      regionsIntensityMax[entry.key] = max;
    }
    // Map<予想震度, List<地域コード>> に変換する
    final regionsIntensityGrouped = <JmaForecastIntensity, List<String>>{};
    for (final entry in regionsIntensityMax.entries) {
      final key = entry.value.toDisplayMaxInt().maxInt;
      if (!regionsIntensityGrouped.containsKey(key)) {
        regionsIntensityGrouped[key] = [];
      }
      regionsIntensityGrouped[key]!.add(entry.key);
    }
    return regionsIntensityGrouped;
  }

  static String getFillLayerId(JmaForecastIntensity intensity) {
    final base = intensity.type
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('不明', 'unknown');
    return '$_EewEstimatedIntensityService-fill-$base';
  }
}

class _EewHypocenterService {
  _EewHypocenterService({required this.controller});

  final MaplibreMapController controller;

  bool hasInitialized = false;

  Future<void> init({
    required Uint8List hypocenterIcon,
    required Uint8List hypocenterLowPreciseIcon,
  }) async {
    await (
      controller.addImage(
        hypocenterIconId,
        hypocenterIcon,
      ),
      controller.addImage(
        hypocenterLowPreciseIconId,
        hypocenterLowPreciseIcon,
      ),
    ).wait;
    await controller.removeSource(sourceLayerId);
    await controller.addGeoJsonSource(
      sourceLayerId,
      createGeoJson([]),
    );

    // adding Symbol Layers
    await (
      controller.addSymbolLayer(
        sourceLayerId,
        hypocenterIconId,
        SymbolLayerProperties(
          iconImage: hypocenterIconId,
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            2,
          ],
          iconOpacity: [
            'interpolate',
            ['linear'],
            ['zoom'],
            6,
            1.0,
            10,
            0.5,
          ],
          iconAllowOverlap: true,
        ),
        filter: [
          '==',
          ['get', 'isLowPrecise'],
          false,
        ],
        sourceLayer: sourceLayerId,
      ),
      controller.addSymbolLayer(
        sourceLayerId,
        hypocenterLowPreciseIconId,
        SymbolLayerProperties(
          iconImage: hypocenterLowPreciseIconId,
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            2,
          ],
          iconOpacity: [
            'interpolate',
            ['linear'],
            ['zoom'],
            6,
            1.0,
            10,
            0.5,
          ],
          iconAllowOverlap: true,
        ),
        // where isLowPrecise == true
        filter: [
          '==',
          ['get', 'isLowPrecise'],
          true,
        ],
        sourceLayer: sourceLayerId,
      ),
    ).wait;
    hasInitialized = true;
  }

  Future<void> update(List<TelegramVxse45Body> items) =>
      controller.setGeoJsonSource(
        sourceLayerId,
        createGeoJson(items),
      );

  double _lastOpacity = 0;

  Future<void> tick() async {
    if (!hasInitialized) {
      return;
    }
    final milliseconds = DateTime.now().millisecondsSinceEpoch;
    if (milliseconds % 1000 < 500) {
      if (_lastOpacity == 1.0) {
        return;
      }
      _lastOpacity = 1.0;
      await controller.setLayerProperties(
        hypocenterIconId,
        const SymbolLayerProperties(
          iconOpacity: 1.0,
        ),
      );
    } else {
      if (_lastOpacity == 0.5) {
        return;
      }
      _lastOpacity = 0.5;
      await controller.setLayerProperties(
        hypocenterIconId,
        const SymbolLayerProperties(
          iconOpacity: 0.5,
        ),
      );
    }
  }

  Future<void> dispose() async {
    await controller.removeLayer(sourceLayerId);
    await controller.removeSource(sourceLayerId);
    hasInitialized = false;
  }

  static Map<String, dynamic> createGeoJson(List<TelegramVxse45Body> items) =>
      <String, dynamic>{
        'type': 'FeatureCollection',
        'features': items
            .map(
              (e) => {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [
                    e.hypocenter!.coordinate!.lon,
                    e.hypocenter!.coordinate!.lat,
                  ],
                },
                'properties': _EewHypocenterProperties(
                  depth: e.depth ?? 0,
                  magnitude: e.magnitude ?? 0,
                  isLowPrecise: e.isPlum || e.isIpfOnePoint || e.isLevelEew,
                ).toJson(),
              },
            )
            .toList(),
      };

  static String get hypocenterIconId => 'hypocenter';
  static String get hypocenterLowPreciseIconId => 'hypocenter-low-precise';

  static String get sourceLayerId => 'hypocenter';
}

class _EewPsWaveService {
  _EewPsWaveService({
    required this.controller,
    required this.travelTimeMap,
  }) : _children = (
          _EewPWaveLineService(controller: controller),
          _EewSWaveLineService(controller: controller),
          //  _EewPWaveFillService(controller: controller),
          // _EewSWaveFillService(controller: controller),
        );

  final MaplibreMapController controller;
  final TravelTimeDepthMap travelTimeMap;

  late final (
    _EewPWaveLineService,
    _EewSWaveLineService,
    // _EewPWaveFillService,
    // _EewSWaveFillService
  ) _children;

  Future<void> init() async {
    // datasource
    await controller.removeSource(sourceId);
    await controller.addGeoJsonSource(
      sourceId,
      createGeoJson([]),
    );
    // line
    await (
      _children.$1.init(),
      _children.$2.init(),
    ).wait;
    // fill
    // await _children.$3.init();
    //_children.$4.init(),
  }

  List<(TelegramVxse45Body, bool isWarning)> _cachedEews = [];

  /// 表示するEEWが0件になってから GeoJSON Sourceを更新したかどうか
  bool didUpdatedSinceZero = false;

  Future<void> tick({
    required DateTime now,
  }) async {
    final results = <(TravelTimeResult, lat_lng.LatLng, bool isWarning)>[];
    // 表示EEWが1件以上だったら、didUpdatedSinceZeroをfalseにする
    if (_cachedEews.isNotEmpty) {
      didUpdatedSinceZero = false;
    }
    // 表示EEWが0件 かつ GeoJSON Sourceを更新したことがある場合は何もしない
    if (_cachedEews.isEmpty && didUpdatedSinceZero) {
      return;
    }
    for (final e in _cachedEews) {
      final eew = e.$1;
      final hypocenter = eew.hypocenter?.coordinate;
      final depth = eew.depth;
      final originTime = eew.originTime;
      if (hypocenter == null || depth == null || originTime == null) {
        continue;
      }
      final travel = travelTimeMap.getTravelTime(
        depth,
        //  as sec
        now
                .difference(
                  originTime,
                )
                .inMilliseconds /
            1000,
      );
      results.add(
        (travel, hypocenter, e.$2),
      );
    }
    // update GeoJSON
    final geoJson = createGeoJson(results);
    await controller.setGeoJsonSource(
      sourceId,
      geoJson,
    );
    if (results.isEmpty) {
      didUpdatedSinceZero = true;
    }
  }

  // ignore: use_setters_to_change_properties
  void update(List<(TelegramVxse45Body, bool isWarning)> items) =>
      _cachedEews = items;

  static Map<String, dynamic> createGeoJson(
    List<(TravelTimeResult, lat_lng.LatLng, bool isWarning)> results,
  ) =>
      {
        'type': 'FeatureCollection',
        'features': [
          // S-wave
          for (final type in _WaveType.values)
            for (final result in results)
              {
                'type': 'Feature',
                'geometry': {
                  'type': 'LineString',
                  'coordinates': [
                    // 0...360
                    for (final bearing
                        in List<int>.generate(361, (index) => index))
                      () {
                        final latLng = const latlong2.Distance().offset(
                          latlong2.LatLng(
                            result.$2.lat,
                            result.$2.lon,
                          ),
                          ((type == _WaveType.sWave
                                      ? result.$1.sDistance ?? 0
                                      : result.$1.pDistance ?? 0) *
                                  1000)
                              .toInt(),
                          bearing,
                        );
                        return [latLng.longitude, latLng.latitude];
                      }(),
                  ],
                },
                'properties': {
                  'distance': result.$1.sDistance,
                  'hypocenter': {
                    'type': 'Point',
                    'coordinates': [
                      result.$2.lon,
                      result.$2.lat,
                    ],
                    'isWarning': result.$3,
                  },
                  'type': type.name,
                },
              },
        ],
      };

  Future<void> dispose() => (
        controller.removeLayer(sourceId),
        _children.$1.dispose(),
        _children.$2.dispose(),
      ).wait.then(
            (_) => controller.removeSource(sourceId),
          );

  static String get sourceId => 'ps-wave';
}

enum _WaveType {
  pWave,
  sWave,
  ;
}

class _EewPWaveLineService {
  _EewPWaveLineService({
    required this.controller,
  });

  final MaplibreMapController controller;

  Future<void> init() async {
    await dispose();
    await controller.addLineLayer(
      _EewPsWaveService.sourceId,
      layerId,
      LineLayerProperties(
        lineColor: Colors.blueAccent.toHexStringRGB(),
        lineCap: 'round',
      ),
      filter: [
        '==',
        'type',
        _WaveType.pWave.name,
      ],
    );
  }

  Future<void> dispose() => controller.removeLayer(layerId);

  static String get layerId => 'p-wave-line';
}

class _EewSWaveLineService {
  _EewSWaveLineService({
    required this.controller,
  });

  final MaplibreMapController controller;

  Future<void> init() async {
    await dispose();
    await controller.addLineLayer(
      _EewPsWaveService.sourceId,
      layerId,
      LineLayerProperties(
        lineColor: Colors.redAccent.toHexStringRGB(),
        lineWidth: 2,
        lineCap: 'round',
      ),
      filter: [
        '==',
        'type',
        _WaveType.sWave.name,
      ],
    );
  }

  Future<void> dispose() => controller.removeLayer(layerId);

  static String get layerId => 's-wave-line';
}

/*
class _EewPWaveFillService {
  _EewPWaveFillService({
    required this.controller,
  });

  final MaplibreMapController controller;

  Future<void> init() async {
    await dispose();
    await controller.addFillLayer(
      _EewPsWaveService.sourceId,
      layerId,
      FillLayerProperties(
        fillColor: Colors.blue.toHexStringRGB(),
        fillOpacity: 0.2,
      ),
      filter: [
        '==',
        'type',
        _WaveType.pWave.name,
      ],
      belowLayerId: _EewPWaveLineService.layerId,
    );
  }

  Future<void> dispose() => controller.removeLayer(layerId);

  static String get layerId => 'p-wave-fill';
}

class _EewSWaveFillService {
  _EewSWaveFillService({
    required this.controller,
  });

  final MaplibreMapController controller;

  Future<void> init() async {
    await dispose();
    await controller.addFillLayer(
      _EewPsWaveService.sourceId,
      layerId,
      FillLayerProperties(
        fillColor: Colors.red.toHexStringRGB(),
        fillOpacity: 0.2,
      ),
      filter: [
        '==',
        'type',
        _WaveType.sWave.name,
      ],
      belowLayerId: BaseLayer.countriesFill.name,
    );
  }

  Future<void> dispose() => controller.removeLayer(layerId);

  static String get layerId => 's-wave-fill';
}
*/

@freezed
class _EewHypocenterProperties with _$EewHypocenterProperties {
  const factory _EewHypocenterProperties({
    required int depth,
    required double magnitude,
    required bool isLowPrecise,
  }) = __EewHypocenterProperties;

  // ignore: unused_element
  factory _EewHypocenterProperties.fromJson(Map<String, dynamic> json) =>
      _$$_EewHypocenterPropertiesImplFromJson(json);
}

extension ListLatLngEx on List<lat_lng.LatLng> {
  LatLngBounds get toBounds {
    final latLngs = this;
    final latLngsSorted = latLngs.sorted(
      (a, b) => a.lat.compareTo(b.lat),
    );
    final latMin = latLngsSorted.first.lat;
    final latMax = latLngsSorted.last.lat;
    final lngs = latLngsSorted.where(
      (e) => e.lat == latMin || e.lat == latMax,
    );
    final lngsSorted = lngs.sorted(
      (a, b) => a.lon.compareTo(b.lon),
    );
    final lngMin = lngsSorted.first.lon;
    final lngMax = lngsSorted.last.lon;
    return LatLngBounds(
      southwest: LatLng(
        latMin,
        lngMin,
      ),
      northeast: LatLng(
        latMax,
        lngMax,
      ),
    );
  }
}
