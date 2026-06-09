import 'dart:async';

import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

enum HomeMapCameraUpdateAction {
  fitToEews,
  returnToHome,
  none,
}

HomeMapCameraUpdateAction resolveHomeMapCameraUpdateAction({
  required List<EewTelegramItem>? previous,
  required List<EewTelegramItem> next,
}) {
  if (next.isNotEmpty) {
    return HomeMapCameraUpdateAction.fitToEews;
  }
  if (previous != null && previous.isNotEmpty) {
    return HomeMapCameraUpdateAction.returnToHome;
  }
  return HomeMapCameraUpdateAction.none;
}

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  MapController? _controller;

  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (previous, next) async {
      await _handleEewTransition(previous: previous, next: next ?? []);
    });

    return MapCameraState.home();
  }

  void setController(MapController controller) {
    _controller = controller;
    unawaited(
      _handleEewTransition(
        previous: null,
        next: ref.read(eewAliveTelegramProvider) ?? [],
      ),
    );
  }

  Future<void> _handleEewTransition({
    required List<EewTelegramItem>? previous,
    required List<EewTelegramItem> next,
  }) async {
    switch (resolveHomeMapCameraUpdateAction(previous: previous, next: next)) {
      case HomeMapCameraUpdateAction.fitToEews:
        await _fitToEews(next);
        return;
      case HomeMapCameraUpdateAction.returnToHome:
        await _returnToHome();
        return;
      case HomeMapCameraUpdateAction.none:
        return;
    }
  }

  Future<void> _fitToEews(List<EewTelegramItem> eews) async {
    if (_controller == null) {
      return;
    }

    final home = await ref.read(homeConfigurationProvider.future);
    if (!home.eew.autoZoom) {
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

    final home = await ref.read(homeConfigurationProvider.future);
    final bounds = lngLatBoundsForHomeMapSettings(home.map);

    await _controller?.fitBounds(
      bounds: bounds,
      nativeDuration: const Duration(
        milliseconds: 200,
      ),
      bearing: 0,
      pitch: 0,
      padding: const EdgeInsets.all(4),
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
