import 'dart:io';

import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';
import 'package:test/test.dart';

import 'kiknet_ascii_builder.dart';

void main() {
  const parser = KnetAsciiParser();
  const assembler = KyoshinWaveformRecordAssembler();

  List<KyoshinRawChannel> knetFixture() => [
    for (final extension in ['UD', 'NS', 'EW'])
      parser.parse(
        File('test/fixtures/EHM0012408081643.$extension').readAsStringSync(),
      ),
  ];

  group('KyoshinWaveformRecordAssembler', () {
    test('観測点ごとに成分の順で1つの記録にまとめること', () {
      final records = assembler.assemble(knetFixture());

      expect(records, hasLength(1));
      final record = records.single;
      expect(record.stationCode, 'EHM001');
      expect(record.startTime, DateTime.utc(2024, 8, 8, 7, 44, 15));
      expect(record.samplingRate, 100);
      expect(record.duration, const Duration(seconds: 71));
      expect(record.channels.map((c) => c.component), [
        KyoshinWaveformComponent.ns,
        KyoshinWaveformComponent.ew,
        KyoshinWaveformComponent.ud,
      ]);
      expect(record.threeComponents(.surface), isNotNull);
      expect(record.threeComponents(.borehole), isNull);
    });

    test('KiK-net は地表と地中の3成分をそれぞれ取り出せること', () {
      final record = assembler.assemble([
        for (var direction = 6; direction >= 1; direction--)
          parser.parse(
            KiknetAsciiBuilder(
              stationCode: 'FKSH18',
              direction: '$direction',
            ).build(),
          ),
      ]).single;

      final surface = record.threeComponents(.surface);
      final borehole = record.threeComponents(.borehole);
      expect(surface?.ns.component, KyoshinWaveformComponent.ns2);
      expect(surface?.ud.component, KyoshinWaveformComponent.ud2);
      expect(borehole?.ew.component, KyoshinWaveformComponent.ew1);
      expect(record.channelOf(.ud1)?.accelerationGal, hasLength(8));
    });

    test('記録開始時刻が異なれば別の記録にすること', () {
      final records = assembler.assemble([
        parser.parse(
          const KiknetAsciiBuilder(
            stationCode: 'FKSH18',
            direction: '4',
          ).build(),
        ),
        parser.parse(
          const KiknetAsciiBuilder(
            stationCode: 'FKSH18',
            direction: '4',
            recordTime: '2026/11/06 19:45:00',
          ).build(),
        ),
      ]);

      expect(records, hasLength(2));
    });

    test('実記録からリアルタイム震度を求められること', () {
      final record = assembler.assemble(knetFixture()).single;
      final components = record.threeComponents(.surface);
      expect(components, isNotNull);
      if (components == null) {
        return;
      }

      final series = const RealtimeIntensitySeriesCalculator().calculate(
        startTime: record.startTime,
        samplingRate: record.samplingRate,
        ns: components.ns.accelerationGal,
        ew: components.ew.accelerationGal,
        ud: components.ud.accelerationGal,
      );

      expect(series.values, hasLength(71));
      expect(series.maxValue, 1.6);
    });
  });
}
