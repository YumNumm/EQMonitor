import 'dart:io';

import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:test/test.dart';

import 'kiknet_ascii_builder.dart';

void main() {
  const parser = KnetAsciiParser();

  KyoshinRawChannel fixture(String extension) => parser.parse(
    File('test/fixtures/EHM0012408081643.$extension').readAsStringSync(),
  );

  group('KnetAsciiParser', () {
    test('K-NET の観測点・時刻・チャンネルを読むこと', () {
      final channel = fixture('NS');

      expect(channel.stationCode, 'EHM001');
      expect(channel.stationLatitude, 33.9788);
      expect(channel.stationLongitude, 133.5494);
      expect(channel.stationHeightMeters, 25);
      expect(channel.recordTime, DateTime.utc(2024, 8, 8, 7, 44, 30));
      expect(channel.startTime, DateTime.utc(2024, 8, 8, 7, 44, 15));
      expect(channel.samplingRate, 100);
      expect(channel.component, KyoshinWaveformComponent.ns);
      expect(channel.scaleFactor, 7845 / 8223790);
      expect(channel.counts, hasLength(7100));
      expect(channel.counts.first, -144);
    });

    test('記録全長の平均値を引いた加速度の最大値がヘッダの最大加速度と一致すること', () {
      for (final extension in ['NS', 'EW', 'UD']) {
        final channel = fixture(extension);
        final peak = KyoshinWaveformChannel(
          component: channel.component,
          accelerationGal: channel.accelerationGal,
        ).peakAbsoluteGal;

        expect(
          peak,
          closeTo(channel.maxAccelerationGal, 0.0005),
          reason: extension,
        );
      }
    });

    test('KiK-net のチャンネル 1〜6 を地中・地表の成分として読むこと', () {
      final components = [
        for (var direction = 1; direction <= 6; direction++)
          parser
              .parse(
                KiknetAsciiBuilder(
                  stationCode: 'FKSH18',
                  direction: '$direction',
                ).build(),
              )
              .component,
      ];

      expect(components, [
        KyoshinWaveformComponent.ns1,
        KyoshinWaveformComponent.ew1,
        KyoshinWaveformComponent.ud1,
        KyoshinWaveformComponent.ns2,
        KyoshinWaveformComponent.ew2,
        KyoshinWaveformComponent.ud2,
      ]);
    });

    test('不明なチャンネルは FormatException にすること', () {
      expect(
        () => parser.parse(
          const KiknetAsciiBuilder(
            stationCode: 'FKSH18',
            direction: 'X',
          ).build(),
        ),
        throwsFormatException,
      );
    });

    test('ヘッダが17行に満たない場合は FormatException にすること', () {
      expect(
        () => parser.parse('Origin Time       2026/11/06 19:39:00\n'),
        throwsFormatException,
      );
    });
  });
}
