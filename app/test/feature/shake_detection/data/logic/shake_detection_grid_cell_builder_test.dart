import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_grid_cell_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final builder = ShakeDetectionGridCellBuilder();

  group('levelFromIntensity', () {
    test('検知エンジンと同じ閾値でレベルへ変換する', () {
      expect(builder.levelFromIntensity(-2), ShakeDetectionLevel.weaker);
      expect(builder.levelFromIntensity(0.49), ShakeDetectionLevel.weaker);
      expect(builder.levelFromIntensity(0.5), ShakeDetectionLevel.weak);
      expect(builder.levelFromIntensity(2.49), ShakeDetectionLevel.weak);
      expect(builder.levelFromIntensity(2.5), ShakeDetectionLevel.medium);
      expect(builder.levelFromIntensity(3.49), ShakeDetectionLevel.medium);
      expect(builder.levelFromIntensity(3.5), ShakeDetectionLevel.strong);
      expect(builder.levelFromIntensity(5.49), ShakeDetectionLevel.strong);
      expect(builder.levelFromIntensity(5.5), ShakeDetectionLevel.stronger);
    });
  });

  group('build', () {
    test('観測点がない場合は空リストを返す', () {
      expect(builder.build(points: const []), isEmpty);
    });

    test('地図上で正方形になる0.5度幅のグリッドに観測点を集約し最大レベルでセルを返す', () {
      final cells = builder.build(
        points: [
          _point(lat: 35.1, lng: 139.1, intensity: 1),
          _point(lat: 35.4, lng: 139.4, intensity: 5),
          _point(lat: 35.6, lng: 139.6, intensity: -2),
        ],
      );

      expect(cells, hasLength(2));

      final strongCell = cells.singleWhere(
        (cell) => cell.minLng == 139.0,
      );
      expect(strongCell.level, ShakeDetectionLevel.strong);
      expect(strongCell.maxLng, 139.5);
      expect(strongCell.minLat, closeTo(35.078, 1e-3));
      expect(strongCell.maxLat, closeTo(35.4861, 1e-3));

      final weakerCell = cells.singleWhere(
        (cell) => cell.minLng == 139.5,
      );
      expect(weakerCell.level, ShakeDetectionLevel.weaker);
      expect(weakerCell.minLat, closeTo(35.4861, 1e-3));
    });

    test('intensity が null の観測点は Weaker として扱う', () {
      final cells = builder.build(points: [_point(lat: 35.1, lng: 139.1)]);

      expect(cells, hasLength(1));
      expect(cells.single.level, ShakeDetectionLevel.weaker);
    });

    test('同一セル内は最大レベルを採用する', () {
      final cells = builder.build(
        points: [
          _point(lat: 35.1, lng: 139.05, intensity: -2),
          _point(lat: 35.2, lng: 139.1, intensity: 6),
          _point(lat: 35.3, lng: 139.15, intensity: 1),
        ],
      );

      expect(cells, hasLength(1));
      expect(cells.single.level, ShakeDetectionLevel.stronger);
      expect(cells.single.minLat, closeTo(35.078, 1e-3));
      expect(cells.single.minLng, 139.0);
    });

    test('セルはレベル昇順（高レベルが末尾）で返す', () {
      final cells = builder.build(
        points: [
          _point(lat: 37.4, lng: 139.4, intensity: 6),
          _point(lat: 35.1, lng: 139.1, intensity: -2),
          _point(lat: 36.1, lng: 140.1, intensity: 3),
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
          [_point(lat: 35.1, lng: 139.1, intensity: 6)],
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

ShakeDetectionPoint _point({
  required double lat,
  required double lng,
  double? intensity,
}) => ShakeDetectionPoint(
  code: 'code',
  name: 'name',
  latitude: lat,
  longitude: lng,
  intensity: intensity,
  intensityDiff: 0,
  prefectureCode: null,
  regionCode: null,
);
