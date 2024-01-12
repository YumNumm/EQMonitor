import 'dart:typed_data';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_map_viewmodel.g.dart';

@Riverpod(dependencies: [EewAliveTelegram])
class MainMapViewModel extends _$MainMapViewModel {
  @override
  void build() {
    ref
      ..listen(
        kmoniViewModelProvider,
        (_, value) {
          final analyzedPoints = value.analyzedPoints;
          if (analyzedPoints == null) {
            return;
          }
          _controller?.setGeoJsonSource(
            'kmoni',
            _createKmoniGeoJson(analyzedPoints),
          );
        },
      )
      ..listen(
        eewAliveTelegramProvider,
        (_, value) => _onEewStateChanged(value ?? []),
      );
  }

  MaplibreMapController? _controller;

  bool _isEewInitialized = false;

  Future<void> _onEewStateChanged(List<EarthquakeHistoryItem> values) async {
    // 初期化が終わっていない場合は何もしない
    if (!_isEewInitialized) {
      return;
    }
    await _updateHypocenter(
      values
          .map((e) {
            final eew = e.latestEew;
            if (eew == null) {
              return null;
            }
            if (eew is TelegramVxse45Body &&
                eew.hypocenter != null &&
                eew.hypocenter!.coordinate != null) {
              return eew;
            }
            return null;
          })
          .whereType<TelegramVxse45Body>()
          .toList(),
    );
  }

  Future<void> startUpdateKmoni() async {
    if (_controller == null) {
      throw Exception('MaplibreMapController is null');
    }

    await _controller!.removeSource('kmoni');

    await _controller!.addGeoJsonSource(
      'kmoni',
      _createKmoniGeoJson([]),
    );
    await _controller!.removeLayer('kmoni');
    await _controller!.addLayer(
      'kmoni',
      'kmoni-circle',
      const CircleLayerProperties(
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
      ),
      sourceLayer: 'kmoni',
    );
  }

  Future<void> startUpdateEew() async {
    if (_isEewInitialized || _controller == null) {
      return;
    }

    await _controller!.removeSource('hypocenter');
    await _controller!.addGeoJsonSource(
      'hypocenter',
      {
        'type': 'FeatureCollection',
        'features': <void>[],
      },
    );

    await _controller!.addSymbolLayer(
      'hypocenter',
      'hypocenter-normal',
      const SymbolLayerProperties(
        iconImage: 'hypocenter',
        iconSize: [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          0.3,
          20,
          5,
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
      sourceLayer: 'hypocenter',
    );

    _isEewInitialized = true;
    // 初回EEW State更新
    await _onEewStateChanged(
      ref.read(eewAliveTelegramProvider) ?? [],
    );
  }

  Future<void> updateImage({
    required String name,
    required Uint8List bytes,
  }) async =>
      _controller?.addImage(name, bytes);

  Map<String, dynamic> _createKmoniGeoJson(
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

  // ignore: use_setters_to_change_properties
  void registerMapController(MaplibreMapController controller) =>
      // ignore: void_checks
      _controller = controller;

  void moveCameraToDefaultPosition({
    double bottom = 0,
  }) {
    if (_controller == null) {
      throw Exception('MaplibreMapController is null');
    }
    _controller!.moveCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: const LatLng(30, 128.8),
          northeast: const LatLng(45.8, 145.1),
        ),
        bottom: bottom,
      ),
    );
  }

  Future<void> _updateHypocenter(
    List<TelegramVxse45Body> items,
  ) async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    if (!_isEewInitialized) {
      return;
    }
    await controller.setGeoJsonSource(
      'hypocenter',
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
                'properties': {
                  'depth': e.depth,
                  'magnitude': e.magnitude,
                  'isPlum': e.isPlum,
                  'isIpfOnePoint': e.isIpfOnePoint,
                  'isLevel': e.isLevelEew,
                },
              },
            )
            .toList(),
      },
    );
  }
}
