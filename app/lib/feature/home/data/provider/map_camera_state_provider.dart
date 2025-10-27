import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  MapController? _controller;

  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (previous, next) {
      final eews = next ?? [];
      if (eews.isNotEmpty) {
        _fitToEews(eews);
      } else if (previous != null && previous.isNotEmpty) {
        _returnToHome();
      }
    });

    return MapCameraState.home();
  }

  void setController(MapController controller) {
    _controller = controller;
  }

  Future<void> _fitToEews(List<EewV1> eews) async {
    if (_controller == null) {
      return;
    }

    final bounds = _calculateBounds(eews);
    await _controller?.fitBounds(bounds: bounds);
    state = state.copyWith(isAtHome: false);
  }

  Future<void> _returnToHome() async {
    if (_controller == null) {
      return;
    }

    await _controller?.fitBounds(
      bounds: const LngLatBounds(
        longitudeWest: 128.8,
        longitudeEast: 145.1,
        latitudeSouth: 30,
        latitudeNorth: 45.8,
      ),
    );
    state = state.copyWith(isAtHome: true);
  }

  LngLatBounds _calculateBounds(List<EewV1> eews) {
    final validEews = eews
        .where((e) => e.latitude != null && e.longitude != null)
        .toList();

    if (validEews.isEmpty) {
      return const LngLatBounds(
        longitudeWest: 128.8,
        longitudeEast: 145.1,
        latitudeSouth: 30,
        latitudeNorth: 45.8,
      );
    }

    var minLat = validEews.first.latitude!;
    var maxLat = validEews.first.latitude!;
    var minLng = validEews.first.longitude!;
    var maxLng = validEews.first.longitude!;

    for (final eew in validEews) {
      final lat = eew.latitude!;
      final lng = eew.longitude!;

      if (lat < minLat) {
        minLat = lat;
      }
      if (lat > maxLat) {
        maxLat = lat;
      }
      if (lng < minLng) {
        minLng = lng;
      }
      if (lng > maxLng) {
        maxLng = lng;
      }
    }

    const padding = 3.0;
    return LngLatBounds(
      longitudeWest: minLng - padding,
      longitudeEast: maxLng + padding,
      latitudeSouth: minLat - padding,
      latitudeNorth: maxLat + padding,
    );
  }

  Future<void> returnToHome() async {
    await _returnToHome();
  }
}

