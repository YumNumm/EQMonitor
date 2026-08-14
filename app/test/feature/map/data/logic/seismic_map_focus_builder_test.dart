import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

const _fallback = LngLatBounds(
  longitudeWest: 120,
  longitudeEast: 154,
  latitudeSouth: 20,
  latitudeNorth: 46,
);

final _now = DateTime.utc(2026, 7, 27, 12);

EewTelegramItem _eew({required double? latitude, required double? longitude}) =>
    EewTelegramItem(
      eventId: 'eew',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 1,
      isCanceled: false,
      isLastInfo: false,
      reportTime: _now,
      isPlum: false,
      hypocenter: EewHypocenterInfo(
        code: '001',
        name: 'テスト震源',
        latitude: latitude,
        longitude: longitude,
      ),
    );

ShakeDetectionEvent _shake({
  required double minLat,
  required double maxLat,
  required double minLng,
  required double maxLng,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: 'shake',
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

void main() {
  const builder = SeismicMapFocusBuilder();

  test('EEWのみの震源を余白付きboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [_eew(latitude: 40, longitude: 142)],
      shakes: const [],
    );

    expect(bounds.latitudeSouth, lessThan(40));
    expect(bounds.latitudeNorth, greaterThan(40));
    expect(bounds.longitudeWest, lessThan(142));
    expect(bounds.longitudeEast, greaterThan(142));
  });

  test('未結合揺れ検知のみの矩形を余白付きboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: [_shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
    );

    expect(bounds.latitudeSouth, lessThan(33));
    expect(bounds.latitudeNorth, greaterThan(34));
    expect(bounds.longitudeWest, lessThan(130));
    expect(bounds.longitudeEast, greaterThan(132));
  });

  test('EEWと未結合揺れ検知の全座標を同じboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [_eew(latitude: 40, longitude: 142)],
      shakes: [_shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
    );

    expect(bounds.latitudeSouth, lessThanOrEqualTo(33));
    expect(bounds.latitudeNorth, greaterThanOrEqualTo(40));
    expect(bounds.longitudeWest, lessThanOrEqualTo(130));
    expect(bounds.longitudeEast, greaterThanOrEqualTo(142));
  });

  test('対象がなければユーザーのfallback boundsを返す', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: const [],
    );

    expect(bounds, _fallback);
  });

  test('結合済み揺れ検知はfocus対象に含めない', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: [
        _shake(
          minLat: 33,
          maxLat: 34,
          minLng: 130,
          maxLng: 132,
          correlatedEewEventId: 'eew-1',
        ),
      ],
    );

    expect(bounds, _fallback);
  });

  test('不正座標は除外して有効なEEWのみをfocusに使う', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [
        _eew(latitude: double.nan, longitude: 139),
        _eew(latitude: 91, longitude: 139),
        _eew(latitude: 36, longitude: 140),
      ],
      shakes: [
        _shake(minLat: double.nan, maxLat: 34, minLng: 130, maxLng: 132),
        _shake(minLat: 33, maxLat: 34, minLng: 181, maxLng: 182),
      ],
    );

    expect(bounds.latitudeSouth, lessThan(36));
    expect(bounds.latitudeNorth, greaterThan(36));
    expect(bounds.longitudeWest, lessThan(140));
    expect(bounds.longitudeEast, greaterThan(140));
  });
}
