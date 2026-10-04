import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sendTestNotification', () {
    for (final entry in const {
      TestNotificationKind.silent: 'SILENT',
      TestNotificationKind.normal: 'NORMAL',
      TestNotificationKind.critical: 'CRITICAL',
      TestNotificationKind.shindoReport: 'SHINDO_REPORT',
      TestNotificationKind.shindoReportWithHypocenter:
          'SHINDO_REPORT_WITH_HYPOCENTER',
      TestNotificationKind.hypocenterAndIntensity: 'HYPOCENTER_AND_INTENSITY',
      TestNotificationKind.longPeriodGroundMotion: 'LONG_PERIOD_GROUND_MOTION',
      TestNotificationKind.eewForecast: 'EEW_FORECAST',
      TestNotificationKind.eewWarning: 'EEW_WARNING',
    }.entries) {
      test('posts selected type and preserves the existing response', () async {
        final adapter = _NotificationApiAdapter();
        final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
          ..httpClientAdapter = adapter;
        final repository = PushNotificationRepository(api.ApiClient(dio));

        final result = await repository.sendTestNotification(
          deviceId: 'device-id',
          kind: entry.key,
        );

        expect(adapter.lastPath, '/v2/device/me/notification/test');
        expect(adapter.lastRequestBody, {'type': entry.value});
        final value = switch (result) {
          Success(:final value) => value,
          Failure(:final exception) => throw exception,
        };
        expect(value.message, 'Test notification sent');
        expect(value.framework.name, 'apns');
      });
    }
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
    lastRequestBody =
        jsonDecode(jsonEncode(options.data)) as Map<String, dynamic>;
    return ResponseBody.fromString(
      jsonEncode({
        'message': 'Test notification sent',
        'framework': 'APNS',
      }),
      201,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}
