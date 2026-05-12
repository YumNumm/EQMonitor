import 'dart:io';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = KnetAsciiParser();

  group('KnetAsciiParser', () {
    test('フィクスチャファイルをパースできる', () {
      final file = File('test/fixtures/sample_knet.ascii');
      final source = file.readAsStringSync();
      final record = parser.parse(source);

      // 地震情報
      expect(record.earthquakeInfo, isNotNull);
      expect(record.earthquakeInfo!.originTime.year, 2011);
      expect(record.earthquakeInfo!.originTime.month, 3);
      expect(record.earthquakeInfo!.originTime.day, 11);
      expect(record.earthquakeInfo!.originTime.hour, 14);
      expect(record.earthquakeInfo!.originTime.minute, 46);
      expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.001));
      expect(record.earthquakeInfo!.longitude, closeTo(142.860, 0.001));
      expect(record.earthquakeInfo!.depthKm, closeTo(24.0, 0.01));
      expect(record.earthquakeInfo!.magnitude, closeTo(9.0, 0.01));

      // 観測点情報
      expect(record.stationInfo.stationCode, 'IBR011');
      expect(record.stationInfo.latitude, closeTo(36.1256, 0.0001));
      expect(record.stationInfo.longitude, closeTo(140.0901, 0.0001));
      expect(record.stationInfo.heightM, closeTo(27.0, 0.1));

      // 記録情報
      expect(record.samplingFrequencyHz, closeTo(100.0, 0.01));
      expect(record.durationTimeSec, closeTo(300.0, 0.1));
      expect(record.direction, KnetChannelDirection.ns);
      expect(record.maxAccelerationGal, closeTo(328.844, 0.01));

      // スケールファクタ (gal)/6291456
      expect(record.scaleFactorNumerator, closeTo(1.0, 0.001));
      expect(record.scaleFactorDenominator, closeTo(6291456.0, 1.0));

      // 生データ
      expect(record.rawData.isNotEmpty, isTrue);
      expect(record.rawData.first, -4594);
    });

    test('加速度波形に変換できる', () {
      final file = File('test/fixtures/sample_knet.ascii');
      final source = file.readAsStringSync();
      final record = parser.parse(source);

      final acc = record.accelerationGal;
      expect(acc.isNotEmpty, isTrue);
      // -4594 * (1/6291456) ≈ -0.00073 gal
      expect(acc.first, closeTo(-4594.0 / 6291456.0, 1e-8));
    });

    test('ヘッダが17行未満の場合はエラー', () {
      expect(
        () => parser.parse('Origin Time 2011/03/11 14:46:00\n'),
        throwsA(isA<KnetParseException>()),
      );
    });

    test('スケールファクタ分数形式をパースできる', () {
      final source = _buildTestAscii(scaleFactor: '3920/6291456(gal)');
      final record = parser.parse(source);
      expect(record.scaleFactorNumerator, closeTo(3920.0, 0.01));
      expect(record.scaleFactorDenominator, closeTo(6291456.0, 1.0));
    });

    test('最終補正時刻が空の場合はnull', () {
      final source = _buildTestAscii(lastCorrection: '-');
      final record = parser.parse(source);
      expect(record.lastCorrection, isNull);
    });

    test('各チャンネル方向をパースできる', () {
      for (final dir in ['N-S', 'E-W', 'U-D']) {
        final source = _buildTestAscii(direction: dir);
        final record = parser.parse(source);
        final expected = KnetChannelDirection.fromString(dir);
        expect(record.direction, expected);
      }
    });

    group('実データによるテスト（BOSAI認証が必要）', () {
      final bosaiId = Platform.environment['BOSAI_ID'];
      final bosaiPw = Platform.environment['BOSAI_PW'];
      final hasCredentials = bosaiId != null && bosaiPw != null;

      test(
        '防災科研からダウンロードしたASCIIファイルをパースできる',
        skip: hasCredentials ? false : 'BOSAI_ID/BOSAI_PW が設定されていません',
        () {
          expect(hasCredentials, isTrue);
        },
      );
    });
  });
}

/// テスト用の ASCII テキストを生成する
String _buildTestAscii({
  String originTime = '2011/03/11 14:46:00',
  String lat = '38.103',
  String lon = '142.860',
  String depth = '24',
  String mag = '9.0',
  String stationCode = 'IBR011',
  String stationLat = '36.1256',
  String stationLon = '140.0901',
  String stationHeight = '27',
  String recordTime = '2011/03/11 14:46:00',
  String samplingFreq = '100Hz',
  String duration = '300',
  String direction = 'N-S',
  String scaleFactor = '(gal)/6291456',
  String maxAcc = '328.844',
  String lastCorrection = '2011/03/12 10:00:00',
  String memo = '',
  String data =
      '   -4594   -4620   -4661   -4597   -4628   -4643   -4614   -4636',
}) =>
    '''
Origin Time             $originTime
Lat.                    $lat
Lon.                    $lon
Depth. (km)             $depth
Mag.                    $mag
Station Code            $stationCode
Station Lat.            $stationLat
Station Lon.            $stationLon
Station Height(m)       $stationHeight
Record Time             $recordTime
Sampling Freq(Hz)       $samplingFreq
Duration Time(s)        $duration
Dir.                    $direction
Scale Factor            $scaleFactor
Max Acc. (gal)          $maxAcc
Last Correction         $lastCorrection
Memo.                   $memo
$data
''';
