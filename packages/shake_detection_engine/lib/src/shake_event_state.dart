import 'package:shake_detection_engine/src/shake_event_level.dart';
import 'package:shake_detection_engine/src/shake_event_snapshot.dart';
import 'package:shake_detection_engine/src/shake_station.dart';

final class ShakeEventState({
  required var String id,
  required final DateTime createdAt,
  required ShakeStationState firstStation,
  required Duration lifetime,
  required final bool isBootstrap,
}) {
  this {
    firstStation
      ..event = this
      ..peakIntensity = firstStation.latestIntensity
      ..eventedAt = createdAt
      ..initialEventedAt = createdAt
      ..extendExpiry(createdAt.add(lifetime));
    _stations.add(firstStation);
  }

  DateTime updatedAt = createdAt;
  ShakeEventLevel level = ShakeEventLevel.fromIntensity(
    firstStation.latestIntensity,
  );
  var isConfirmed = false;
  double minLatitude = firstStation.location.latitude;
  double maxLatitude = firstStation.location.latitude;
  double minLongitude = firstStation.location.longitude;
  double maxLongitude = firstStation.location.longitude;

  final List<ShakeStationState> _stations = [];
  final List<ShakeMergedEvent> _mergedEvents = [];

  int get stationCount => _stations.length;

  int countSharedStations(Set<int> stationIndexes) =>
      _stations.where((e) => stationIndexes.contains(e.index)).length;

  void addStation(
    ShakeStationState station,
    DateTime time,
    Duration lifetime,
  ) {
    updatedAt = time;
    final stationLevel = ShakeEventLevel.fromIntensity(station.latestIntensity);
    // 1点のみの超過はノイズの可能性があるため、同じレベル以上の観測点が
    // 既にある場合だけレベルを上げる。
    if (level.index < stationLevel.index &&
        _stations.any(
          (e) =>
              ShakeEventLevel.fromIntensity(e.latestIntensity).index >=
              stationLevel.index,
        )) {
      level = stationLevel;
    }

    station
      ..eventedAt = time
      ..extendExpiry(time.add(lifetime));

    if (_stations.contains(station)) {
      return;
    }

    station
      ..initialEventedAt = time
      ..peakIntensity = station.latestIntensity
      ..event = this;
    _expandBounds(
      minLatitude: station.location.latitude,
      maxLatitude: station.location.latitude,
      minLongitude: station.location.longitude,
      maxLongitude: station.location.longitude,
    );
    _stations.add(station);
  }

  void touch(ShakeStationState station, DateTime time) {
    if (_stations.contains(station)) {
      updatedAt = time;
    }
  }

  void merge(ShakeEventState other, DateTime mergedAt) {
    updatedAt = mergedAt;
    _addMergedEvent(other.id, mergedAt);
    for (final merged in other._mergedEvents) {
      _addMergedEvent(merged.id, merged.mergedAt);
    }
    if (level.index < other.level.index) {
      level = other.level;
    }
    _expandBounds(
      minLatitude: other.minLatitude,
      maxLatitude: other.maxLatitude,
      minLongitude: other.minLongitude,
      maxLongitude: other.maxLongitude,
    );
    for (final station in other._stations) {
      station.event = this;
      if (!_stations.contains(station)) {
        _stations.add(station);
      }
    }
  }

  /// すべての観測点の検知期限。これを過ぎるとイベントは終了する。
  DateTime get expiresAt {
    var expiresAt = createdAt;
    for (final station in _stations) {
      final expireAt = station.eventedExpireAt;
      if (expireAt != null && expireAt.isAfter(expiresAt)) {
        expiresAt = expireAt;
      }
    }
    return expiresAt;
  }

  /// イベントの終了時に、属していた観測点をすべて解放する。
  void releaseStations() {
    for (final station in _stations) {
      station
        ..event = null
        ..peakIntensity = null
        ..eventedExpireAt = null
        ..initialEventedAt = null;
    }
    _stations.clear();
  }

  bool isNearby(ShakeEventState other, double distance) => _stations.any(
    (a) => other._stations.any((b) => a.distanceTo(b) <= distance),
  );

  ShakeEventSnapshot toSnapshot() {
    return ShakeEventSnapshot(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      expiresAt: expiresAt,
      level: level,
      isConfirmed: isConfirmed,
      isBootstrap: isBootstrap,
      minLatitude: minLatitude,
      maxLatitude: maxLatitude,
      minLongitude: minLongitude,
      maxLongitude: maxLongitude,
      points: [
        for (final station in _stations)
          ShakeEventPointSnapshot(
            stationIndex: station.index,
            detectedAt: station.initialEventedAt ?? createdAt,
            intensity: station.latestIntensity,
            peakIntensity: station.peakIntensity,
            intensityDiff: station.intensityDiff,
          ),
      ],
      mergedEvents: List.unmodifiable(_mergedEvents),
    );
  }

  void _addMergedEvent(String eventId, DateTime mergedAt) {
    if (eventId == id || _mergedEvents.any((e) => e.id == eventId)) {
      return;
    }
    _mergedEvents.add(ShakeMergedEvent(id: eventId, mergedAt: mergedAt));
  }

  void _expandBounds({
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
  }) {
    if (this.minLatitude > minLatitude) {
      this.minLatitude = minLatitude;
    }
    if (this.maxLatitude < maxLatitude) {
      this.maxLatitude = maxLatitude;
    }
    if (this.minLongitude > minLongitude) {
      this.minLongitude = minLongitude;
    }
    if (this.maxLongitude < maxLongitude) {
      this.maxLongitude = maxLongitude;
    }
  }
}
