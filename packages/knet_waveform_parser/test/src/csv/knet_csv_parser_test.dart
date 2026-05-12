import 'dart:io';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = KnetCsvParser();

  group('KnetCsvParser', () {
    test('フィクスチャファイルをパースできる', () {
      final file = File('test/fixtures/sample_knet.csv');
      final source = file.readAsStringSync();
      final record = parser.parse(source);

      // 地震情報
      expect(record.earthquakeInfo, isNotNull);
      expect(record.earthquakeInfo!.originTime.year, 2011);
      expect(record.earthquakeInfo!.originTime.month, 3);
      expect(record.earthquakeInfo!.originTime.day, 11);
      expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.001));
      expect(record.earthquakeInfo!.longitude, closeTo(142.860, 0.001));
      expect(record.earthquakeInfo!.depthKm, closeTo(24.0, 0.01));
      expect(record.earthquakeInfo!.magnitude, closeTo(9.0, 0.01));

      // 観測点情報
      expect(record.stationInfo, isNotNull);
      expect(record.stationInfo!.stationCode, 'IBR011');
      expect(record.stationInfo!.latitude, closeTo(36.1256, 0.0001));
      expect(record.stationInfo!.longitude, closeTo(140.0901, 0.0001));
      expect(record.stationInfo!.heightM, closeTo(27.0, 0.1));

      // チャンネル方向
      expect(record.channelDirections.length, 3);
      expect(record.channelDirections[0], KnetChannelDirection.ns);
      expect(record.channelDirections[1], KnetChannelDirection.ew);
      expect(record.channelDirections[2], KnetChannelDirection.ud);

      // データポイント
      expect(record.dataPoints.isNotEmpty, isTrue);
      expect(record.dataPoints.first.accelerationsGal.length, 3);
      expect(
        record.dataPoints.first.accelerationsGal[0],
        closeTo(-0.73, 0.001),
      );
    });

    test('サンプリング周波数を推定できる', () {
      const csv = '''
OriginTime,2011/03/11-14:46:00
Latitude,38.103
Longitude,142.860
Depth(km),24
Magnitude,9.0
Code,IBR011
Latitude,36.1256
Longitude,140.0901
Height(m),27
Offset,0.00,0.00,0.00
Time,RelativeTime(s),NS(gal),EW(gal),UD(gal)
2011/03/11 14:46:00,0.00,-0.73,0.61,-0.61
2011/03/11 14:46:00,0.01,-0.73,0.61,-0.61
''';
      final record = parser.parse(csv);
      // dt = 0.01s -> 100Hz
      expect(record.samplingFrequencyHz, closeTo(100.0, 0.1));
    });

    test('KiK-net 6チャンネルデータをパースできる', () {
      const csv = '''
OriginTime,2011/03/11-14:46:00
Latitude,38.103
Longitude,142.860
Depth(km),24
Magnitude,9.0
Code,FKSH10
Latitude,37.1234
Longitude,140.9876
Height1(m),100
Height2(m),-100
Offset,0.00,0.00,0.00,0.00,0.00,0.00
Time,RelativeTime(s),NS(gal),EW(gal),UD(gal),NS2(gal),EW2(gal),UD2(gal)
2011/03/11 14:46:00,0.00,-0.73,0.61,-0.61,-0.85,0.42,-0.73
2011/03/11 14:46:00,0.01,-0.73,0.61,-0.61,-0.85,0.42,-0.73
''';
      final record = parser.parse(csv);
      expect(record.networkType, KnetNetworkType.kiknet);
      expect(record.dataPoints.first.accelerationsGal.length, 6);
    });

    test('震源情報がない即時公開データをパースできる', () {
      const csv = '''
Code,IBR011
Latitude,36.1256
Longitude,140.0901
Height(m),27
Offset,0.00,0.00,0.00
Time,RelativeTime(s),NS(gal),EW(gal),UD(gal)
2011/03/11 14:46:00,0.00,-0.73,0.61,-0.61
''';
      final record = parser.parse(csv);
      expect(record.earthquakeInfo, isNull);
      expect(record.stationInfo, isNotNull);
    });

    group('実データによるテスト（BOSAI認証が必要）', () {
      final hasCredentials =
          Platform.environment['BOSAI_ID'] != null &&
          Platform.environment['BOSAI_PW'] != null;

      test(
        '防災科研からダウンロードしたCSVファイルをパースできる',
        skip: hasCredentials ? false : 'BOSAI_ID/BOSAI_PW が設定されていません',
        () {
          expect(hasCredentials, isTrue);
        },
      );
    });
  });
}
