import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  group('TelegramBodyUnion.fromJson discriminator', () {
    test('EARTHQUAKE', () {
      final body = TelegramBodyUnion.fromJson({
        'type': 'EARTHQUAKE',
        'earthquake': {'eventId': '1', 'status': 'NORMAL'},
      });
      expect(body, isA<TelegramBodyUnionEarthquakeTelegramBody>());
    });

    test('EEW', () {
      final body = TelegramBodyUnion.fromJson({
        'type': 'EEW',
        'eew': {},
        'eewIntensityRegions': <dynamic>[],
        'eewWarningZones': <dynamic>[],
        'eewWarningPrefectures': <dynamic>[],
        'eewWarningRegions': <dynamic>[],
      });
      expect(body, isA<TelegramBodyUnionEewTelegramBody>());
    });

    test('EARTHQUAKE_NOTICE', () {
      final body = TelegramBodyUnion.fromJson({'type': 'EARTHQUAKE_NOTICE'});
      expect(body, isA<TelegramBodyUnionEarthquakeNoticeTelegramBody>());
    });

    test('EARTHQUAKE_EXPLANATION', () {
      final body = TelegramBodyUnion.fromJson({
        'type': 'EARTHQUAKE_EXPLANATION',
        'text': 'テスト',
      });
      expect(body, isA<TelegramBodyUnionEarthquakeExplanationTelegramBody>());
    });

    test('unknown throws', () {
      expect(
        () => TelegramBodyUnion.fromJson({'type': 'UNKNOWN'}),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
