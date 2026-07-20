import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

final _createdAt = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent event({String? correlatedEewEventId}) =>
    ShakeDetectionEvent(
      eventId: 'e1',
      serialNo: 1,
      createdAt: _createdAt,
      updatedAt: _createdAt,
      expiresAt: _createdAt.add(const Duration(minutes: 1)),
      level: ShakeDetectionLevel.medium,
      pointCount: 3,
      minLat: 34,
      maxLat: 36,
      minLng: 138,
      maxLng: 140,
      changeReasons: const ['new_event'],
      correlatedEewEventId: correlatedEewEventId,
    );

void main() {
  group('ShakeDetectionEvent', () {
    test('同一フィールドの2インスタンスは等価であること', () {
      expect(event(), event());
      expect(event().hashCode, event().hashCode);
    });

    test('copyWithでcorrelatedEewEventIdを設定できること', () {
      final correlated = event().copyWith(correlatedEewEventId: 'EEW-1');
      expect(correlated.correlatedEewEventId, 'EEW-1');
      expect(correlated.eventId, 'e1');
      expect(correlated, isNot(event()));
    });
  });

  group('ShakeDetectionLevel enum (eqmonitor_api)', () {
    test('全レベルが json プロパティを持つこと', () {
      const cases = <ShakeDetectionLevel, String>{
        ShakeDetectionLevel.weaker: 'Weaker',
        ShakeDetectionLevel.weak: 'Weak',
        ShakeDetectionLevel.medium: 'Medium',
        ShakeDetectionLevel.strong: 'Strong',
        ShakeDetectionLevel.stronger: 'Stronger',
      };
      for (final entry in cases.entries) {
        expect(entry.key.json, entry.value);
      }
    });
  });
}
