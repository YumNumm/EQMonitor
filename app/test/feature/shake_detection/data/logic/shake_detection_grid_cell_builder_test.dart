import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_grid_cell_builder.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final builder = ShakeDetectionGridCellBuilder();

  group('levelFromIntensity', () {
    test('バックエンドと同じ閾値でレベルへ変換する', () {
      expect(builder.levelFromIntensity(-2), ShakeDetectionLevel.weaker);
      expect(builder.levelFromIntensity(-1), ShakeDetectionLevel.weaker);
      expect(builder.levelFromIntensity(0), ShakeDetectionLevel.weak);
      expect(builder.levelFromIntensity(0.5), ShakeDetectionLevel.weak);
      expect(builder.levelFromIntensity(0.51), ShakeDetectionLevel.medium);
      expect(builder.levelFromIntensity(2.5), ShakeDetectionLevel.medium);
      expect(builder.levelFromIntensity(2.51), ShakeDetectionLevel.strong);
      expect(builder.levelFromIntensity(4.5), ShakeDetectionLevel.strong);
      expect(builder.levelFromIntensity(4.51), ShakeDetectionLevel.stronger);
    });
  });

  group('build', () {
    test('観測点がない場合は空リストを返す', () {
      expect(builder.build(points: const []), isEmpty);
    });

    test('0.25度グリッドに観測点を集約し最大レベルでセルを返す', () {
      final cells = builder.build(
        points: [
          _point(lat: 35.1, lng: 139.1, intensity: 0),
          _point(lat: 35.2, lng: 139.2, intensity: 3),
          _point(lat: 35.4, lng: 139.4, intensity: -2),
        ],
      );

      expect(cells, hasLength(2));

      final strongCell = cells.singleWhere(
        (cell) => cell.minLat == 35.0 && cell.minLng == 139.0,
      );
      expect(strongCell.level, ShakeDetectionLevel.strong);

      final weakerCell = cells.singleWhere(
        (cell) => cell.minLat == 35.25 && cell.minLng == 139.25,
      );
      expect(weakerCell.level, ShakeDetectionLevel.weaker);
    });

    test('intensity が null の観測点は Weaker として扱う', () {
      final cells = builder.build(points: [_point(lat: 35.1, lng: 139.1)]);

      expect(cells, hasLength(1));
      expect(cells.single.level, ShakeDetectionLevel.weaker);
    });

    test('同一セル内は最大レベルを採用する', () {
      final cells = builder.build(
        points: [
          _point(lat: 35.05, lng: 139.05, intensity: -2),
          _point(lat: 35.1, lng: 139.1, intensity: 5),
          _point(lat: 35.15, lng: 139.15, intensity: 1),
        ],
      );

      expect(cells, hasLength(1));
      expect(cells.single.level, ShakeDetectionLevel.stronger);
      expect(cells.single.minLat, 35.0);
      expect(cells.single.minLng, 139.0);
    });

    test('セルはレベル昇順（高レベルが末尾）で返す', () {
      final cells = builder.build(
        points: [
          _point(lat: 35.4, lng: 139.4, intensity: 5),
          _point(lat: 35.1, lng: 139.1, intensity: -2),
          _point(lat: 36.1, lng: 140.1, intensity: 1),
        ],
      );

      expect(cells.map((c) => c.level), [
        ShakeDetectionLevel.weaker,
        ShakeDetectionLevel.medium,
        ShakeDetectionLevel.stronger,
      ]);
      expect(cells.map((c) => c.sortKey), [0, 2, 4]);
    });

    test('複数イベントをまとめてもレベル昇順になる', () {
      final cells = builder.buildFromPointGroups(
        pointGroups: [
          [_point(lat: 35.1, lng: 139.1, intensity: 5)],
          [_point(lat: 36.1, lng: 140.1, intensity: -2)],
        ],
      );

      expect(cells.map((c) => c.level), [
        ShakeDetectionLevel.weaker,
        ShakeDetectionLevel.stronger,
      ]);
    });
  });
}

Points _point({required double lat, required double lng, num? intensity}) =>
    Points(
      code: 'code',
      name: 'name',
      region: 'region',
      type: 'type',
      location: Location(latitude: lat, longitude: lng),
      intensity: intensity,
      cityCode: null,
      prefectureCode: null,
      regionCode: null,
    );
