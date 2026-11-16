import 'dart:math' as math;
import 'dart:typed_data';

import 'package:shake_detection_engine/src/shake_event_state.dart';

final class const ShakeStationLocation({
  required final double latitude,
  required final double longitude,
});

final class const NearStation({
  required final ShakeStationState station,
  required final double distance,
  required final double weight,
});

final class ShakeStationState({
  required final int index,
  required final ShakeStationLocation location,
}) {
  static const historyCount = 10;
  static const _earthRadiusKm = 6371.0;

  final Float64List _history = Float64List(historyCount)
    ..fillRange(0, historyCount, double.nan);
  var _position = 0;

  var intensityDiff = 0.0;
  var intensityAverage = 0.0;
  var isTmpDisabled = false;
  var hasValidHistory = false;
  var nearStations = const <NearStation>[];

  ShakeEventState? event;
  DateTime? eventedAt;
  DateTime? eventedExpireAt;
  DateTime? initialEventedAt;

  double? get latestIntensity {
    final value = _history[_position];
    return value.isNaN ? null : value;
  }

  void update(double? intensity) {
    _position = _position + 1 >= historyCount ? 0 : _position + 1;
    _history[_position] = intensity ?? double.nan;

    // 新しい順にたどった隣接差の和で、窓内の最新値と最古の有効値の差になる。
    double? newer;
    var diff = 0.0;
    var total = 0.0;
    for (var offset = 0; offset < historyCount; offset++) {
      final value = _history[(_position - offset) % historyCount];
      if (value.isNaN) {
        continue;
      }
      if (newer != null) {
        diff += newer - value;
      }
      newer = value;
      total += value;
    }
    intensityDiff = diff;
    intensityAverage = total / historyCount;
    if (intensity != null) {
      hasValidHistory = true;
    }
  }

  void resetHistory() {
    _history.fillRange(0, historyCount, double.nan);
    _position = 0;
    intensityDiff = 0;
    intensityAverage = 0;
  }

  bool isExpiredAt(DateTime time) {
    final expireAt = eventedExpireAt;
    return expireAt == null || expireAt.isBefore(time);
  }

  void extendExpiry(DateTime expireAt) {
    final current = eventedExpireAt;
    if (current == null || current.isBefore(expireAt)) {
      eventedExpireAt = expireAt;
    }
  }

  double distanceTo(ShakeStationState other) {
    const toRadians = math.pi / 180;
    final latitude1 = location.latitude * toRadians;
    final latitude2 = other.location.latitude * toRadians;
    final longitudeDelta =
        (other.location.longitude - location.longitude) * toRadians;
    final cosine =
        math.cos(latitude1) * math.cos(latitude2) * math.cos(longitudeDelta) +
        math.sin(latitude1) * math.sin(latitude2);
    return _earthRadiusKm * math.acos(cosine.clamp(-1.0, 1.0));
  }
}
