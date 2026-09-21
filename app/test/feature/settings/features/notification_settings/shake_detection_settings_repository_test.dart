import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_settings_repository.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

class _Adapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  var reject = false;
  @override
  void close({bool force = false}) {}
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    expect(options.path, endsWith('/shake-detection'));
    final body = options.method == 'PUT'
        ? jsonDecode(jsonEncode(options.data)) as List
        : <Map<String, dynamic>>[];
    return ResponseBody.fromString(
      jsonEncode({
        'settings': [
          for (final (index, item) in body.indexed)
            {
              ...item as Map<String, dynamic>,
              'id': 'id-$index',
              'created_at': '2026-09-21T00:00:00Z',
              'updated_at': '2026-09-21T00:00:00Z',
            },
        ],
        'requires_reconfiguration': options.method == 'GET',
      }),
      reject ? 400 : 200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }
}

void main() {
  test(
    'loads migration state and serializes only explicit subdivision conditions',
    () async {
      final adapter = _Adapter();
      final repository = ShakeDetectionSettingsRepository(
        api.ApiClient(
          Dio(BaseOptions(baseUrl: 'https://example.com'))
            ..httpClientAdapter = adapter,
        ),
      );
      final loaded = await repository.load();
      expect(loaded.requiresReconfiguration, isTrue);
      final entries = [
        for (final target in ShakeDetectionTargetType.values)
          ShakeDetectionEntry(
            id: '',
            targetType: target,
            regionCode: target == ShakeDetectionTargetType.region
                ? '350'
                : null,
            enabled: target != ShakeDetectionTargetType.nationwide,
            minLevel: ShakeDetectionLevel.strong,
          ),
      ];
      final saved = await repository.save(entries);
      expect(saved.requiresReconfiguration, isFalse);
      expect(
        saved.entries.map(
          (e) => (e.targetType, e.regionCode, e.enabled, e.minLevel),
        ),
        entries.map((e) => (e.targetType, e.regionCode, e.enabled, e.minLevel)),
      );
      expect(jsonDecode(jsonEncode(adapter.requests.last.data)), [
        {
          'target_type': 'current_location',
          'region_code': null,
          'enabled': true,
          'min_level': 'Strong',
        },
        {
          'target_type': 'nationwide',
          'region_code': null,
          'enabled': false,
          'min_level': 'Strong',
        },
        {
          'target_type': 'region',
          'region_code': '350',
          'enabled': true,
          'min_level': 'Strong',
        },
      ]);
      adapter.reject = true;
      await expectLater(repository.save(entries), throwsA(isA<DioException>()));
      expect(adapter.requests, hasLength(3));
    },
  );
}
