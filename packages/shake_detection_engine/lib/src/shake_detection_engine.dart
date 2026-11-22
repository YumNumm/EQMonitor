import 'dart:math' as math;

import 'package:shake_detection_engine/src/shake_baseline.dart';
import 'package:shake_detection_engine/src/shake_detection_parameters.dart';
import 'package:shake_detection_engine/src/shake_event_level.dart';
import 'package:shake_detection_engine/src/shake_event_snapshot.dart';
import 'package:shake_detection_engine/src/shake_event_state.dart';
import 'package:shake_detection_engine/src/shake_station.dart';
import 'package:shake_detection_engine/src/shake_station_status.dart';

final class ShakeDetectionEngine({
  required List<ShakeStationLocation> stations,
  final ShakeDetectionParameters parameters = const ShakeDetectionParameters(),
  String Function()? createEventId,
}) {
  this {
    for (final station in _stations) {
      final near = <NearStation>[];
      for (final other in _stations) {
        if (identical(station, other)) {
          continue;
        }
        final distance = station.distanceTo(other);
        if (distance < parameters.maxSearchDistance) {
          near.add(
            NearStation(
              station: other,
              distance: distance,
              weight: parameters.distanceWeight(distance),
            ),
          );
        }
      }
      near.sort((a, b) => a.distance.compareTo(b.distance));
      station.nearStations = near.length > parameters.maxNearPoints
          ? near.sublist(0, parameters.maxNearPoints)
          : near;
    }
  }

  /// これ以上の時刻の飛びがあった場合は履歴が連続しないため、
  /// [reset] と [seedBaseline] をやり直す。
  static const discontinuityThreshold = Duration(seconds: 5);

  final String Function() _createEventId =
      createEventId ?? ShakeEventIdGenerator().next;
  final List<ShakeStationState> _stations = [
    for (final (index, location) in stations.indexed)
      ShakeStationState(index: index, location: location),
  ];
  final List<ShakeEventState> _events = [];

  DateTime? _lastProcessedAt;
  var _bootstrapFramesRemaining = 0;
  var _isBaselineReliable = true;

  int get stationCount => _stations.length;

  List<ShakeEventSnapshot> get events => [
    for (final event in _events) event.toSnapshot(),
  ];

  List<ShakeStationStatus> get stationStatuses => [
    for (final station in _stations)
      if (station.isTmpDisabled)
        .outlier
      else if (station.latestIntensity != null)
        .observed
      else if (station.hasRecentObservation)
        .lost
      else
        .absent,
  ];

  bool requiresColdStart(DateTime time) {
    final last = _lastProcessedAt;
    return last == null ||
        time.difference(last).abs() >= discontinuityThreshold;
  }

  void reset() {
    for (final station in _stations) {
      station
        ..resetHistory()
        ..event = null
        ..peakIntensity = null
        ..eventedAt = null
        ..eventedExpireAt = null
        ..initialEventedAt = null
        ..isTmpDisabled = false
        ..hasValidHistory = false;
    }
    _events.clear();
    _lastProcessedAt = null;
    _bootstrapFramesRemaining = 0;
    _isBaselineReliable = true;
  }

  /// 履歴が空の状態で平常値を最古の標本として投入する。
  ///
  /// 上昇量は窓内の最新値と最古の有効値の差になるため、次の [process] から
  /// 平常値との差で検知できる。
  void seedBaseline(ShakeBaseline baseline) {
    if (baseline.values.length != _stations.length) {
      throw ArgumentError.value(
        baseline.values.length,
        'baseline.values.length',
        'must be equal to stationCount ($stationCount)',
      );
    }
    for (final (index, value) in baseline.values.indexed) {
      if (value != null) {
        _stations[index].update(value, isObservation: baseline.isReliable);
      }
    }
    _bootstrapFramesRemaining = ShakeStationState.historyCount - 1;
    _isBaselineReliable = baseline.isReliable;
  }

  List<ShakeEventSnapshot> process({
    required DateTime time,
    required List<double?> intensities,
  }) {
    if (intensities.length != _stations.length) {
      throw ArgumentError.value(
        intensities.length,
        'intensities.length',
        'must be equal to stationCount ($stationCount)',
      );
    }
    for (final (index, intensity) in intensities.indexed) {
      _stations[index].update(intensity);
    }

    final isBootstrap = _bootstrapFramesRemaining > 0;
    for (final station in _stations) {
      _evaluate(station, time, isBootstrap: isBootstrap);
    }
    _endExpiredEvents(time);
    _mergeNearbyEvents(time);

    if (isBootstrap) {
      _bootstrapFramesRemaining -= 1;
    }
    _lastProcessedAt = time;
    return events;
  }

  /// 履歴を作り直した後のイベントに、作り直す前のイベントの ID を引き継ぐ。
  ///
  /// 観測点が最も多く重なるイベント同士を同一とみなす。表示側が同じ揺れを
  /// 新しいイベントとして扱わないようにするためのもの。
  void adoptEventIds(List<ShakeEventSnapshot> previous) {
    final remaining = [..._events];
    final ordered = [...previous]
      ..sort((a, b) => b.points.length.compareTo(a.points.length));
    for (final snapshot in ordered) {
      final stationIndexes = {
        for (final point in snapshot.points) point.stationIndex,
      };
      ShakeEventState? best;
      var bestShared = 0;
      for (final event in remaining) {
        final shared = event.countSharedStations(stationIndexes);
        if (shared > bestShared) {
          best = event;
          bestShared = shared;
        }
      }
      if (best != null) {
        best.id = snapshot.id;
        remaining.remove(best);
      }
    }
  }

  void _evaluate(
    ShakeStationState station,
    DateTime time, {
    required bool isBootstrap,
  }) {
    final latest = station.latestIntensity;
    if (latest != null) {
      final isOutlier =
          station.intensityDiff < 1 &&
          station.event == null &&
          latest >= (station.nearStations.isNotEmpty ? 3 : 5) &&
          (station.intensityAverage - latest).abs() <= 1 &&
          (station.isTmpDisabled ||
              station.nearStations.every(
                (near) => latest - (near.station.latestIntensity ?? -3) >= 3,
              ));
      station.isTmpDisabled = isOutlier;
    }

    station.event?.touch(station, time);

    if (station.isTmpDisabled) {
      return;
    }

    // 上昇が止まった観測点もイベントの終了までは外さない。
    if (station.intensityDiff < parameters.minDetectionDiff) {
      return;
    }
    if (latest == null) {
      return;
    }

    var availableTotalWeight = 0.0;
    for (final near in station.nearStations) {
      if (near.station.hasValidHistory) {
        availableTotalWeight += near.weight;
      }
    }

    // 有効な近傍がほぼ無い観測点（離島）は単独の上昇量で検知する。
    if (availableTotalWeight < parameters.isolatedThreshold) {
      // 信頼できない平常値では故障観測点を区別できないため、単独検知は行わない。
      final canDetect = !isBootstrap || _isBaselineReliable;
      if (canDetect &&
          station.intensityDiff >= parameters.isolatedDetectionDiff &&
          station.event == null) {
        final level = ShakeEventLevel.fromIntensity(latest);
        _events.add(
          ShakeEventState(
            id: _createEventId(),
            createdAt: time,
            firstStation: station,
            lifetime: parameters.lifetime(level),
            isBootstrap: isBootstrap,
          )..isConfirmed = level.index > ShakeEventLevel.weak.index,
        );
      }
      return;
    }

    final candidates = <ShakeEventState>[];
    final ownEvent = station.event;
    if (ownEvent != null) {
      candidates.add(ownEvent);
    }

    var score = 0.0;
    var penalty = 0.0;
    var contributingCount = 0;
    for (final near in station.nearStations) {
      final other = near.station;
      if (other.isTmpDisabled || !other.hasValidHistory) {
        continue;
      }
      if (other.intensityDiff >= parameters.minDetectionDiff) {
        score +=
            near.weight *
            (other.intensityDiff - parameters.scoreIntensityOffset);
        contributingCount += 1;
        final otherEvent = other.event;
        if (otherEvent != null && !candidates.contains(otherEvent)) {
          candidates.add(otherEvent);
        }
      } else {
        penalty += near.weight * parameters.noChangePenaltyFactor;
      }
    }

    // 寄与が1点のみの場合は単独ノイズの可能性がある。
    if (contributingCount <= 1) {
      return;
    }
    if (score - penalty <
        availableTotalWeight * parameters.scoreThresholdRatio) {
      return;
    }

    station.eventedAt = time;
    final lifetime = parameters.lifetime(ShakeEventLevel.fromIntensity(latest));

    if (candidates.length > 1) {
      var oldest = candidates.first;
      for (final candidate in candidates.skip(1)) {
        if (candidate.createdAt.isBefore(oldest.createdAt)) {
          oldest = candidate;
        }
      }
      for (final candidate in candidates) {
        if (identical(candidate, oldest)) {
          continue;
        }
        oldest.merge(candidate, time);
        _events.remove(candidate);
      }
      if (identical(station.event, oldest)) {
        return;
      }
      oldest.addStation(station, time, lifetime);
      _updateConfirmation(oldest, isBootstrap: isBootstrap);
      return;
    }

    if (candidates.isNotEmpty) {
      final event = candidates.first..addStation(station, time, lifetime);
      _updateConfirmation(event, isBootstrap: isBootstrap);
      return;
    }

    final event = ShakeEventState(
      id: _createEventId(),
      createdAt: time,
      firstStation: station,
      lifetime: lifetime,
      isBootstrap: isBootstrap,
    );
    _events.add(event);
    _updateConfirmation(event, isBootstrap: isBootstrap);
  }

  /// すべての観測点の検知期限が過ぎたイベントを終了する。
  void _endExpiredEvents(DateTime time) {
    _events.removeWhere((event) {
      if (!event.expiresAt.isBefore(time)) {
        return false;
      }
      event.releaseStations();
      return true;
    });
  }

  void _mergeNearbyEvents(DateTime time) {
    final ordered = [..._events]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    for (final event in ordered) {
      if (!_events.contains(event)) {
        continue;
      }
      final others = _events
          .where(
            (e) =>
                !identical(e, event) && !event.createdAt.isAfter(e.createdAt),
          )
          .toList(growable: false);
      for (final other in others) {
        final level = event.level.index > other.level.index
            ? event.level
            : other.level;
        if (!event.isNearby(other, parameters.mergeDistance(level))) {
          continue;
        }
        event.merge(other, time);
        _events.remove(other);
      }
    }
  }

  void _updateConfirmation(ShakeEventState event, {required bool isBootstrap}) {
    if (event.isConfirmed) {
      return;
    }
    // 平常値との差は数十秒から数分の緩やかな雑音の変動も拾うため、
    // 平常値が窓に残る間は弱い揺れを観測点数だけでは確定しない。
    event.isConfirmed = switch (event.level) {
      .weaker =>
        !isBootstrap && event.stationCount > parameters.weakerConfirmPointCount,
      .weak =>
        !isBootstrap && event.stationCount > parameters.weakConfirmPointCount,
      .medium || .strong || .stronger => true,
    };
  }
}

final class ShakeEventIdGenerator({math.Random? random}) {
  final math.Random _random = random ?? math.Random();

  String next() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = [
      for (final byte in bytes) byte.toRadixString(16).padLeft(2, '0'),
    ].join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }
}
