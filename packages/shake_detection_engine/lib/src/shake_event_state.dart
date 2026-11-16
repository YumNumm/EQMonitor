import 'package:shake_detection_engine/src/shake_event_level.dart';
import 'package:shake_detection_engine/src/shake_event_snapshot.dart';
import 'package:shake_detection_engine/src/shake_station.dart';

final class ShakeEventState {
  new({
    required this.id,
    required this.createdAt,
    required ShakeStationState firstStation,
    required Duration lifetime,
    required this.isBootstrap,
  }) : updatedAt = createdAt,
       level = ShakeEventLevel.fromIntensity(firstStation.latestIntensity),
       minLatitude = firstStation.location.latitude,
       maxLatitude = firstStation.location.latitude,
       minLongitude = firstStation.location.longitude,
       maxLongitude = firstStation.location.longitude {
    firstStation
      ..event = this
      ..eventedAt = createdAt
      ..initialEventedAt = createdAt
      ..extendExpiry(createdAt.add(lifetime));
    _stations.add(firstStation);
  }

  String id;
  final DateTime createdAt;
  final bool isBootstrap;
  DateTime updatedAt;
  ShakeEventLevel level;
  var isConfirmed = false;
  double minLatitude;
  double maxLatitude;
  double minLongitude;
  double maxLongitude;

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

  void removeStation(ShakeStationState station, DateTime time) {
    if (!_stations.remove(station)) {
      return;
    }
    updatedAt = time;
    station
      ..event = null
      ..eventedExpireAt = null
      ..initialEventedAt = null;
  }

  bool isNearby(ShakeEventState other, double distance) => _stations.any(
    (a) => other._stations.any((b) => a.distanceTo(b) <= distance),
  );

  ShakeEventSnapshot toSnapshot() {
    var expiresAt = createdAt;
    for (final station in _stations) {
      final expireAt = station.eventedExpireAt;
      if (expireAt != null && expireAt.isAfter(expiresAt)) {
        expiresAt = expireAt;
      }
    }
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
            intensity: station.latestIntensity,
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
