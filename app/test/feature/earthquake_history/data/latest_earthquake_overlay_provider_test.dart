import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _MutableHistoryNotifier extends EarthquakeHistoryNotifier {
  new(this.initial);

  final PaginatedResponse<EarthquakePartial> initial;

  @override
  Future<PaginatedResponse<EarthquakePartial>> build(parameter) async =>
      initial;

  void publish(PaginatedResponse<EarthquakePartial> page) {
    state = AsyncData(page);
  }
}

class _PendingDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  new({required this.completer, required this.requested});

  final Completer<Earthquake> completer;
  final Completer<void> requested;

  @override
  Future<Earthquake> build(String eventId) {
    if (!requested.isCompleted) {
      requested.complete();
    }
    return completer.future;
  }
}

EarthquakePartial _partial(String eventId) => EarthquakePartial.normal(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 8, 23),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);

PaginatedResponse<EarthquakePartial> _page(String eventId) =>
    PaginatedResponse(items: [_partial(eventId)], nextToken: null);

Earthquake _earthquake(String eventId) => Earthquake(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 8, 23),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [],
  telegramTypes: const [],
  telegramMetadata: const [],
  hypocenter: null,
  intensity: null,
  estimatedIntensityTileUrl: null,
);

void main() {
  test('一覧はevent ID降順かつ震度1以上の専用parameterを使う', () {
    expect(latestEarthquakeOverlayParameter.sortBy.name, 'eventId');
    expect(latestEarthquakeOverlayParameter.sortOrder.name, 'desc');
    expect(latestEarthquakeOverlayParameter.intensityGte, JmaIntensity.one);
  });

  test('event A detail待機中にBへ切り替わるとA完了を公開しない', () async {
    final history = _MutableHistoryNotifier(_page('A'));
    final detailA = Completer<Earthquake>();
    final detailB = Completer<Earthquake>();
    final requestedA = Completer<void>();
    final requestedB = Completer<void>();
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWith((ref) => colorSet),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => history),
        earthquakeHistoryDetailsProvider('A').overrideWith(
          () => _PendingDetailsNotifier(
            completer: detailA,
            requested: requestedA,
          ),
        ),
        earthquakeHistoryDetailsProvider('B').overrideWith(
          () => _PendingDetailsNotifier(
            completer: detailB,
            requested: requestedB,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final publishedEventIds = <String>[];
    final subscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          final eventId = value.eventId;
          if (eventId != null) {
            publishedEventIds.add(eventId);
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await requestedA.future;
    history.publish(_page('B'));
    await requestedB.future;
    detailA.complete(_earthquake('A'));
    await pumpEventQueue();

    expect(publishedEventIds, isNot(contains('A')));
    detailB.complete(_earthquake('B'));
    final result = await container.read(latestEarthquakeOverlayProvider.future);
    expect(result.eventId, 'B');
    expect(
      result.availability,
      LatestEarthquakeOverlayAvailability.noIntensity,
    );
  });
}
