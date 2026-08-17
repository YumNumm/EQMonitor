import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

class _StubEewAliveTelegram extends EewAliveTelegram {
  _StubEewAliveTelegram(this.value);

  final List<EewTelegramItem>? value;

  @override
  List<EewTelegramItem>? build() => value;
}

class _StubEewWarningOverlayEnabled extends EewWarningOverlayEnabled {
  _StubEewWarningOverlayEnabled(this.value);

  final Future<bool> value;

  @override
  Future<bool> build() => value;
}

Position _position() => Position(
  latitude: 35.681,
  longitude: 139.767,
  timestamp: DateTime.utc(2026),
  accuracy: 0,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

MapDataItem _mapItem({
  required String code,
  required String name,
  bool hasProperty = true,
}) => MapDataItem(
  property: hasProperty
      ? MapDataProperty(code: code, name: name, nameKana: '')
      : null,
);

EewTelegramItem _warningEew({
  bool? isWarning = true,
  bool isCanceled = false,
  bool hadWarning = true,
  String warningPrefectureCode = '9011',
  String warningRegionCode = '100',
  String forecastRegionCode = '200',
  JmaIntensity intensity = JmaIntensity.sixUpper,
}) => EewTelegramItem(
  eventId: 'event',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: isCanceled,
  isLastInfo: false,
  reportTime: DateTime.utc(2026, 7, 25, 11, 59),
  isPlum: false,
  isWarning: isWarning,
  forecastIntensity: EewForecastIntensityInfo(
    regions: [
      EewForecastRegionInfo(
        code: forecastRegionCode,
        name: '予報区',
        isPlum: false,
        isWarning: true,
        intensity: intensity,
        intensityIsOver: false,
      ),
    ],
  ),
  warning: EewWarningInfo(
    zones: const [],
    prefectures: [
      EewWarningZoneInfo(
        code: warningPrefectureCode,
        name: '府県予報区',
        hadWarning: hadWarning,
      ),
    ],
    regions: [
      EewWarningZoneInfo(
        code: warningRegionCode,
        name: '警報地域',
        hadWarning: hadWarning,
      ),
    ],
  ),
);

ProviderContainer _container({
  bool realtime = true,
  Future<bool>? enabled,
  List<EewTelegramItem>? alive,
  Stream<Position>? positions,
  Future<MapDataItem?>? warningArea,
  Future<MapDataItem?>? forecastArea,
  Future<MapDataItem?> Function()? forecastAreaBuilder,
}) {
  final container = ProviderContainer(
    overrides: [
      isRealtimeModeProvider.overrideWithValue(realtime),
      eewWarningOverlayEnabledProvider.overrideWith(
        () => _StubEewWarningOverlayEnabled(enabled ?? Future.value(true)),
      ),
      eewAliveTelegramProvider.overrideWith(() => _StubEewAliveTelegram(alive)),
      locationStreamProvider.overrideWith(
        (ref) => positions ?? Stream.value(_position()),
      ),
      jmaMapAreaForecastLocalEewInsideProvider.overrideWith(
        (ref, latLng) =>
            warningArea ?? Future.value(_mapItem(code: '9011', name: '警報判定区域')),
      ),
      jmaMapAreaForecastLocalEInsideProvider.overrideWith(
        (ref, latLng) =>
            forecastAreaBuilder?.call() ??
            forecastArea ??
            Future.value(_mapItem(code: '200', name: '震度予報区域')),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<List<EewWarningOverlayCandidate>> _waitForCandidates(
  ProviderContainer container,
) async {
  final completer = Completer<List<EewWarningOverlayCandidate>>();
  final subscription = container.listen(eewWarningOverlayCandidatesProvider, (
    _,
    next,
  ) {
    if (!completer.isCompleted &&
        next.isNotEmpty &&
        next.first.localForecastRegion != null) {
      completer.complete(next);
    }
  }, fireImmediately: true);
  addTearDown(subscription.close);
  return completer.future;
}

Future<List<EewWarningOverlayCandidate>> _candidatesFor({
  bool realtime = true,
  Future<bool>? enabled,
  List<EewTelegramItem>? alive,
  Stream<Position>? positions,
  Future<MapDataItem?>? warningArea,
  Future<MapDataItem?>? forecastArea,
}) async {
  final container = _container(
    realtime: realtime,
    enabled: enabled,
    alive: alive,
    positions: positions,
    warningArea: warningArea,
    forecastArea: forecastArea,
  );
  final subscription = container.listen(
    eewWarningOverlayCandidatesProvider,
    (_, _) {},
  );
  addTearDown(subscription.close);
  for (var i = 0; i < 6; i++) {
    await container.pump();
  }
  return container.read(eewWarningOverlayCandidatesProvider);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('LocalEewで対象判定しLocalEで現在地予想を引く', () async {
    final container = _container(alive: [_warningEew()]);

    final value = await _waitForCandidates(container);

    expect(value, hasLength(1));
    expect(value.single.warningAreaName, '警報判定区域');
    expect(value.single.localForecastRegion?.intensity, JmaIntensity.sixUpper);
  });

  test('前提条件を満たさない警報を候補から除外する', () async {
    expect(
      await _candidatesFor(realtime: false, alive: [_warningEew()]),
      isEmpty,
    );
    expect(
      await _candidatesFor(
        enabled: Future.value(false),
        alive: [_warningEew()],
      ),
      isEmpty,
    );
    expect(await _candidatesFor(), isEmpty);
    expect(
      await _candidatesFor(
        alive: [_warningEew()],
        positions: const Stream.empty(),
      ),
      isEmpty,
    );
    expect(
      await _candidatesFor(alive: [_warningEew()], warningArea: Future.value()),
      isEmpty,
    );
    expect(
      await _candidatesFor(
        alive: [_warningEew()],
        warningArea: Future.value(
          _mapItem(code: '9011', name: '警報判定区域', hasProperty: false),
        ),
      ),
      isEmpty,
    );
    expect(
      await _candidatesFor(alive: [_warningEew(isCanceled: true)]),
      isEmpty,
    );
    expect(
      await _candidatesFor(alive: [_warningEew(isWarning: false)]),
      isEmpty,
    );
  });

  test('初回警報でhadWarningがfalseでも候補に残す', () async {
    expect(
      await _candidatesFor(alive: [_warningEew(hadWarning: false)]),
      hasLength(1),
    );
  });

  test('設定の未解決中は候補を返さない', () async {
    expect(
      await _candidatesFor(
        enabled: Completer<bool>().future,
        alive: [_warningEew()],
      ),
      isEmpty,
    );
  });

  test('位置情報が解決済みからloadingまたはerrorになると候補を消す', () async {
    final positions = StreamController<Position>.broadcast();
    addTearDown(positions.close);
    final container = _container(
      alive: [_warningEew()],
      positions: positions.stream,
    );
    final subscription = container.listen(
      eewWarningOverlayCandidatesProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    await container.pump();
    await container.pump();
    positions.add(_position());
    for (var i = 0; i < 6; i++) {
      await container.pump();
    }
    expect(container.read(eewWarningOverlayCandidatesProvider), hasLength(1));

    container.invalidate(locationStreamProvider);
    await container.pump();
    expect(container.read(eewWarningOverlayCandidatesProvider), isEmpty);

    positions.addError(StateError('location failed'));
    await container.pump();
    expect(container.read(eewWarningOverlayCandidatesProvider), isEmpty);
  });

  test('警報区域が解決済みからloadingまたはerrorになると候補を消す', () async {
    var warningArea = Future<MapDataItem?>.value(
      _mapItem(code: '9011', name: '警報判定区域'),
    );
    final position = _position();
    final latLng = LatLng(position.latitude, position.longitude);
    final container = ProviderContainer(
      overrides: [
        isRealtimeModeProvider.overrideWithValue(true),
        eewWarningOverlayEnabledProvider.overrideWith(
          () => _StubEewWarningOverlayEnabled(Future.value(true)),
        ),
        eewAliveTelegramProvider.overrideWith(
          () => _StubEewAliveTelegram([_warningEew()]),
        ),
        locationStreamProvider.overrideWith((ref) => Stream.value(position)),
        jmaMapAreaForecastLocalEewInsideProvider.overrideWith(
          (ref, latLng) => warningArea,
        ),
        jmaMapAreaForecastLocalEInsideProvider.overrideWith(
          (ref, latLng) async => _mapItem(code: '200', name: '震度予報区域'),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      eewWarningOverlayCandidatesProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    for (var i = 0; i < 6; i++) {
      await container.pump();
    }
    expect(container.read(eewWarningOverlayCandidatesProvider), hasLength(1));

    warningArea = Completer<MapDataItem?>().future;
    container.invalidate(jmaMapAreaForecastLocalEewInsideProvider(latLng));
    await container.pump();
    expect(container.read(eewWarningOverlayCandidatesProvider), isEmpty);

    final errorArea = Completer<MapDataItem?>();
    warningArea = errorArea.future;
    container.invalidate(jmaMapAreaForecastLocalEewInsideProvider(latLng));
    await container.pump();
    errorArea.completeError(StateError('area failed'));
    await container.pump();
    expect(container.read(eewWarningOverlayCandidatesProvider), isEmpty);
  });

  test('予報区域がloadingまたはerrorでも候補を残し局地情報を不明にする', () async {
    var forecastArea = Future<MapDataItem?>.value(
      _mapItem(code: '200', name: '震度予報区域'),
    );
    final position = _position();
    final latLng = LatLng(position.latitude, position.longitude);
    final container = _container(
      alive: [_warningEew()],
      positions: Stream.value(position),
      forecastAreaBuilder: () => forecastArea,
    );
    final subscription = container.listen(
      eewWarningOverlayCandidatesProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    final initial = await _waitForCandidates(container);
    expect(initial.single.localForecastRegion, isNotNull);

    forecastArea = Completer<MapDataItem?>().future;
    container.invalidate(jmaMapAreaForecastLocalEInsideProvider(latLng));
    await container.pump();
    var value = container.read(eewWarningOverlayCandidatesProvider);
    expect(value, hasLength(1));
    expect(value.single.localForecastRegion, isNull);
    expect(value.single.forecastAreaName, isNull);

    final errorArea = Completer<MapDataItem?>();
    forecastArea = errorArea.future;
    container.invalidate(jmaMapAreaForecastLocalEInsideProvider(latLng));
    await container.pump();
    errorArea.completeError(StateError('forecast area failed'));
    await container.pump();
    value = container.read(eewWarningOverlayCandidatesProvider);
    expect(value, hasLength(1));
    expect(value.single.localForecastRegion, isNull);
    expect(value.single.forecastAreaName, isNull);
  });
}
