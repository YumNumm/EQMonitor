import 'dart:convert';
import 'dart:io';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  group('TelegramDetailResponse with body from real fixtures', () {
    test('default (VXSE53 with EARTHQUAKE body)', () {
      final file = File('test/fixtures/contract/get__v2_telegram_id.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      expect(result.telegram.type, TelegramType.vxse53);
    });

    test('VXSE51', () {
      final file = File(
        'test/fixtures/contract/get__v2_telegram_id__vxse51.json',
      );
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      expect(result.telegram.type, TelegramType.vxse51);
    });

    test('VXSE56', () {
      final file = File(
        'test/fixtures/contract/get__v2_telegram_id__vxse56.json',
      );
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      expect(result.telegram.type, TelegramType.vxse56);
    });
  });

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
        'eew': {
          'eventId': '20251215120000',
          'type': 'VXSE45',
          'status': 'NORMAL',
          'infoType': 'PUBLICATION',
          'serialNo': 1,
          'isCanceled': false,
          'isLastInfo': false,
          'isPlum': false,
        },
        'eewIntensityRegions': <Map<String, Object?>>[],
        'eewWarningZones': <Map<String, Object?>>[],
        'eewWarningPrefectures': <Map<String, Object?>>[],
        'eewWarningRegions': <Map<String, Object?>>[],
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
