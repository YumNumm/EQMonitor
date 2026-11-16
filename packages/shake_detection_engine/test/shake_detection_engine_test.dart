import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:test/test.dart';

void main() {
  // 緯度 0.18 度 ≒ 20 km 間隔の 5x5 格子。近傍の重み合計が十分にあり、離島扱いにならない。
  final grid = [
    for (var row = 0; row < 5; row++)
      for (var column = 0; column < 5; column++)
        ShakeStationLocation(
          latitude: 35 + row * 0.18,
          longitude: 139 + column * 0.22,
        ),
  ];
  final start = DateTime.utc(2026, 1, 1, 12);

  List<double?> uniform(double value) =>
      List<double?>.filled(grid.length, value);

  DateTime at(int seconds) => start.add(Duration(seconds: seconds));

  group('ShakeDetectionEngine', () {
    test('平常時はイベントを検知しないこと', () {
      final engine = ShakeDetectionEngine(stations: grid);
      for (var second = 0; second < 30; second++) {
        final events = engine.process(
          time: at(second),
          intensities: uniform(second.isEven ? -0.5 : -0.45),
        );
        expect(events, isEmpty);
      }
    });

    test('履歴が無い 1 フレーム目は検知せず、上昇した 2 フレーム目で検知すること', () {
      final engine = ShakeDetectionEngine(stations: grid);

      expect(engine.process(time: at(0), intensities: uniform(-0.5)), isEmpty);

      final events = engine.process(time: at(1), intensities: uniform(1.5));
      expect(events, hasLength(1));
      expect(events.single.isConfirmed, isTrue);
      expect(events.single.isBootstrap, isFalse);
      expect(events.single.level, ShakeEventLevel.medium);
      expect(events.single.points, hasLength(grid.length));
    });

    test('既に揺れている状態で開始すると、平常値が無ければ検知できないこと', () {
      final engine = ShakeDetectionEngine(stations: grid);
      for (var second = 0; second < 30; second++) {
        expect(
          engine.process(time: at(second), intensities: uniform(2)),
          isEmpty,
        );
      }
    });

    test('平常値を投入すると 1 フレーム目から検知すること', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..seedBaseline(ShakeBaseline(values: uniform(-0.5), isReliable: true));

      final events = engine.process(time: at(0), intensities: uniform(2));

      expect(events, hasLength(1));
      expect(events.single.isConfirmed, isTrue);
      expect(events.single.isBootstrap, isTrue);
      expect(events.single.createdAt, at(0));
      expect(events.single.points, hasLength(grid.length));
    });

    test('平常値と変わらない場合は 1 フレーム目でも検知しないこと', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..seedBaseline(ShakeBaseline(values: uniform(-0.5), isReliable: true));

      expect(engine.process(time: at(0), intensities: uniform(-0.4)), isEmpty);
    });

    test('平常値が窓に残る間は弱い揺れを確定せず、窓から外れた後に確定すること', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..seedBaseline(ShakeBaseline(values: uniform(-2), isReliable: true));

      var events = engine.process(time: at(0), intensities: uniform(-0.5));
      expect(events.single.level, ShakeEventLevel.weak);
      expect(events.single.isConfirmed, isFalse);

      for (var second = 1; second <= 9; second++) {
        events = engine.process(
          time: at(second),
          intensities: uniform(-0.5),
        );
      }
      expect(events.single.isConfirmed, isFalse);

      events = engine.process(time: at(10), intensities: uniform(0));
      expect(events.single.level, ShakeEventLevel.weak);
      expect(events.single.isConfirmed, isTrue);
    });

    test('平常値が窓から外れた後に作られたイベントは通常の検知として扱うこと', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..seedBaseline(ShakeBaseline(values: uniform(-0.5), isReliable: true));
      for (var second = 0; second < 15; second++) {
        expect(
          engine.process(time: at(second), intensities: uniform(-0.5)),
          isEmpty,
        );
      }

      final events = engine.process(time: at(15), intensities: uniform(1.5));

      expect(events.single.isBootstrap, isFalse);
    });

    test('1 点だけの上昇は検知しないこと', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..process(time: at(0), intensities: uniform(-0.5));
      final intensities = uniform(-0.5)..[12] = 3;

      expect(engine.process(time: at(1), intensities: intensities), isEmpty);
    });

    test('上昇が止まると有効期限の経過後にイベントが消えること', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..process(time: at(0), intensities: uniform(-0.5));
      final detected = engine.process(time: at(1), intensities: uniform(1.5));
      expect(detected.single.expiresAt, at(41));

      // 平常値が窓に残る t=9 までは上昇中として検知が続き、期限が延びる。
      var events = detected;
      for (var second = 2; second <= 49; second++) {
        events = engine.process(time: at(second), intensities: uniform(1.5));
      }
      expect(events.single.expiresAt, at(49));

      events = engine.process(time: at(50), intensities: uniform(1.5));
      expect(events, isEmpty);
    });

    test('弱い揺れは観測点数が確定条件を超えるまで未確定とすること', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..process(time: at(0), intensities: uniform(-2));
      final intensities = uniform(-2);
      for (final index in [0, 1, 5]) {
        intensities[index] = -1.5;
      }

      final events = engine.process(time: at(1), intensities: intensities);

      expect(events, hasLength(1));
      expect(events.single.level, ShakeEventLevel.weaker);
      expect(events.single.isConfirmed, isFalse);
    });

    test('離れた 2 つのイベントは統合距離内であれば 1 つにまとめること', () {
      final far = [
        ...grid,
        for (final location in grid)
          ShakeStationLocation(
            latitude: location.latitude + 1.5,
            longitude: location.longitude,
          ),
      ];
      final engine = ShakeDetectionEngine(stations: far)
        ..process(
          time: at(0),
          intensities: List<double?>.filled(far.length, -0.5),
        );

      final events = engine.process(
        time: at(1),
        intensities: List<double?>.filled(far.length, 1.5),
      );

      expect(events, hasLength(1));
      expect(events.single.points, hasLength(far.length));
      expect(events.single.mergedEvents, hasLength(1));
    });

    test('5 秒以上の時刻の飛びはコールドスタート扱いにすること', () {
      final engine = ShakeDetectionEngine(stations: grid);
      expect(engine.requiresColdStart(at(0)), isTrue);

      engine.process(time: at(0), intensities: uniform(-0.5));

      expect(engine.requiresColdStart(at(1)), isFalse);
      expect(engine.requiresColdStart(at(4)), isFalse);
      expect(engine.requiresColdStart(at(5)), isTrue);
      expect(engine.requiresColdStart(at(-10)), isTrue);
    });

    test('reset で履歴とイベントを破棄すること', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..process(time: at(0), intensities: uniform(-0.5))
        ..process(time: at(1), intensities: uniform(1.5))
        ..reset();

      expect(engine.requiresColdStart(at(2)), isTrue);
      expect(engine.process(time: at(2), intensities: uniform(1.5)), isEmpty);
    });
  });

  group('履歴の作り直し', () {
    test('作り直す前のイベントと観測点が重なるイベントに ID を引き継ぐこと', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..seedBaseline(ShakeBaseline(values: uniform(-0.5), isReliable: true));
      final before = engine.process(time: at(0), intensities: uniform(2));

      engine
        ..reset()
        ..seedBaseline(ShakeBaseline(values: uniform(-0.5), isReliable: true))
        ..process(time: at(-2), intensities: uniform(1))
        ..process(time: at(-1), intensities: uniform(1.5));
      final rebuilt = engine.process(time: at(0), intensities: uniform(2));
      expect(rebuilt.single.id, isNot(before.single.id));

      engine.adoptEventIds(before);

      expect(engine.events.single.id, before.single.id);
      expect(engine.events.single.createdAt, at(-2));
    });

    test('重なる観測点が無いイベントの ID は変えないこと', () {
      final engine = ShakeDetectionEngine(stations: grid)
        ..process(time: at(0), intensities: uniform(-0.5));
      final current = engine.process(time: at(1), intensities: uniform(1.5));

      engine.adoptEventIds([
        ShakeEventSnapshot(
          id: 'other',
          createdAt: at(0),
          updatedAt: at(0),
          expiresAt: at(40),
          level: ShakeEventLevel.medium,
          isConfirmed: true,
          isBootstrap: false,
          minLatitude: 0,
          maxLatitude: 0,
          minLongitude: 0,
          maxLongitude: 0,
          points: const [
            ShakeEventPointSnapshot(
              stationIndex: 999,
              intensity: 1,
              intensityDiff: 1,
            ),
          ],
          mergedEvents: const [],
        ),
      ]);

      expect(engine.events.single.id, current.single.id);
    });
  });

  group('ShakeDetectionParameters', () {
    test('すべての値が等しい場合だけ等価であること', () {
      expect(
        const ShakeDetectionParameters(),
        const ShakeDetectionParameters(maxSearchDistance: 60),
      );
      expect(
        const ShakeDetectionParameters(),
        isNot(const ShakeDetectionParameters(minDetectionDiff: 0.3)),
      );
      expect(
        const ShakeDetectionParameters(),
        isNot(const ShakeDetectionParameters(weakSeconds: 31)),
      );
    });
  });

  group('離島の単独検知', () {
    const island = [ShakeStationLocation(latitude: 27, longitude: 142)];

    test('単独で 1.4 以上上昇すると検知すること', () {
      final engine = ShakeDetectionEngine(stations: island)
        ..process(time: at(0), intensities: [-0.5]);

      final events = engine.process(time: at(1), intensities: [1]);

      expect(events, hasLength(1));
      expect(events.single.isConfirmed, isTrue);
    });

    test('実測の平常値であれば 1 フレーム目から検知すること', () {
      final engine = ShakeDetectionEngine(stations: island)
        ..seedBaseline(const ShakeBaseline(values: [-0.5], isReliable: true));

      expect(engine.process(time: at(0), intensities: [1]), hasLength(1));
    });

    test('固定値の平常値では窓内の単独検知を行わないこと', () {
      final engine = ShakeDetectionEngine(stations: island)
        ..seedBaseline(ShakeBaseline.constant(stationCount: 1, value: -0.5));

      expect(engine.process(time: at(0), intensities: [1]), isEmpty);
    });
  });

  group('ShakeBaseline', () {
    test('観測点ごとの中央値を平常値とし、欠測のみの観測点は null とすること', () {
      final baseline = ShakeBaseline.fromFrames([
        [0.1, 2.0, null, null],
        [0.3, 0.2, 0.5, null],
        [0.2, 0.1, 0.4, null],
      ]);

      expect(baseline.values, [0.2, 0.2, 0.4, null]);
      expect(baseline.isReliable, isTrue);
    });
  });
}
