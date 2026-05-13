import 'dart:io';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = KnetAsciiParser();

  group('KnetAsciiParser', () {
    group('合成フィクスチャ', () {
      test('フィクスチャファイルをパースできる', () {
        final file = File('test/fixtures/sample_knet.ascii');
        final source = file.readAsStringSync();
        final record = parser.parse(source);

        expect(record.earthquakeInfo, isNotNull);
        expect(record.earthquakeInfo!.originTime.year, 2011);
        expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.001));
        expect(record.earthquakeInfo!.longitude, closeTo(142.860, 0.001));
        expect(record.earthquakeInfo!.depthKm, closeTo(24.0, 0.01));
        expect(record.earthquakeInfo!.magnitude, closeTo(9.0, 0.01));

        expect(record.stationInfo.stationCode, 'IBR011');
        expect(record.stationInfo.latitude, closeTo(36.1256, 0.0001));
        expect(record.stationInfo.longitude, closeTo(140.0901, 0.0001));
        expect(record.stationInfo.heightM, closeTo(27.0, 0.1));

        expect(record.samplingFrequencyHz, closeTo(100.0, 0.01));
        expect(record.durationTimeSec, closeTo(300.0, 0.1));
        expect(record.direction, KnetChannelDirection.ns);
        expect(record.maxAccelerationGal, closeTo(328.844, 0.01));

        // スケールファクタ (gal)/6291456
        expect(record.scaleFactorNumerator, closeTo(1.0, 0.001));
        expect(record.scaleFactorDenominator, closeTo(6291456.0, 1.0));

        expect(record.rawData.isNotEmpty, isTrue);
        expect(record.rawData.first, -4594);
      });

      test('加速度波形に変換できる', () {
        final file = File('test/fixtures/sample_knet.ascii');
        final source = file.readAsStringSync();
        final record = parser.parse(source);

        final acc = record.accelerationGal;
        expect(acc.isNotEmpty, isTrue);
        expect(acc.first, closeTo(-4594.0 / 6291456.0, 1e-8));
      });

      test('ヘッダが17行未満の場合はエラー', () {
        expect(
          () => parser.parse('Origin Time 2011/03/11 14:46:00\n'),
          throwsA(isA<KnetParseException>()),
        );
      });

      test('スケールファクタ分数形式をパースできる', () {
        final source = _buildTestAscii(scaleFactor: '3920(gal)/6291456');
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
          expect(record.direction, KnetChannelDirection.fromString(dir));
        }
      });
    });

    group('実ファイル（防災科研ダウンロードデータ）', () {
      final realDir = Directory('test/fixtures/real');
      final hasRealFiles =
          realDir.existsSync() &&
          realDir.listSync().whereType<File>().isNotEmpty;

      test(
        '2011年東北地方太平洋沖地震 AIC001 NS をパースできる',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に実ファイルがありません',
        () {
          final file = File('test/fixtures/real/AIC0011103111446.NS');
          if (!file.existsSync()) {
            markTestSkipped('AIC0011103111446.NS が存在しません');
            return;
          }
          final source = file.readAsStringSync();
          final record = parser.parse(source);

          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2011);
          expect(record.earthquakeInfo!.originTime.month, 3);
          expect(record.earthquakeInfo!.originTime.day, 11);
          expect(record.earthquakeInfo!.latitude, closeTo(38.103, 0.01));
          expect(record.earthquakeInfo!.magnitude, closeTo(9.0, 0.1));

          expect(record.stationInfo.stationCode, 'AIC001');
          expect(record.samplingFrequencyHz, closeTo(100.0, 0.1));
          expect(record.direction, KnetChannelDirection.ns);
          expect(record.rawData.isNotEmpty, isTrue);
        },
      );

      test(
        '2011年東北地方太平洋沖地震 AIC001 EW をパースできる',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に実ファイルがありません',
        () {
          final file = File('test/fixtures/real/AIC0011103111446.EW');
          if (!file.existsSync()) {
            markTestSkipped('AIC0011103111446.EW が存在しません');
            return;
          }
          final source = file.readAsStringSync();
          final record = parser.parse(source);

          expect(record.direction, KnetChannelDirection.ew);
          expect(record.rawData.isNotEmpty, isTrue);
          final acc = record.accelerationGal;
          expect(acc.isNotEmpty, isTrue);
        },
      );

      test(
        '2024年日向灘地震 EHM001 NS をパースできる',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に実ファイルがありません',
        () {
          final file = File('test/fixtures/real/EHM0012408081643.NS');
          if (!file.existsSync()) {
            markTestSkipped('EHM0012408081643.NS が存在しません');
            return;
          }
          final source = file.readAsStringSync();
          final record = parser.parse(source);

          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2024);
          expect(record.earthquakeInfo!.magnitude, closeTo(7.1, 0.1));
          expect(record.stationInfo.stationCode, 'EHM001');
          expect(record.direction, KnetChannelDirection.ns);
        },
      );
    });
  });
}

/// テスト用の ASCII テキストを生成する（実際のヘッダ幅18文字形式）
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
    // 各ラベルは18文字固定（実際のファイル形式）
    'Origin Time       $originTime\n'
    'Lat.              $lat\n'
    'Long.             $lon\n'
    'Depth. (km)       $depth\n'
    'Mag.              $mag\n'
    'Station Code      $stationCode\n'
    'Station Lat.      $stationLat\n'
    'Station Long.     $stationLon\n'
    'Station Height(m) $stationHeight\n'
    'Record Time       $recordTime\n'
    'Sampling Freq(Hz) $samplingFreq\n'
    'Duration Time(s)  $duration\n'
    'Dir.              $direction\n'
    'Scale Factor      $scaleFactor\n'
    'Max. Acc. (gal)   $maxAcc\n'
    'Last Correction   $lastCorrection\n'
    'Memo.             $memo\n'
    '$data\n';
