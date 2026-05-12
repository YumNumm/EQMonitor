import 'dart:io';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = KnetCsvParser();

  group('KnetCsvParser', () {
    group('合成フィクスチャ', () {
      test('フィクスチャファイルをパースできる', () {
        final file = File('test/fixtures/sample_knet.csv');
        final source = file.readAsStringSync();
        final record = parser.parse(source);

        expect(record.earthquakeInfo, isNotNull);
        expect(record.earthquakeInfo!.originTime.year, 2011);
        expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.001));
        expect(record.earthquakeInfo!.longitude, closeTo(142.860, 0.001));
        expect(record.earthquakeInfo!.depthKm, closeTo(24.0, 0.01));
        expect(record.earthquakeInfo!.magnitude, closeTo(9.0, 0.01));

        expect(record.stationInfo, isNotNull);
        expect(record.stationInfo!.stationCode, 'IBR011');
        expect(record.stationInfo!.latitude, closeTo(36.1256, 0.0001));
        expect(record.stationInfo!.longitude, closeTo(140.0901, 0.0001));
        expect(record.stationInfo!.heightM, closeTo(27.0, 0.1));

        expect(record.channelDirections.length, 3);
        expect(record.channelDirections[0], KnetChannelDirection.ns);
        expect(record.channelDirections[1], KnetChannelDirection.ew);
        expect(record.channelDirections[2], KnetChannelDirection.ud);

        expect(record.dataPoints.isNotEmpty, isTrue);
        expect(record.dataPoints.first.accelerationsGal.length, 3);
        expect(
          record.dataPoints.first.accelerationsGal[0],
          closeTo(-0.73, 0.001),
        );

        // サンプリング周波数
        expect(record.samplingFrequencyHz, closeTo(100.0, 0.1));

        // 計測時間
        expect(record.durationTimeSec, closeTo(300.0, 0.1));
      });

      test('小数秒を持つ時刻をパースできる', () {
        const csv = '''
#K-NET CSV
#Event
#OriginTime,Latitude,Longitude,Depth(km),Magnitude
#2011/03/11 14:46:00,38.103,142.860,24,9.0
#Station
#Code,Latitude,Longitude,Height(m)
#IBR011,36.1256,140.0901,27
#Record
#SamplingFrequency(Hz)
#100
#DurationTime(s)
#300
#Offset
#N-S(gal),E-W(gal),U-D(gal)
#0.00,0.00,0.00
#Time,RelativeTime(s),N-S(gal),E-W(gal),U-D(gal)
2011/03/11 14:48:19.00,0.00,-0.73,0.61,-0.61
2011/03/11 14:48:19.01,0.01,-0.73,0.61,-0.61
''';
        final record = parser.parse(csv);
        expect(record.dataPoints.first.time.second, 19);
        expect(record.dataPoints.first.time.millisecond, 0);
        expect(record.dataPoints[1].time.millisecond, 10);
      });
    });

    group('実ファイル（防災科研ダウンロードデータ）', () {
      final realDir = Directory('test/fixtures/real');
      final hasRealFiles =
          realDir.existsSync() &&
          realDir.listSync().whereType<File>().isNotEmpty;

      test(
        '2011年東北地方太平洋沖地震 AIC001 CSV をパースできる',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に実ファイルがありません',
        () {
          final file = File('test/fixtures/real/AIC0011103111446.csv');
          if (!file.existsSync()) {
            markTestSkipped('AIC0011103111446.csv が存在しません');
            return;
          }
          final source = file.readAsStringSync();
          final record = parser.parse(source);

          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2011);
          expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.01));

          expect(record.stationInfo, isNotNull);
          expect(record.stationInfo!.stationCode, 'AIC001');

          expect(record.channelDirections.length, 3);
          expect(record.dataPoints.isNotEmpty, isTrue);
          // 30000データポイント = 300秒 × 100Hz
          expect(record.dataPoints.length, greaterThan(10000));
          expect(record.samplingFrequencyHz, closeTo(100.0, 1.0));
        },
      );

      test(
        '2024年日向灘地震 EHM001 CSV をパースできる',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に実ファイルがありません',
        () {
          final file = File('test/fixtures/real/EHM0012408081643.csv');
          if (!file.existsSync()) {
            markTestSkipped('EHM0012408081643.csv が存在しません');
            return;
          }
          final source = file.readAsStringSync();
          final record = parser.parse(source);

          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2024);
          expect(record.earthquakeInfo!.magnitude, closeTo(7.1, 0.1));

          expect(record.stationInfo, isNotNull);
          expect(record.stationInfo!.stationCode, 'EHM001');
          expect(record.dataPoints.isNotEmpty, isTrue);
          expect(record.samplingFrequencyHz, closeTo(100.0, 1.0));
        },
      );
    });
  });
}
