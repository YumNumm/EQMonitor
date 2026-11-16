import 'package:shake_eew_correlator/shake_eew_correlator.dart';
import 'package:test/test.dart';

void main() {
  // eqmonitor-backend の event-correlator のテストと同じ走時表。
  final table = TravelTimeTable(
    entries: const [
      TravelTimeEntry(depth: 0, distance: 0, pSeconds: 0, sSeconds: 0),
      TravelTimeEntry(depth: 0, distance: 10, pSeconds: 1.5, sSeconds: 2.6),
      TravelTimeEntry(depth: 0, distance: 50, pSeconds: 6.5, sSeconds: 11.3),
      TravelTimeEntry(depth: 0, distance: 100, pSeconds: 12.5, sSeconds: 21.8),
      TravelTimeEntry(depth: 0, distance: 500, pSeconds: 58, sSeconds: 101),
      TravelTimeEntry(depth: 10, distance: 0, pSeconds: 1.4, sSeconds: 2.5),
      TravelTimeEntry(depth: 10, distance: 10, pSeconds: 2, sSeconds: 3.5),
      TravelTimeEntry(depth: 10, distance: 50, pSeconds: 7, sSeconds: 12.2),
      TravelTimeEntry(depth: 10, distance: 100, pSeconds: 13, sSeconds: 22.5),
      TravelTimeEntry(
        depth: 10,
        distance: 500,
        pSeconds: 58.5,
        sSeconds: 101.5,
      ),
      TravelTimeEntry(depth: 30, distance: 0, pSeconds: 4.2, sSeconds: 7.3),
      TravelTimeEntry(depth: 30, distance: 10, pSeconds: 4.5, sSeconds: 7.8),
      TravelTimeEntry(depth: 30, distance: 50, pSeconds: 8.5, sSeconds: 14.8),
      TravelTimeEntry(depth: 30, distance: 100, pSeconds: 14.5, sSeconds: 25.2),
      TravelTimeEntry(depth: 30, distance: 500, pSeconds: 60, sSeconds: 104),
    ],
  );
  final correlator = ShakeEewCorrelator(travelTimeTable: table);

  CorrelationEew eew({
    String eventId = '20240101120000',
    bool isCancel = false,
    DateTime? reportTime,
  }) => CorrelationEew(
    eventId: eventId,
    serialNo: 1,
    originTime: DateTime.utc(2024, 1, 1, 12),
    reportTime: reportTime ?? DateTime.utc(2024, 1, 1, 12, 0, 5),
    latitude: 35,
    longitude: 135,
    depth: 10,
    magnitude: 6,
    isCancel: isCancel,
  );

  ShakeObservation shake({
    required DateTime createdAt,
    bool isBootstrap = false,
  }) => ShakeObservation(
    eventId: 'shake-001',
    createdAt: createdAt,
    isBootstrap: isBootstrap,
    points: const [
      ShakeObservationPoint(
        latitude: 35.1,
        longitude: 135.1,
        intensity: 5,
        arv: 1,
      ),
      ShakeObservationPoint(
        latitude: 35.15,
        longitude: 135.15,
        intensity: 4.5,
        arv: 1.2,
      ),
    ],
  );

  CorrelationCandidate candidate({
    required String eewEventId,
    double score = 0.5,
    int matchedPointCount = 1,
    double? averageTimeDiff = 1,
    DateTime? eewReportTime,
    bool isCorrelated = true,
  }) => CorrelationCandidate(
    eewEventId: eewEventId,
    eewSerialNo: 1,
    eewReportTime: eewReportTime ?? DateTime.utc(2024, 1, 1, 12, 0, 5),
    shakeEventId: 'shake-001',
    isCorrelated: isCorrelated,
    score: score,
    matchedPointCount: matchedPointCount,
    eligiblePointCount: 2,
    totalPointCount: 2,
    averageTimeDiff: averageTimeDiff,
    averageIntensityDiff: 0,
  );

  group('TravelTimeTable', () {
    test('距離と深さの双方向に線形補間すること', () {
      final time = table.lookup(depth: 5, distance: 30);

      expect(time.pSeconds, closeTo((4 + 4.5) / 2, 1e-9));
      expect(time.sSeconds, closeTo((6.95 + 7.85) / 2, 1e-9));
    });

    test('範囲外は端の値を使うこと', () {
      expect(table.lookup(depth: 100, distance: 1000).pSeconds, 60);
      expect(table.lookup(depth: -1, distance: -1).sSeconds, 0);
    });
  });

  group('SiMidorikawaIntensityEstimator', () {
    const estimator = SiMidorikawaIntensityEstimator();

    test('backend と同じ予測震度になること', () {
      final intensity = estimator.estimate(
        hypocenterLatitude: 32.7,
        hypocenterLongitude: 130.8,
        depth: 10,
        magnitude: 3.1,
        latitude: 32.6345,
        longitude: 130.7521,
        arv: 1.25,
      );

      expect(intensity, closeTo(1.8544, 1e-3));
    });

    test('無効な地盤増幅率は 1 として扱うこと', () {
      double estimate(double? arv) => estimator.estimate(
        hypocenterLatitude: 35,
        hypocenterLongitude: 135,
        depth: 10,
        magnitude: 6,
        latitude: 35.1,
        longitude: 135.1,
        arv: arv,
      );

      expect(estimate(null), estimate(1));
      expect(estimate(0), estimate(1));
      expect(estimate(double.nan), estimate(1));
      expect(estimate(2) - estimate(1), closeTo(1.72 * 0.30103, 1e-5));
    });
  });

  group('ShakeEewCorrelator', () {
    test('本番で観測した熊本のイベントが結合されること', () {
      final result = correlator.correlate(
        eews: [
          CorrelationEew(
            eventId: '20260728193304',
            serialNo: 1,
            originTime: DateTime.utc(2026, 7, 28, 10, 33, 2),
            reportTime: DateTime.utc(2026, 7, 28, 10, 33, 4),
            latitude: 32.7,
            longitude: 130.8,
            depth: 10,
            magnitude: 3.1,
            isCancel: false,
          ),
        ],
        shake: ShakeObservation(
          eventId: '0e99eb5f-69db-412c-963a-0d440cb5b64e',
          createdAt: DateTime.utc(2026, 7, 28, 10, 33, 6),
          isBootstrap: false,
          points: const [
            ShakeObservationPoint(
              latitude: 32.6345,
              longitude: 130.7521,
              intensity: 2.346,
              arv: 1.25,
            ),
          ],
        ),
      );

      expect(result?.eewEventId, '20260728193304');
      expect(result?.matchedPointCount, 1);
      expect(result?.eligiblePointCount, 1);
      expect(result?.score, 1);
    });

    test('取消された EEW は対象外とすること', () {
      final observation = shake(createdAt: DateTime.utc(2024, 1, 1, 12, 0, 10));

      expect(
        correlator.correlate(eews: [eew()], shake: observation)?.eewEventId,
        '20240101120000',
      );
      expect(
        correlator.correlate(eews: [eew(isCancel: true)], shake: observation),
        isNull,
      );
    });

    test('P 波到達より前の検知は結合しないこと', () {
      final result = correlator.check(
        eew: eew(),
        shake: shake(createdAt: DateTime.utc(2024, 1, 1, 12, 0, 1)),
      );

      expect(result.isCorrelated, isFalse);
      expect(result.eligiblePointCount, 0);
    });

    test('S 波到達から 30 秒を超えた検知は結合しないこと', () {
      final result = correlator.check(
        eew: eew(),
        shake: shake(createdAt: DateTime.utc(2024, 1, 1, 12, 10)),
      );

      expect(result.isCorrelated, isFalse);
      expect(result.eligiblePointCount, 0);
      expect(result.totalPointCount, 2);
    });

    test('平常値との差で検知したイベントは時間条件の上限を適用しないこと', () {
      final result = correlator.check(
        eew: eew(),
        shake: shake(
          createdAt: DateTime.utc(2024, 1, 1, 12, 2),
          isBootstrap: true,
        ),
      );

      expect(result.eligiblePointCount, 2);
      expect(result.isCorrelated, isTrue);
    });

    test('平常値との差で検知したイベントでも P 波到達より前は結合しないこと', () {
      final result = correlator.check(
        eew: eew(),
        shake: shake(
          createdAt: DateTime.utc(2024, 1, 1, 12, 0, 1),
          isBootstrap: true,
        ),
      );

      expect(result.isCorrelated, isFalse);
    });

    test('震度が欠測の観測点だけの場合は結合しないこと', () {
      final result = correlator.check(
        eew: eew(),
        shake: ShakeObservation(
          eventId: 'shake-001',
          createdAt: DateTime.utc(2024, 1, 1, 12, 0, 10),
          isBootstrap: false,
          points: const [
            ShakeObservationPoint(
              latitude: 35.1,
              longitude: 135.1,
              intensity: null,
              arv: 1,
            ),
          ],
        ),
      );

      expect(result.isCorrelated, isFalse);
      expect(result.eligiblePointCount, 0);
    });
  });

  group('selectBest', () {
    test('スコア、一致数、時間差、発表時刻、イベント ID の順で選ぶこと', () {
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'low'),
          candidate(eewEventId: 'high', score: 0.9),
        ])?.eewEventId,
        'high',
      );
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'few'),
          candidate(eewEventId: 'many', matchedPointCount: 3),
        ])?.eewEventId,
        'many',
      );
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'far', averageTimeDiff: -8),
          candidate(eewEventId: 'near', averageTimeDiff: 2),
          candidate(eewEventId: 'unknown', averageTimeDiff: null),
        ])?.eewEventId,
        'near',
      );
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'old'),
          candidate(
            eewEventId: 'new',
            eewReportTime: DateTime.utc(2024, 1, 1, 12, 0, 9),
          ),
        ])?.eewEventId,
        'new',
      );
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'b'),
          candidate(eewEventId: 'a'),
        ])?.eewEventId,
        'a',
      );
    });

    test('成立した候補が無い場合は null を返すこと', () {
      expect(
        correlator.selectBest([
          candidate(eewEventId: 'a', isCorrelated: false),
        ]),
        isNull,
      );
    });
  });
}
