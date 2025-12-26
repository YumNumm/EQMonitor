import 'dart:async';

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
        unawaited(_fitToEews(eews));
      } else if (previous != null && previous.isNotEmpty) {
        unawaited(_returnToHome());
      }
    });

    return MapCameraState.home();
  }

  void setController(MapController controller) {
    _controller = controller;
  }

  Future<void> _fitToEews(List<EewItemWithRelations> eews) async {
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

  LngLatBounds _calculateBounds(List<EewItemWithRelations> eews) {
    final validEews = eews.where((e) {
      final coords = e.hypocenter?.coordinates;
      return coords is CoordinateLatLng;
    }).toList();

    if (validEews.isEmpty) {
      return const LngLatBounds(
        longitudeWest: 128.8,
        longitudeEast: 145.1,
        latitudeSouth: 30,
        latitudeNorth: 45.8,
      );
    }

    final firstCoords =
        validEews.first.hypocenter!.coordinates as CoordinateLatLng;
    var minLat = firstCoords.latitude;
    var maxLat = firstCoords.latitude;
    var minLng = firstCoords.longitude;
    var maxLng = firstCoords.longitude;

    for (final eew in validEews) {
      final coords = eew.hypocenter!.coordinates as CoordinateLatLng;
      final lat = coords.latitude;
      final lng = coords.longitude;

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
