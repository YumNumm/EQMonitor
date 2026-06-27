import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('patchEewSettings sends null tiers when threshold is cleared', () async {
    final adapter = _DeviceSettingsAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceNotificationSettingsRepository(api.ApiClient(dio));

    final result = await repository.patchEewSettings(
      deviceId: 'unused',
      enabled: true,
      startLiveActivity: true,
      onePointEnabled: false,
    );

    expect(result, isA<Success<EewNotificationSettings, Exception>>());
    expect(adapter.patchEewBody, contains('notification_tiers'));
    expect(adapter.patchEewBody['notification_tiers'], isNull);
    expect(adapter.patchEewBody['one_point_enabled'], isFalse);
  });

  test('getEewSettings maps onePointEnabled from response', () async {
    final adapter = _DeviceSettingsAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceNotificationSettingsRepository(api.ApiClient(dio));

    final result = await repository.getEewSettings('unused');

    final settings = switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    expect(settings.onePointEnabled, isFalse);
  });
}

final class _DeviceSettingsAdapter implements HttpClientAdapter {
  Map<String, dynamic> patchEewBody = {};

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path == api.DeviceApiClientUrls.patchV2DeviceMeSettingsEew &&
        options.method == 'PATCH') {
      patchEewBody = Map<String, dynamic>.from(
        options.data as Map<String, dynamic>,
      );
      return _jsonResponse(
        jsonEncode({
          'enabled': patchEewBody['enabled'] ?? true,
          'notification_tiers': [
            {
              'min_jma_intensity': '4',
              'sound': 'default',
              'interruption_level': 'critical',
            },
          ],
          'start_live_activity': patchEewBody['start_live_activity'] ?? true,
          'one_point_enabled': patchEewBody['one_point_enabled'] ?? false,
        }),
      );
    }
    if (options.path == api.DeviceApiClientUrls.getV2DeviceMeSettingsEew &&
        options.method == 'GET') {
      return _jsonResponse(
        jsonEncode({
          'enabled': true,
          'notification_tiers': [
            {
              'min_jma_intensity': '4',
              'sound': 'default',
              'interruption_level': 'critical',
            },
          ],
          'start_live_activity': true,
          'one_point_enabled': false,
        }),
      );
    }
    if (options.path ==
        api.DeviceApiClientUrls.getV2DeviceMeSettingsEewRegions) {
      return _jsonResponse(jsonEncode(<Map<String, dynamic>>[]));
    }
    return ResponseBody.fromString('', 404);
  }

  ResponseBody _jsonResponse(String body) => ResponseBody.fromString(
    body,
    200,
    headers: {
      HttpHeaders.contentTypeHeader: [ContentType.json.mimeType],
    },
  );

  @override
  void close({bool force = false}) {}
}
