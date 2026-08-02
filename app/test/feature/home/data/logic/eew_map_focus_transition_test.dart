import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_transition.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_state.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:test/test.dart';

void main() {
  const transition = EewMapFocusTransition(
    boundsBuilder: EewMapFocusBoundsBuilder(),
  );

  group('EewMapFocusTransition', () {
    test('reportTimeが新しいEEWを最新として選ぶ', () {
      final older = _sampleEew(
        eventId: 'older',
        reportTime: _now,
        latitude: 35,
        longitude: 139,
      );
      final newer = _sampleEew(
        eventId: 'newer',
        reportTime: _now.add(const Duration(seconds: 1)),
        latitude: 36,
        longitude: 140,
      );

      final decision = transition.evaluate(
        previous: const EewMapFocusState(),
        aliveEews: [older, newer],
        allShakes: const [],
      );

      expect(decision.state.focusedEventId, 'newer');
      expect(decision.state.isFocused, isTrue);
      expect(decision.state.focusedHypocenter, (
        latitude: 36.0,
        longitude: 140.0,
      ));
      expect(decision.shouldFit, isTrue);
    });

    test('フォーカス中に震源が変わるとshouldFit=true', () {
      final previous = const EewMapFocusState(
        focusedEventId: 'event',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [_sampleEew(eventId: 'event', latitude: 36, longitude: 140)],
        allShakes: const [],
      );

      expect(decision.state.focusedHypocenter, (
        latitude: 36.0,
        longitude: 140.0,
      ));
      expect(decision.shouldFit, isTrue);
    });

    test('フォーカス中に0.5度矩形が変わるとshouldFit=true', () {
      const previous = EewMapFocusState(
        focusedEventId: 'event',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
        shakeBoundsByEventId: {
          'event': EewMapFocusGridRect(
            minLat: 35,
            maxLat: 35.5,
            minLng: 139,
            maxLng: 139.5,
          ),
        },
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [_sampleEew(eventId: 'event', latitude: 35, longitude: 139)],
        allShakes: [
          _sampleShake(
            correlatedEewEventId: 'event',
            minLat: 35.4,
            maxLat: 36.1,
            minLng: 139.4,
            maxLng: 140.1,
          ),
        ],
      );

      expect(
        decision.state.shakeBoundsByEventId['event'],
        const EewMapFocusGridRect(
          minLat: 35,
          maxLat: 36.5,
          minLng: 139,
          maxLng: 140.5,
        ),
      );
      expect(decision.shouldFit, isTrue);
    });

    test('同一グリッド内の揺れ拡大ではshouldFit=false', () {
      const previous = EewMapFocusState(
        focusedEventId: 'event',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
        shakeBoundsByEventId: {
          'event': EewMapFocusGridRect(
            minLat: 35,
            maxLat: 35.5,
            minLng: 139,
            maxLng: 139.5,
          ),
        },
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [_sampleEew(eventId: 'event', latitude: 35, longitude: 139)],
        allShakes: [
          _sampleShake(
            correlatedEewEventId: 'event',
            minLat: 35.1,
            maxLat: 35.4,
            minLng: 139.1,
            maxLng: 139.4,
          ),
        ],
      );

      expect(
        decision.state.shakeBoundsByEventId['event'],
        previous.shakeBoundsByEventId['event'],
      );
      expect(decision.shouldFit, isFalse);
    });

    test('isFocused=falseでは震源変化でもshouldFit=false', () {
      const previous = EewMapFocusState(
        focusedEventId: 'event',
        isFocused: false,
        focusedHypocenter: (latitude: 35, longitude: 139),
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [_sampleEew(eventId: 'event', latitude: 36, longitude: 140)],
        allShakes: const [],
      );

      expect(decision.state.isFocused, isFalse);
      expect(decision.state.focusedHypocenter, (
        latitude: 36.0,
        longitude: 140.0,
      ));
      expect(decision.shouldFit, isFalse);
    });

    test('新しい最新EEWは手動解除後でもisFocused=trueかつshouldFit=true', () {
      const previous = EewMapFocusState(
        focusedEventId: 'old',
        isFocused: false,
        focusedHypocenter: (latitude: 35, longitude: 139),
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [
          _sampleEew(eventId: 'old', reportTime: _now),
          _sampleEew(
            eventId: 'new',
            reportTime: _now.add(const Duration(seconds: 1)),
            latitude: 36,
            longitude: 140,
          ),
        ],
        allShakes: const [],
      );

      expect(decision.state.focusedEventId, 'new');
      expect(decision.state.isFocused, isTrue);
      expect(decision.shouldFit, isTrue);
    });

    test('フォーカスEEW消滅で残存最新へ切替', () {
      const previous = EewMapFocusState(
        focusedEventId: 'gone',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: [_sampleEew(eventId: 'alive')],
        allShakes: const [],
      );

      expect(decision.state.focusedEventId, 'alive');
      expect(decision.state.isFocused, isTrue);
      expect(decision.shouldFit, isTrue);
    });

    test('全滅でフォーカスクリア・shouldFit=false', () {
      const previous = EewMapFocusState(
        focusedEventId: 'event',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
        shakeBoundsByEventId: {
          'event': EewMapFocusGridRect(
            minLat: 35,
            maxLat: 35.5,
            minLng: 139,
            maxLng: 139.5,
          ),
        },
      );

      final decision = transition.evaluate(
        previous: previous,
        aliveEews: const [],
        allShakes: const [],
      );

      expect(decision.state.focusedEventId, isNull);
      expect(decision.state.isFocused, isFalse);
      expect(decision.state.focusedHypocenter, isNull);
      expect(decision.state.shakeBoundsByEventId, isEmpty);
      expect(decision.shouldFit, isFalse);
    });

    test('相関揺れのみ累積し他EEW・未紐付けは含めない', () {
      final decision = transition.evaluate(
        previous: const EewMapFocusState(),
        aliveEews: [
          _sampleEew(eventId: 'target', reportTime: _now),
          _sampleEew(
            eventId: 'other',
            reportTime: _now.subtract(const Duration(seconds: 1)),
          ),
        ],
        allShakes: [
          _sampleShake(
            correlatedEewEventId: 'target',
            minLat: 35.1,
            maxLat: 35.2,
            minLng: 139.1,
            maxLng: 139.2,
          ),
          _sampleShake(
            correlatedEewEventId: 'other',
            minLat: 36.1,
            maxLat: 36.2,
            minLng: 140.1,
            maxLng: 140.2,
          ),
          _sampleShake(
            correlatedEewEventId: null,
            minLat: 37.1,
            maxLat: 37.2,
            minLng: 141.1,
            maxLng: 141.2,
          ),
        ],
      );

      expect(decision.state.shakeBoundsByEventId, {
        'target': const EewMapFocusGridRect(
          minLat: 35,
          maxLat: 35.5,
          minLng: 139,
          maxLng: 139.5,
        ),
        'other': const EewMapFocusGridRect(
          minLat: 36,
          maxLat: 36.5,
          minLng: 140,
          maxLng: 140.5,
        ),
      });
    });

    test('clearFocusはisFocusedのみfalse', () {
      const previous = EewMapFocusState(
        focusedEventId: 'event',
        isFocused: true,
        focusedHypocenter: (latitude: 35, longitude: 139),
        shakeBoundsByEventId: {
          'event': EewMapFocusGridRect(
            minLat: 35,
            maxLat: 35.5,
            minLng: 139,
            maxLng: 139.5,
          ),
        },
      );

      final state = transition.clearFocus(previous: previous);

      expect(state.focusedEventId, previous.focusedEventId);
      expect(state.isFocused, isFalse);
      expect(state.focusedHypocenter, previous.focusedHypocenter);
      expect(state.shakeBoundsByEventId, previous.shakeBoundsByEventId);
    });

    test('refocusは最新へshouldFit=true', () {
      const previous = EewMapFocusState(
        focusedEventId: 'old',
        isFocused: false,
      );

      final decision = transition.refocus(
        previous: previous,
        aliveEews: [
          _sampleEew(eventId: 'old', reportTime: _now),
          _sampleEew(
            eventId: 'new',
            reportTime: _now.add(const Duration(seconds: 1)),
          ),
        ],
        allShakes: const [],
      );

      expect(decision.state.focusedEventId, 'new');
      expect(decision.state.isFocused, isTrue);
      expect(decision.shouldFit, isTrue);
    });
  });
}

final _now = DateTime.utc(2025, 1, 1, 12);

EewTelegramItem _sampleEew({
  String eventId = 'event',
  DateTime? reportTime,
  double? latitude = 35.5,
  double? longitude = 139.5,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: reportTime ?? _now,
  isPlum: false,
  hypocenter: latitude == null || longitude == null
      ? null
      : EewHypocenterInfo(
          code: '101',
          name: '東京都',
          latitude: latitude,
          longitude: longitude,
        ),
);

ShakeDetectionEvent _sampleShake({
  String eventId = 'shake',
  String? correlatedEewEventId,
  double minLat = 33,
  double maxLat = 34,
  double minLng = 130,
  double maxLng = 132,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);
