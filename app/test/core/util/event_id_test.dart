import 'package:eqmonitor/core/util/event_id.dart';
import 'package:test/test.dart';

void main() {
  test(
    'intをEventIdへ変換できること',
    () {
      const target = 20240101235959;
      final _ = EventId(target);
    },
  );
  group('EventIdの桁数が不正の場合', () {
    test(
      'EventIdの桁数が足りない場合、nullを返すこと',
      () {
        const target = 202401012359; // ssがない
        final result = EventId(target);
        expect(result.toCreationDate(), isNull);
      },
    );
    test('EventIdの桁数が多い場合、nullを返すこと', () {
      const target = 202401012359599; // 1桁多い
      final result = EventId(target);
      expect(result.toCreationDate(), isNull);
    });
  });
  group('EventIdからDateTimeへ変換できること', () {
    final map = <int, DateTime>{
      20240101000000: DateTime(2024),
      20241231235959: DateTime(2024, 12, 31, 23, 59, 59),
      20240131010203: DateTime(2024, 1, 31, 1, 2, 3),
    };
    for (final entry in map.entries) {
      test(
        'EventId: ${entry.key} -> DateTime: ${entry.value}',
        () {
          final result = EventId(entry.key);
          expect(result.toCreationDate(), entry.value);
        },
      );
    }
  });
}
