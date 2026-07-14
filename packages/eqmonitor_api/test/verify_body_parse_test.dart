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
      final body = result.telegram.body;
      expect(body, isA<TelegramBodyUnionEarthquakeTelegramBody>());
      final eq = body as TelegramBodyUnionEarthquakeTelegramBody;
      expect(eq.earthquake?.magnitude, '4.5');
      expect(eq.earthquake?.maxIntensity, JmaIntensity.value4);
      expect(eq.earthquake?.depth, 10);
      expect(eq.earthquake?.epicenterName, '茨城県北部');
      expect(eq.intensityRegions, isNotNull);
      expect(eq.intensityRegions!.length, greaterThan(0));
    });

    test('VXSE51 with EARTHQUAKE body (no hypocenter)', () {
      final file = File(
        'test/fixtures/contract/get__v2_telegram_id__vxse51.json',
      );
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      final body = result.telegram.body;
      expect(body, isA<TelegramBodyUnionEarthquakeTelegramBody>());
      final eq = body as TelegramBodyUnionEarthquakeTelegramBody;
      expect(eq.earthquake?.maxIntensity, JmaIntensity.value4);
      expect(eq.earthquake?.magnitude, isNull);
    });

    test('VXSE53 cancel (minimal earthquake, no status)', () {
      final file = File(
        'test/fixtures/contract/get__v2_telegram_id__vxse53-cancel.json',
      );
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      final body = result.telegram.body;
      expect(body, isA<TelegramBodyUnionEarthquakeTelegramBody>());
      final eq = body as TelegramBodyUnionEarthquakeTelegramBody;
      expect(eq.earthquake?.eventId, '20251215120000');
      expect(eq.earthquake?.status, isNull);
      expect(eq.earthquake?.magnitude, isNull);
    });

    test('VXSE56 body: EARTHQUAKE_EXPLANATION type', () {
      final file = File(
        'test/fixtures/contract/get__v2_telegram_id__vxse56.json',
      );
      final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      final result = TelegramDetailResponse.fromJson(json);
      // VXSE56(地震の活動状況等に関する情報)は backend の
      // dmdata-db-writer/src/telegram/transformer.ts の
      // transformEarthquakeExplanation() で処理され、
      // body.type は "EARTHQUAKE" ではなく "EARTHQUAKE_EXPLANATION" になる。
      expect(
        result.telegram.body,
        isA<TelegramBodyUnionEarthquakeExplanationTelegramBody>(),
      );
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
