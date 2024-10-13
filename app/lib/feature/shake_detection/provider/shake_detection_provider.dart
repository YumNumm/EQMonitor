import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/feature/shake_detection/model/shake_detection_kmoni_merged_event.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  @override
  Future<List<ShakeDetectionEvent>> build() async {
    final apiResult =
        await ref.watch(_fetchShakeDetectionEventsProvider.future);
    ref
      ..listen(
        websocketTableMessagesProvider<ShakeDetectionWebSocketTelegram>(),
        (_, next) {
          if (next case AsyncData(value: final value)) {
            if (value
                case RealtimePostgresInsertPayload<
                    ShakeDetectionWebSocketTelegram>()) {
              for (final event in value.newData.events) {
                _upsertShakeDetectionEvents([event]);
              }
            } else if (value
                case RealtimePostgresDeletePayload<
                    ShakeDetectionWebSocketTelegram>()) {
              state = const AsyncData([]);
            } else {
              log('unknown value: $value');
            }
          }
        },
      )
      ..listen(
        timeTickerProvider,
        (_, __) {
          if (state case AsyncData(:final value)) {
            state = AsyncData(_pruneOldEvents(value));
          }
        },
      );
    return _pruneOldEvents([
      ...apiResult,
    ]);
  }

  /// 古くなったイベントを破棄
  List<ShakeDetectionEvent> _pruneOldEvents(List<ShakeDetectionEvent> events) {
    const duration = Duration(seconds: 30);
    return events
        .where(
          (event) => event.insertedAt.isAfter(
            DateTime.now().subtract(duration),
          ),
        )
        .toList();
  }

  void _upsertShakeDetectionEvents(
    List<ShakeDetectionEvent> events,
  ) {
    final currentEvents = state.valueOrNull ?? [];
    final data = [...currentEvents];
    for (final event in events) {
      final index = data.indexWhereOrNull((e) => e.eventId == event.eventId);
      if (index == null) {
        data.add(event);
      } else {
        data[index] = event;
      }
    }
    state = AsyncData(data);
  }

  @override
  bool updateShouldNotify(
    AsyncValue<List<ShakeDetectionEvent>> previous,
    AsyncValue<List<ShakeDetectionEvent>> next,
  ) {
    if (previous case AsyncData(value: final previous)) {
      if (next case AsyncData(value: final next)) {
        return !const ListEquality<ShakeDetectionEvent>().equals(
          previous,
          next,
        );
      }
    }
    return super.updateShouldNotify(previous, next);
  }
}

@Riverpod(keepAlive: true)
class ShakeDetectionKmoniPointsMerged
    extends _$ShakeDetectionKmoniPointsMerged {
  @override
  Future<List<ShakeDetectionKmoniMergedEvent>> build() async {
    final points = ref.watch(kyoshinObservationPointsProvider);
    final events = ref.watch(shakeDetectionProvider).valueOrNull ?? [];
    final merged = <ShakeDetectionKmoniMergedEvent>[];
    for (final event in events) {
      final regions = event.regions.map(
        (e) => ShakeDetectionKmoniMergedRegion(
          name: e.name,
          maxIntensity: e.maxIntensity,
          points: e.points
              .map(
                (p) {
                  final point = points.points.firstWhereOrNull(
                    (e) => e.code == p.code,
                  );
                  if (point == null) {
                    return null;
                  }
                  return ShakeDetectionKmoniMergedPoint(
                    intensity: p.intensity,
                    code: p.code,
                    point: point,
                  );
                },
              )
              .whereNotNull()
              .toList(),
        ),
      );
      merged.add(
        ShakeDetectionKmoniMergedEvent(
          event: event,
          regions: regions.toList(),
        ),
      );
    }
    return merged;
  }
}

@Riverpod(keepAlive: true)
Future<List<ShakeDetectionEvent>> _fetchShakeDetectionEvents(
  _FetchShakeDetectionEventsRef ref,
) async =>
    ref.watch(eqApiProvider).v1.getLatestShakeDetectionEvents();

enum ShakeDetectionLevel {
  low(Colors.green),
  middle(Colors.yellow),
  high(Colors.red),
  highest(Colors.purple),
  ;

  const ShakeDetectionLevel(this.color);
  final Color color;

  static ShakeDetectionLevel fromJmaForecastIntensity(
    JmaForecastIntensity intensity,
  ) =>
      switch (intensity) {
        JmaForecastIntensity.zero => ShakeDetectionLevel.low,
        JmaForecastIntensity.one ||
        JmaForecastIntensity.two ||
        JmaForecastIntensity.three =>
          ShakeDetectionLevel.middle,
        JmaForecastIntensity.four ||
        JmaForecastIntensity.fiveLower ||
        JmaForecastIntensity.fiveUpper =>
          ShakeDetectionLevel.high,
        JmaForecastIntensity.sixLower ||
        JmaForecastIntensity.sixUpper ||
        JmaForecastIntensity.seven =>
          ShakeDetectionLevel.highest,
        JmaForecastIntensity.unknown =>
          throw ArgumentError('unsupported JmaForecastIntensity: $intensity'),
      };

  bool operator <(ShakeDetectionLevel other) => index < other.index;
}
