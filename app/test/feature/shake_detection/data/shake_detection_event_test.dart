import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShakeDetectionEvent', () {
    test('copyWith で mergedEewEventId を付与できること', () {
      final event = ShakeDetectionEvent(
        eventId: 'e1',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        level: ShakeDetectionLevel.weak,
        isReplay: false,
        pointCount: 3,
        minLat: 34,
        maxLat: 36,
        minLng: 138,
        maxLng: 140,
      );

      expect(event.mergedEewEventId, isNull);

      final merged = event.copyWith(mergedEewEventId: 'EEW-1');
      expect(merged.mergedEewEventId, 'EEW-1');
      // ほかのフィールドは保持される
      expect(merged.eventId, 'e1');
      expect(merged.pointCount, 3);
    });

    test('同一フィールドの 2 インスタンスは等価 (==)', () {
      final a = ShakeDetectionEvent(
        eventId: 'e1',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        level: ShakeDetectionLevel.medium,
        isReplay: true,
        pointCount: 5,
        minLat: 34,
        maxLat: 36,
        minLng: 138,
        maxLng: 140,
        mergedEewEventId: 'EEW-1',
      );
      final b = ShakeDetectionEvent(
        eventId: 'e1',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        level: ShakeDetectionLevel.medium,
        isReplay: true,
        pointCount: 5,
        minLat: 34,
        maxLat: 36,
        minLng: 138,
        maxLng: 140,
        mergedEewEventId: 'EEW-1',
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('mergedEewEventId が異なれば != になること', () {
      final base = ShakeDetectionEvent(
        eventId: 'e1',
        createdAt: DateTime.utc(2025, 1, 1, 12),
        level: ShakeDetectionLevel.medium,
        isReplay: false,
        pointCount: 1,
        minLat: 34,
        maxLat: 36,
        minLng: 138,
        maxLng: 140,
      );
      expect(base, isNot(base.copyWith(mergedEewEventId: 'EEW-1')));
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
