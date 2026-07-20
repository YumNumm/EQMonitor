import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

void main() {
  // ---------------------------------------------------------------------------
  // 1. WsShakeObservationPoint.fromJson
  // ---------------------------------------------------------------------------
  group('WsShakeObservationPoint.fromJson', () {
    test('全フィールドを正しくデシリアライズできること', () {
      final json = <String, dynamic>{
        'code': 'KNG001',
        'name': '横浜',
        'region': '神奈川',
        'type': 'K-NET',
        'location': {'latitude': 35.5, 'longitude': 139.7},
        'intensity': 2.5,
        'intensityDiff': 0.3,
      };

      final result = WsShakeObservationPoint.fromJson(json);

      expect(result.code, equals('KNG001'));
      expect(result.name, equals('横浜'));
      expect(result.region, equals('神奈川'));
      expect(result.type, equals('K-NET'));
      expect(result.location.latitude, equals(35.5));
      expect(result.location.longitude, equals(139.7));
      expect(result.intensity, equals(2.5));
      expect(result.intensityDiff, equals(0.3));
    });

    test('intensity が null の場合も正しく扱われること', () {
      final json = <String, dynamic>{
        'code': 'OSK001',
        'name': '大阪',
        'region': '大阪府',
        'type': 'KiK-net',
        'location': {'latitude': 34.7, 'longitude': 135.5},
        'intensity': null,
        'intensityDiff': -0.1,
      };

      final result = WsShakeObservationPoint.fromJson(json);

      expect(result.intensity, isNull);
      expect(result.intensityDiff, equals(-0.1));
    });

    test('intensityDiff が省略された場合は 0 になること', () {
      final result = WsShakeObservationPoint.fromJson({
        'code': 'OSK002',
        'name': '大阪2',
        'region': '大阪府',
        'type': 'K-NET',
        'location': {'latitude': 34.7, 'longitude': 135.5},
        'intensity': null,
      });

      expect(result.intensity, isNull);
      expect(result.intensityDiff, 0);
    });

    test('intensityDiff が null の場合は拒否すること', () {
      expect(
        () => WsShakeObservationPoint.fromJson({
          'code': 'OSK003',
          'name': '大阪3',
          'region': '大阪府',
          'type': 'K-NET',
          'location': {'latitude': 34.7, 'longitude': 135.5},
          'intensity': null,
          'intensityDiff': null,
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('intensity が 2.5 の場合も正しく扱われること', () {
      final json = <String, dynamic>{
        'code': 'TKY001',
        'name': '東京',
        'region': '東京都',
        'type': 'K-NET',
        'location': {'latitude': 35.7, 'longitude': 139.7},
        'intensity': 2.5,
        'intensityDiff': 0.5,
      };

      final result = WsShakeObservationPoint.fromJson(json);

      expect(result.intensity, equals(2.5));
    });
  });

  // ---------------------------------------------------------------------------
  // 2. WsSnapshotShakeEntry の points フィールド
  // ---------------------------------------------------------------------------
  group('WsSnapshotShakeEntry.points', () {
    test('points が含まれるスナップショットエントリを正しくパースできること', () {
      final json = <String, dynamic>{
        'eventId': 'shake-snap-1',
        'createdAt': '2025-04-01T00:00:00.000Z',
        'level': 'Strong',
        'changeReasons': <dynamic>[],
        'isReplay': false,
        'pointCount': 1,
        'region': {
          'topLeft': {'latitude': 36.0, 'longitude': 139.0},
          'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
        },
        'points': [
          {
            'code': 'KNG001',
            'name': '横浜',
            'region': '神奈川',
            'type': 'K-NET',
            'location': {'latitude': 35.5, 'longitude': 139.7},
            'intensity': 2.5,
            'intensityDiff': 0.3,
          },
        ],
      };

      final result = WsSnapshotShakeEntry.fromJson(json);

      expect(result.points, hasLength(1));
      expect(result.points[0].code, equals('KNG001'));
      expect(result.points[0].name, equals('横浜'));
      expect(result.points[0].location.latitude, equals(35.5));
      expect(result.points[0].location.longitude, equals(139.7));
      expect(result.points[0].intensity, equals(2.5));
      expect(result.points[0].intensityDiff, equals(0.3));
    });

    test('WsMessage.snapshot に points 付きの shakes エントリが含まれていてもパースできること', () {
      final json = <String, dynamic>{
        'type': 'snapshot',
        'data': {
          'revision': 5,
          'updatedAt': '2025-04-01T00:00:00.000Z',
          'shakes': [
            {
              'eventId': 'shake-snap-2',
              'createdAt': '2025-04-01T00:00:00.000Z',
              'level': 'Medium',
              'changeReasons': <dynamic>[],
              'isReplay': false,
              'pointCount': 2,
              'region': {
                'topLeft': {'latitude': 36.0, 'longitude': 139.0},
                'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
              },
              'points': [
                {
                  'code': 'OSK001',
                  'name': '大阪',
                  'region': '大阪府',
                  'type': 'K-NET',
                  'location': {'latitude': 34.7, 'longitude': 135.5},
                  'intensity': null,
                  'intensityDiff': 0.2,
                },
              ],
            },
          ],
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsSnapshotMessage>());
      final snapshot = result as WsSnapshotMessage;
      expect(snapshot.data.shakes, hasLength(1));
      final entry = snapshot.data.shakes.first;
      expect(entry.points, hasLength(1));
      expect(entry.points[0].code, equals('OSK001'));
      expect(entry.points[0].intensity, isNull);
    });

    test('points 省略時は空リストになること', () {
      final json = <String, dynamic>{
        'eventId': 'shake-1',
        'createdAt': '2025-01-15T12:00:00.000Z',
        'level': 'Weak',
        'isReplay': false,
        'pointCount': 2,
        'region': {
          'topLeft': {'latitude': 36.0, 'longitude': 139.0},
          'bottomRight': {'latitude': 35.5, 'longitude': 140.0},
        },
      };

      final result = WsSnapshotShakeEntry.fromJson(json);

      expect(result.points, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // 5. WsShakeObservationPoint.toJson — ラウンドトリップ
  // ---------------------------------------------------------------------------
  group('WsShakeObservationPoint.toJson — ラウンドトリップ', () {
    test('intensity あり: toJson した結果がスカラーフィールドで元の JSON と一致すること', () {
      final originalJson = <String, dynamic>{
        'code': 'KNG001',
        'name': '横浜',
        'region': '神奈川',
        'type': 'K-NET',
        'location': {'latitude': 35.5, 'longitude': 139.7},
        'intensity': 2.5,
        'intensityDiff': 0.3,
      };

      final object = WsShakeObservationPoint.fromJson(originalJson);
      final roundTripped = object.toJson();

      expect(roundTripped['code'], equals('KNG001'));
      expect(roundTripped['name'], equals('横浜'));
      expect(roundTripped['region'], equals('神奈川'));
      expect(roundTripped['type'], equals('K-NET'));
      expect(roundTripped['intensity'], equals(2.5));
      expect(roundTripped['intensityDiff'], equals(0.3));
      // location は WsShakeObservationLocation インスタンスとして埋め込まれている
      final loc = roundTripped['location'] as WsShakeObservationLocation;
      expect(loc.latitude, equals(35.5));
      expect(loc.longitude, equals(139.7));
    });

    test('intensity null: toJson した結果の intensity が null であること', () {
      final originalJson = <String, dynamic>{
        'code': 'OSK001',
        'name': '大阪',
        'region': '大阪府',
        'type': 'KiK-net',
        'location': {'latitude': 34.7, 'longitude': 135.5},
        'intensity': null,
        'intensityDiff': -0.1,
      };

      final object = WsShakeObservationPoint.fromJson(originalJson);
      final roundTripped = object.toJson();

      expect(roundTripped['intensity'], isNull);
      expect(roundTripped['intensityDiff'], equals(-0.1));
    });

    test('fromJson したオブジェクトを toJson すると再度 fromJson できること', () {
      final json = <String, dynamic>{
        'code': 'TKY001',
        'name': '東京',
        'region': '東京都',
        'type': 'K-NET',
        'location': {'latitude': 35.7, 'longitude': 139.7},
        'intensity': 1.2,
        'intensityDiff': 0.0,
      };

      final first = WsShakeObservationPoint.fromJson(json);
      // toJson の location は WsShakeObservationLocation なので
      // そのままでは fromJson に渡せない。location.toJson() で変換する。
      final serialized = first.toJson();
      final locationObj = serialized['location'] as WsShakeObservationLocation;
      serialized['location'] = locationObj.toJson();

      final second = WsShakeObservationPoint.fromJson(serialized);

      expect(second, equals(first));
    });
  });
}
