import 'dart:io';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  group('KnetIntensityCalculator', () {
    test('AIC001 東北地震 (2011/03/11) の計測震度が妥当範囲内', () {
      final csvText = _loadFixture('AIC0011103111446.csv');
      final record = const KnetCsvParser().parse(csvText);

      final calc = KnetIntensityCalculator(
        samplingFrequencyHz: record.samplingFrequencyHz,
      );
      final rawInt = calc.calculate(record);

      // 愛知（名古屋近郊）は震源から約500km。気象庁発表は震度3程度。
      // フィルタ誤差を考慮して 2.0〜4.4 の範囲を許容する。
      expect(rawInt, greaterThanOrEqualTo(2.0));
      expect(rawInt, lessThan(4.5));
    });

    // 回帰テスト: 100Hz fixture の計測震度値が修正前後で変化しないことを担保する。
    // 100Hz では floor(0.3×100)=30 となり、修正前の `composites[29]`（30番目）と
    // 一致するため、本テストの固定値は変わってはならない。
    test('AIC001 100Hz fixture の計測震度値が修正後も不変（回帰テスト）', () {
      final csvText = _loadFixture('AIC0011103111446.csv');
      final record = const KnetCsvParser().parse(csvText);

      expect(record.samplingFrequencyHz, 100);

      final calc = KnetIntensityCalculator(
        samplingFrequencyHz: record.samplingFrequencyHz,
      );

      expect(calc.calculate(record), closeTo(3.4, 1e-9));
    });

    test('震度ラベル変換が正しい', () {
      expect(KnetIntensityCalculator.toJmaLabel(0), '0');
      expect(KnetIntensityCalculator.toJmaLabel(0.4), '0');
      expect(KnetIntensityCalculator.toJmaLabel(0.5), '1');
      expect(KnetIntensityCalculator.toJmaLabel(1.4), '1');
      expect(KnetIntensityCalculator.toJmaLabel(1.5), '2');
      expect(KnetIntensityCalculator.toJmaLabel(2.4), '2');
      expect(KnetIntensityCalculator.toJmaLabel(2.5), '3');
      expect(KnetIntensityCalculator.toJmaLabel(3.4), '3');
      expect(KnetIntensityCalculator.toJmaLabel(3.5), '4');
      expect(KnetIntensityCalculator.toJmaLabel(4.4), '4');
      expect(KnetIntensityCalculator.toJmaLabel(4.5), '5弱');
      expect(KnetIntensityCalculator.toJmaLabel(4.9), '5弱');
      expect(KnetIntensityCalculator.toJmaLabel(5), '5強');
      expect(KnetIntensityCalculator.toJmaLabel(5.4), '5強');
      expect(KnetIntensityCalculator.toJmaLabel(5.5), '6弱');
      expect(KnetIntensityCalculator.toJmaLabel(5.9), '6弱');
      expect(KnetIntensityCalculator.toJmaLabel(6), '6強');
      expect(KnetIntensityCalculator.toJmaLabel(6.4), '6強');
      expect(KnetIntensityCalculator.toJmaLabel(6.5), '7');
      expect(KnetIntensityCalculator.toJmaLabel(7), '7');
    });

    test('サンプル数が30未満の場合は 0.0 を返す', () {
      final record = KnetCsvRecord(
        earthquakeInfo: null,
        stationInfo: null,
        offsets: [],
        channelDirections: const [
          KnetChannelDirection.ns,
          KnetChannelDirection.ew,
          KnetChannelDirection.ud,
        ],
        dataPoints: List.generate(
          10,
          (i) => KnetCsvDataPoint(
            time: DateTime(2024),
            relativeTimeSec: i * 0.01,
            accelerationsGal: [1.0, 1.0, 1.0],
          ),
        ),
        samplingFrequencyHz: 100,
        durationTimeSec: 0.1,
        networkType: KnetNetworkType.knet,
      );

      final calc = KnetIntensityCalculator();
      expect(calc.calculate(record), equals(0.0));
    });

    group('durationSampleCount (0.3秒窓のサンプル数)', () {
      test('floor(0.3 × サンプリング周波数) を返す', () {
        // 100Hz: floor(0.3×100)=30（従来挙動と一致）
        expect(KnetIntensityCalculator.durationSampleCount(100), 30);
        // 200Hz (KiK-net 等): floor(0.3×200)=60
        expect(KnetIntensityCalculator.durationSampleCount(200), 60);
        // 50Hz: floor(0.3×50)=15
        expect(KnetIntensityCalculator.durationSampleCount(50), 15);
      });

      test('秒数を明示しても 100Hz では 30 になる', () {
        // 秒数を明示的に指定しても既定値と同じ結果になることを確認する。
        // ignore: avoid_redundant_argument_values
        expect(KnetIntensityCalculator.durationSampleCount(100, 0.3), 30);
      });
    });

    test('200Hz でサンプル数が窓サイズ(60)未満なら 0.0 を返す（境界）', () {
      // 200Hz では 0.3秒窓 = 60サンプル必要。
      // 40サンプルしか無い場合、合成波形長は 60 未満となりデータ不足扱い。
      // 修正前は窓サイズが 30 固定だったため値を返していた箇所。
      final record = KnetCsvRecord(
        earthquakeInfo: null,
        stationInfo: null,
        offsets: [],
        channelDirections: const [
          KnetChannelDirection.ns,
          KnetChannelDirection.ew,
          KnetChannelDirection.ud,
        ],
        dataPoints: List.generate(
          40,
          (i) => KnetCsvDataPoint(
            time: DateTime(2024),
            relativeTimeSec: i * 0.005,
            accelerationsGal: [100.0, 100.0, 100.0],
          ),
        ),
        samplingFrequencyHz: 200,
        durationTimeSec: 0.2,
        networkType: KnetNetworkType.knet,
      );

      final calc = KnetIntensityCalculator(samplingFrequencyHz: 200);
      expect(calc.calculate(record), equals(0.0));
    });

    test('NS/EW/UD チャンネルが揃っていない場合は 0.0 を返す', () {
      final record = KnetCsvRecord(
        earthquakeInfo: null,
        stationInfo: null,
        offsets: [],
        channelDirections: const [KnetChannelDirection.ns],
        dataPoints: List.generate(
          100,
          (i) => KnetCsvDataPoint(
            time: DateTime(2024),
            relativeTimeSec: i * 0.01,
            accelerationsGal: [1.0],
          ),
        ),
        samplingFrequencyHz: 100,
        durationTimeSec: 1,
        networkType: KnetNetworkType.knet,
      );

      final calc = KnetIntensityCalculator();
      expect(calc.calculate(record), equals(0.0));
    });
  });
}

String _loadFixture(String filename) =>
    File('test/fixtures/real/$filename').readAsStringSync();
