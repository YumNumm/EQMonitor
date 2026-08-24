import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
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

class _MutableDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  new(this.initial);

  final Earthquake initial;

  @override
  Future<Earthquake> build(String eventId) async => initial;

  void publish(Earthquake earthquake) {
    state = AsyncData(earthquake);
  }
}

const _region = EarthquakeParameterRegionItem(
  code: 'R-A',
  name: LocalizedName(ja: '地域A'),
  kana: null,
  cities: [],
);

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

Earthquake _availableEarthquake({
  String eventId = 'A',
  JmaIntensity intensity = JmaIntensity.three,
}) => Earthquake(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 8, 23),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [],
  telegramTypes: const [EarthquakeTelegramType.vxse53],
  telegramMetadata: [
    EarthquakeTelegramMetadata(
      type: EarthquakeTelegramType.vxse53,
      reportedAt: DateTime.utc(2026, 8, 23, 0, 1),
    ),
  ],
  hypocenter: null,
  intensity: EarthquakeIntensity(
    maxIntensity: intensity,
    maxLpgmIntensity: null,
    regions: {
      intensity: [IntensityRegion(region: _region, maxIntensity: intensity)],
    },
    intensityTree: const {},
    lpgmIntensityTree: const {},
  ),
  estimatedIntensityTileUrl: null,
);

MapSourceIncarnation _incarnation(String value) =>
    createMapSourceIncarnation(value: value);

MapOverlayVersionStamp _stamp(LatestEarthquakeOverlayData data) {
  final overlay = data.overlay;
  expect(overlay, isNotNull);
  return (overlay as EarthquakeMapOverlaySnapshot).versionStamp;
}

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

  test('reportedAtが同一でもcanonical data変更でdata sequenceが進む', () async {
    final earthquake = _availableEarthquake();
    final details = _MutableDetailsNotifier(earthquake);
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWithValue(colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () => _incarnation('incarnation-a'),
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider(
          'A',
        ).overrideWith(() => details),
      ],
    );
    addTearDown(container.dispose);
    final detailsSubscription = container.listen(
      earthquakeHistoryDetailsProvider('A'),
      (_, _) {},
    );
    addTearDown(detailsSubscription.close);
    final overlaySubscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, _) {},
    );
    addTearDown(overlaySubscription.close);

    final first = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );
    details.publish(
      _availableEarthquake(intensity: JmaIntensity.four),
    );
    await pumpEventQueue();
    final second = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );

    expect(first.dataSequence, 0);
    expect(second.sourceIncarnation, first.sourceIncarnation);
    expect(second.dataSequence, 1);
    expect(second.dataDigest, isNot(first.dataDigest));
    expect(second.renderGeneration, greaterThan(first.renderGeneration));
  });

  test('theme色だけの変更はdata versionを維持してrender generationを進める', () async {
    var colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final details = _MutableDetailsNotifier(_availableEarthquake());
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWith((ref) => colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () => _incarnation('incarnation-a'),
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider(
          'A',
        ).overrideWith(() => details),
      ],
    );
    addTearDown(container.dispose);
    final detailsSubscription = container.listen(
      earthquakeHistoryDetailsProvider('A'),
      (_, _) {},
    );
    addTearDown(detailsSubscription.close);
    final overlaySubscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, _) {},
    );
    addTearDown(overlaySubscription.close);

    final first = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );
    colorSet = colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(
        three: colorSet.intensity.three.copyWith(
          background: const Color(0xFF123456),
        ),
      ),
    );
    container.invalidate(activeColorSetProvider);
    await pumpEventQueue();
    final second = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );

    expect(second.sourceIncarnation, first.sourceIncarnation);
    expect(second.dataSequence, first.dataSequence);
    expect(second.dataDigest, first.dataDigest);
    expect(second.renderGeneration, first.renderGeneration + 1);
    expect(second.renderDigest, isNot(first.renderDigest));
  });

  test('provider再生成時は同じeventを新incarnationのsequence 0にする', () async {
    Future<MapOverlayVersionStamp> readStamp(String incarnation) async {
      final colorSet = AppTheme.eqmonitorDefault().colorSetFor(
        Brightness.light,
      );
      final container = ProviderContainer(
        overrides: [
          activeColorSetProvider.overrideWithValue(colorSet),
          earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
            () => _incarnation(incarnation),
          ),
          earthquakeHistoryProvider(
            latestEarthquakeOverlayParameter,
          ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
          earthquakeHistoryDetailsProvider('A').overrideWith(
            () => _MutableDetailsNotifier(_availableEarthquake()),
          ),
        ],
      );
      addTearDown(container.dispose);
      return _stamp(
        await container.read(latestEarthquakeOverlayProvider.future),
      );
    }

    final first = await readStamp('incarnation-a');
    final second = await readStamp('incarnation-b');

    expect(first.dataSequence, 0);
    expect(second.dataSequence, 0);
    expect(second.sourceIdentity, first.sourceIdentity);
    expect(second.sourceIncarnation, isNot(first.sourceIncarnation));
  });

  test('incarnation変更後は旧incarnationのdetail完了を公開しない', () async {
    final detail = Completer<Earthquake>();
    final requested = Completer<void>();
    final incarnations = [
      _incarnation('incarnation-a'),
      _incarnation('incarnation-b'),
    ].iterator;
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWithValue(colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () {
            if (!incarnations.moveNext()) {
              throw StateError('unexpected incarnation request');
            }
            return incarnations.current;
          },
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider('A').overrideWith(
          () => _PendingDetailsNotifier(
            completer: detail,
            requested: requested,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final publishedIncarnations = <MapSourceIncarnation>[];
    final subscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          final overlay = value.overlay;
          if (overlay != null) {
            publishedIncarnations.add(overlay.versionStamp.sourceIncarnation);
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await requested.future;
    container.invalidate(earthquakeOverlaySourceIncarnationProvider);
    await pumpEventQueue();
    detail.complete(_availableEarthquake());
    final result = await container.read(latestEarthquakeOverlayProvider.future);

    expect(
      publishedIncarnations,
      isNot(contains(_incarnation('incarnation-a'))),
    );
    expect(_stamp(result).sourceIncarnation, _incarnation('incarnation-b'));
    expect(_stamp(result).dataSequence, 0);
  });

  test('clock mode変更は同じeventのoverlay incarnationを切り替える', () async {
    final incarnations = [
      _incarnation('realtime-incarnation'),
      _incarnation('time-shift-incarnation'),
    ].iterator;
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWithValue(colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () {
            if (!incarnations.moveNext()) {
              throw StateError('unexpected incarnation request');
            }
            return incarnations.current;
          },
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider(
          'A',
        ).overrideWith(() => _MutableDetailsNotifier(_availableEarthquake())),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    final realtime = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );
    container
        .read(appClockProvider.notifier)
        .enterTimeShift(const Duration(minutes: -5));
    await pumpEventQueue();
    final timeShift = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );

    expect(realtime.sourceIdentity, timeShift.sourceIdentity);
    expect(realtime.sourceIncarnation, _incarnation('realtime-incarnation'));
    expect(
      timeShift.sourceIncarnation,
      _incarnation('time-shift-incarnation'),
    );
    expect(timeShift.dataSequence, 0);
  });

  test('clock mode変更後に完了した旧detailは新incarnationだけへ公開する', () async {
    final detail = Completer<Earthquake>();
    final requested = Completer<void>();
    final incarnations = [
      _incarnation('realtime-incarnation'),
      _incarnation('replay-incarnation'),
    ].iterator;
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWithValue(colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () {
            if (!incarnations.moveNext()) {
              throw StateError('unexpected incarnation request');
            }
            return incarnations.current;
          },
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider('A').overrideWith(
          () => _PendingDetailsNotifier(
            completer: detail,
            requested: requested,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final publishedIncarnations = <MapSourceIncarnation>[];
    final subscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          final overlay = value.overlay;
          if (overlay != null) {
            publishedIncarnations.add(overlay.versionStamp.sourceIncarnation);
          }
        }
      },
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    await requested.future;
    container
        .read(appClockProvider.notifier)
        .enterReplay(DateTime.utc(2026, 8, 24));
    await pumpEventQueue();
    detail.complete(_availableEarthquake());
    final result = await container.read(latestEarthquakeOverlayProvider.future);

    expect(
      publishedIncarnations,
      isNot(contains(_incarnation('realtime-incarnation'))),
    );
    expect(
      _stamp(result).sourceIncarnation,
      _incarnation('replay-incarnation'),
    );
  });

  test('通常のreplay tickはoverlay incarnationを再生成しない', () async {
    var incarnationRequestCount = 0;
    final colorSet = AppTheme.eqmonitorDefault().colorSetFor(Brightness.light);
    final container = ProviderContainer(
      overrides: [
        activeColorSetProvider.overrideWithValue(colorSet),
        earthquakeOverlaySourceIncarnationFactoryProvider.overrideWithValue(
          () => _incarnation(
            'incarnation-${++incarnationRequestCount}',
          ),
        ),
        earthquakeHistoryProvider(
          latestEarthquakeOverlayParameter,
        ).overrideWith(() => _MutableHistoryNotifier(_page('A'))),
        earthquakeHistoryDetailsProvider(
          'A',
        ).overrideWith(() => _MutableDetailsNotifier(_availableEarthquake())),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      latestEarthquakeOverlayProvider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    final appClock = container.read(appClockProvider.notifier);

    await container.read(latestEarthquakeOverlayProvider.future);
    appClock.enterReplay(DateTime.utc(2026, 8, 24));
    await pumpEventQueue();
    final replay = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );
    appClock.updateReplayTime(DateTime.utc(2026, 8, 24, 0, 0, 1));
    await pumpEventQueue();
    final replayTick = _stamp(
      await container.read(latestEarthquakeOverlayProvider.future),
    );

    expect(replayTick.sourceIncarnation, replay.sourceIncarnation);
    expect(replayTick, replay);
    expect(incarnationRequestCount, 2);
    expect(
      container.read(mapClockSourceIdentityProvider).mode,
      MapClockSourceMode.replay,
    );
  });
}
