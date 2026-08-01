import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('都道府県・市区町村コードをレスポンスから更新リクエストまで保持する', () {
    const response = api.ShakeDetectionSettingResponse(
      id: 'setting-id',
      subRegionId: null,
      prefectureCode: '13',
      cityCode: null,
      minLevel: api.ShakeDetectionLevel.medium,
      isCurrentLocation: false,
      createdAt: '2026-08-02T00:00:00Z',
      updatedAt: '2026-08-02T00:00:00Z',
    );

    final entry = response.toShakeDetectionEntry();
    final request = entry.toApiRequest();

    expect(entry.prefectureCode, '13');
    expect(entry.cityCode, isNull);
    expect(request.subRegionId, isNull);
    expect(request.prefectureCode, '13');
    expect(request.cityCode, isNull);
  });
}
