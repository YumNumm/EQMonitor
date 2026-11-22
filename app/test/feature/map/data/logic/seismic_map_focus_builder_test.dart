import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

const _fallback = MapCameraBounds(
  west: 120,
  east: 154,
  south: 20,
  north: 46,
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
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
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

    expect(bounds.south, lessThan(40));
    expect(bounds.north, greaterThan(40));
    expect(bounds.west, lessThan(142));
    expect(bounds.east, greaterThan(142));
  });

  test('未結合揺れ検知のみの矩形を余白付きboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: [_shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
    );

    expect(bounds.south, lessThan(33));
    expect(bounds.north, greaterThan(34));
    expect(bounds.west, lessThan(130));
    expect(bounds.east, greaterThan(132));
  });

  test('EEWと未結合揺れ検知の全座標を同じboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [_eew(latitude: 40, longitude: 142)],
      shakes: [_shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
    );

    expect(bounds.south, lessThanOrEqualTo(33));
    expect(bounds.north, greaterThanOrEqualTo(40));
    expect(bounds.west, lessThanOrEqualTo(130));
    expect(bounds.east, greaterThanOrEqualTo(142));
  });

  test('対象がなければユーザーのfallback boundsを返す', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: const [],
    );

    expect(bounds, _fallback);
  });

  test('EEWと結合した揺れ検知の矩形も震源と合わせてboundsへ含める', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [_eew(latitude: 40.6, longitude: 143.8)],
      shakes: [
        _shake(
          minLat: 38,
          maxLat: 43,
          minLng: 140,
          maxLng: 142,
          correlatedEewEventId: 'eew-1',
        ),
      ],
    );

    expect(bounds.south, lessThanOrEqualTo(38));
    expect(bounds.north, greaterThanOrEqualTo(43));
    expect(bounds.west, lessThanOrEqualTo(140));
    expect(bounds.east, greaterThanOrEqualTo(143.8));
  });

  test('EEW単独でも中心から最小半径ぶんのboundsを確保する', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [_eew(latitude: 35, longitude: 139)],
      shakes: const [],
    );

    // 最小半径 150km は緯度およそ 1.347 度に相当する。
    expect(bounds.north - 35, greaterThan(1.3));
    expect(35 - bounds.south, greaterThan(1.3));
    // 経度方向は cos(緯度) で割るぶん緯度方向より広くなる。
    expect(
      bounds.east - bounds.west,
      greaterThan(bounds.north - bounds.south),
    );
  });

  test('最小半径より広い揺れ検知の矩形は縮められない', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: const [],
      shakes: [_shake(minLat: 33, maxLat: 38, minLng: 130, maxLng: 140)],
    );

    expect(bounds.south, closeTo(33 - seismicMapFocusMargin, 1e-9));
    expect(bounds.north, closeTo(38 + seismicMapFocusMargin, 1e-9));
    expect(bounds.west, closeTo(130 - seismicMapFocusMargin, 1e-9));
    expect(bounds.east, closeTo(140 + seismicMapFocusMargin, 1e-9));
  });

  test('複数EEWの震源をすべて内包する', () {
    final bounds = builder.forRealtime(
      fallbackBounds: _fallback,
      eews: [
        _eew(latitude: 35, longitude: 139),
        _eew(latitude: 43, longitude: 145),
      ],
      shakes: const [],
    );

    expect(bounds.south, lessThan(35));
    expect(bounds.north, greaterThan(43));
    expect(bounds.west, lessThan(139));
    expect(bounds.east, greaterThan(145));
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

    expect(bounds.south, lessThan(36));
    expect(bounds.north, greaterThan(36));
    expect(bounds.west, lessThan(140));
    expect(bounds.east, greaterThan(140));
  });
}
