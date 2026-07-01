import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sendTestScenarioType', () {
    test('posts selected scenario and returns dialog json', () async {
      final adapter = _NotificationApiAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final repository = PushNotificationRepository(api.ApiClient(dio));

      final result = await repository.sendTestScenarioType(
        deviceId: 'device-id',
        scenario: TestScenarioType.eewWarning,
      );

      expect(adapter.lastPath, '/v2/device/me/notification/test-scenario-type');
      expect(adapter.lastRequestBody, {
        'scenario': api.TestNotificationScenario.eewWarning,
      });
      final value = switch (result) {
        Success(:final value) => value,
        Failure(:final exception) => throw exception,
      };
      expect(value.message, 'テスト通知を送信しました');
      expect(value.scenario, 'EEW_WARNING');
      expect(value.eventId, 'event-001');
      expect(
        value.prettyJson,
        const JsonEncoder.withIndent('  ').convert({
          'message': 'テスト通知を送信しました',
          'scenario': 'EEW_WARNING',
          'event_id': 'event-001',
        }),
      );
    });
  });
}

final class _NotificationApiAdapter implements HttpClientAdapter {
  String? lastPath;
  Map<String, dynamic>? lastRequestBody;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastPath = options.path;
    lastRequestBody = Map<String, dynamic>.from(options.data as Map);
    return ResponseBody.fromString(
      jsonEncode({
        'message': 'テスト通知を送信しました',
        'scenario': 'EEW_WARNING',
        'event_id': 'event-001',
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}
