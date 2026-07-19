import 'package:clock/clock.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 深さ100km, 経過10s で pDistance≈100km, sDistance≈50km となる
/// テスト用の走時テーブル。
TravelTimeDepthMap _stubTravelTimeMap() => {
  100: const [
    TravelTimeTable(p: 0, s: 0, depth: 100, distance: 0),
    TravelTimeTable(p: 20, s: 40, depth: 100, distance: 200),
  ],
};

EewTelegramItem _eew({
  required String eventId,
  double latitude = 35,
  double longitude = 139,
  bool hasLatLng = true,
  int? depth = 100,
  DateTime? originTime,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2025, 1, 1, 12),
  isPlum: false,
  originTime: originTime,
  hypocenter: EewHypocenterInfo(
    code: '350',
    name: 'テスト震源',
    latitude: hasLatLng ? latitude : null,
    longitude: hasLatLng ? longitude : null,
    depth: depth,
    magnitude: 5,
  ),
);

ShakeDetectionEvent _shake({
  required String eventId,
  required double centerLat,
  required double centerLng,
  double halfSize = 0.05,
}) => ShakeDetectionEvent(
  eventId: eventId,
  createdAt: DateTime.utc(2025, 1, 1, 12),
  level: ShakeDetectionLevel.medium,
  isReplay: false,
  pointCount: 3,
  minLat: centerLat - halfSize,
  maxLat: centerLat + halfSize,
  minLng: centerLng - halfSize,
  maxLng: centerLng + halfSize,
  changeReasons: const ['new_event'],
);

class _StubEewAliveTelegram extends EewAliveTelegram {
  _StubEewAliveTelegram(this._initial);
  final List<EewTelegramItem> _initial;

  @override
  List<EewTelegramItem>? build() => _initial;
}

ProviderContainer _container({
  required List<ShakeDetectionEvent> shakes,
  required List<EewTelegramItem> eews,
}) {
  final container = ProviderContainer(
    overrides: [
      shakeDetectionProvider.overrideWithValue(shakes),
      eewAliveTelegramProvider.overrideWith(
        () => _StubEewAliveTelegram(eews),
      ),
      travelTimeDepthMapProvider.overrideWithValue(_stubTravelTimeMap()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  // 経過時間=10s → pDist=100km, sDist=50km, innerBound=25km, outerBound=125km
  final originTime = DateTime.utc(2025, 1, 1, 12);
  final now = originTime.add(const Duration(seconds: 10));

  group('shakeDetectionMerged — EEW 結合判定', () {
    test(
      '距離 ~50km の shake は EEW にマージされる (innerBound 25 〜 outerBound 125 内)',
      () {
        withClock(Clock.fixed(now), () {
          final container = _container(
            shakes: [
              _shake(eventId: 'shake-near', centerLat: 35.45, centerLng: 139),
            ],
            eews: [
              _eew(eventId: 'EEW-1', originTime: originTime),
            ],
          );
          final result = container.read(shakeDetectionMergedProvider);
          expect(result.single.mergedEewEventId, 'EEW-1');
        });
      },
    );

    test('距離 ~250km の shake はマージされない (outerBound 125 超過)', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-far', centerLat: 37.25, centerLng: 139),
          ],
          eews: [
            _eew(eventId: 'EEW-1', originTime: originTime),
          ],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result.single.mergedEewEventId, isNull);
      });
    });

    test('距離 ~10km の shake はマージされない (innerBound 25 未満)', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(
              eventId: 'shake-very-near',
              centerLat: 35.09,
              centerLng: 139,
            ),
          ],
          eews: [
            _eew(eventId: 'EEW-1', originTime: originTime),
          ],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result.single.mergedEewEventId, isNull);
      });
    });

    test('EEW に originTime が無いとマージ判定対象外', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-near', centerLat: 35.45, centerLng: 139),
          ],
          eews: [
            _eew(eventId: 'EEW-1'),
          ],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result.single.mergedEewEventId, isNull);
      });
    });

    test('EEW の hypocenter が hasLatLng=false ならマージ判定対象外', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-near', centerLat: 35.45, centerLng: 139),
          ],
          eews: [
            _eew(
              eventId: 'EEW-1',
              hasLatLng: false,
              originTime: originTime,
            ),
          ],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result.single.mergedEewEventId, isNull);
      });
    });

    test('EEW が空でも shake はそのまま (mergedEewEventId=null) で返る', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-1', centerLat: 35.45, centerLng: 139),
          ],
          eews: [],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result, hasLength(1));
        expect(result.single.mergedEewEventId, isNull);
      });
    });

    test('複数の shake のうち条件を満たすもののみ merged になる', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-near', centerLat: 35.45, centerLng: 139),
            _shake(eventId: 'shake-far', centerLat: 37.25, centerLng: 139),
          ],
          eews: [
            _eew(eventId: 'EEW-1', originTime: originTime),
          ],
        );
        final result = container.read(shakeDetectionMergedProvider);
        expect(result, hasLength(2));
        final byId = {for (final e in result) e.eventId: e};
        expect(byId['shake-near']!.mergedEewEventId, 'EEW-1');
        expect(byId['shake-far']!.mergedEewEventId, isNull);
      });
    });
  });

  group('shakeDetectionVisible — merge 結果由来のフィルタ', () {
    test('merged な shake は隠され、unmerged のみ表示される', () {
      withClock(Clock.fixed(now), () {
        final container = _container(
          shakes: [
            _shake(eventId: 'shake-near', centerLat: 35.45, centerLng: 139),
            _shake(eventId: 'shake-far', centerLat: 37.25, centerLng: 139),
          ],
          eews: [
            _eew(eventId: 'EEW-1', originTime: originTime),
          ],
        );
        final result = container.read(shakeDetectionVisibleProvider);
        expect(result.map((e) => e.eventId).toList(), ['shake-far']);
      });
    });
  });
}
