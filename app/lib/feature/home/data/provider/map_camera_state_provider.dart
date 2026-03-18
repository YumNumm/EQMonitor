import 'dart:async';

import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
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

  Future<void> _fitToEews(List<EewTelegramItem> eews) async {
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
        longitudeWest: JapanBounds.minLng,
        longitudeEast: JapanBounds.maxLng,
        latitudeSouth: JapanBounds.minLat,
        latitudeNorth: JapanBounds.maxLat,
      ),
    );
    state = state.copyWith(isAtHome: true);
  }

  LngLatBounds _calculateBounds(List<EewTelegramItem> eews) {
    final validEews = eews.where((e) {
      return e.hypocenter?.hasLatLng ?? false;
    }).toList();

    if (validEews.isEmpty) {
      return const LngLatBounds(
        longitudeWest: JapanBounds.minLng,
        longitudeEast: JapanBounds.maxLng,
        latitudeSouth: JapanBounds.minLat,
        latitudeNorth: JapanBounds.maxLat,
      );
    }

    final firstHypo = validEews.first.hypocenter!;
    var minLat = firstHypo.latitude!;
    var maxLat = firstHypo.latitude!;
    var minLng = firstHypo.longitude!;
    var maxLng = firstHypo.longitude!;

    for (final eew in validEews) {
      final hypo = eew.hypocenter!;
      final lat = hypo.latitude!;
      final lng = hypo.longitude!;

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
