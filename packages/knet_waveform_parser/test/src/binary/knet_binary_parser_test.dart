import 'dart:io';
import 'dart:typed_data';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = KnetBinaryParser();

  group('KnetBinaryParser', () {
    group('合成フィクスチャ', () {
      test('シグネチャが不正な場合はエラー', () {
        final bytes = Uint8List.fromList([
          0x00,
          0x00,
          0x00,
          0x00,
          ...List.filled(76, 0),
        ]);
        expect(
          () => parser.parse(bytes),
          throwsA(isA<KnetParseException>()),
        );
      });

      test('ファイルが短すぎる場合はエラー', () {
        final bytes = Uint8List.fromList([0x0a, 0x02, 0x00, 0x00]);
        expect(
          () => parser.parse(bytes),
          throwsA(isA<KnetParseException>()),
        );
      });

      test('合成 KWIN (K-NET 3ch) をパースできる', () {
        final bytes = _buildSyntheticKwin(
          stationCode: 'TST001',
          channelCount: 3,
          samplingHz: 100,
          samples: [1, 2, 3, 4, 5],
        );
        final record = parser.parse(bytes);

        expect(record.stationInfo.stationCode, 'TST001');
        expect(record.channels.length, 3);
        expect(record.samplingFrequencyHz, 100.0);
        expect(record.networkType, KnetNetworkType.knet);
        expect(record.channels[0].direction, KnetChannelDirection.ns);
        expect(record.channels[1].direction, KnetChannelDirection.ew);
        expect(record.channels[2].direction, KnetChannelDirection.ud);
        expect(record.channels[0].rawData, [1, 2, 3, 4, 5]);
      });

      test('合成 KWIN (KiK-net 6ch) をパースできる', () {
        final bytes = _buildSyntheticKwin(
          stationCode: 'TSTH01',
          channelCount: 6,
          samplingHz: 100,
          samples: [10, 20],
          isKiknet: true,
        );
        final record = parser.parse(bytes);

        expect(record.channels.length, 6);
        expect(record.networkType, KnetNetworkType.kiknet);
        expect(record.channels[0].direction, KnetChannelDirection.ns);
        expect(record.channels[3].direction, KnetChannelDirection.ns2);
        expect(record.channels[5].direction, KnetChannelDirection.ud2);
      });

      test('スケールファクタが正しく変換される', () {
        final bytes = _buildSyntheticKwin(
          stationCode: 'TST001',
          channelCount: 3,
          samplingHz: 100,
          samples: [100],
          numerator: 7845,
          denominator: 8223790,
        );
        final record = parser.parse(bytes);

        expect(
          record.channels[0].scaleFactorNumerator,
          closeTo(7845.0, 0.1),
        );
        expect(
          record.channels[0].scaleFactorDenominator,
          closeTo(8223790.0, 1.0),
        );
        expect(
          record.channels[0].accelerationGal.first,
          closeTo(100.0 * 7845.0 / 8223790.0, 1e-6),
        );
      });

      test('地震情報をパースできる', () {
        final bytes = _buildSyntheticKwin(
          stationCode: 'TST001',
          channelCount: 3,
          samplingHz: 100,
          samples: [0],
          includeEqInfo: true,
          eqLatBcd: [0x03, 0x17, 0x37, 0xee], // 31.737
          eqLonBcd: [0x13, 0x17, 0x22, 0xee], // 131.722
          eqDepthBcd: [0xc0, 0x03, 0x1e, 0xee], // 31km
        );
        final record = parser.parse(bytes);

        expect(record.earthquakeInfo, isNotNull);
        expect(record.earthquakeInfo!.originTime.year, 2024);
        expect(record.earthquakeInfo!.originTime.month, 8);
        expect(record.earthquakeInfo!.originTime.day, 8);
        expect(record.earthquakeInfo!.originTime.hour, 16);
        expect(record.earthquakeInfo!.originTime.minute, 43);
        expect(record.earthquakeInfo!.latitude, closeTo(31.737, 0.001));
        expect(record.earthquakeInfo!.longitude, closeTo(131.722, 0.001));
        expect(record.earthquakeInfo!.depthKm, closeTo(31.0, 0.1));
        expect(record.earthquakeInfo!.magnitude, closeTo(7.1, 0.01));
      });

      test('8 ビットデルタ圧縮を正しくデコードできる', () {
        // deltas: [+10, -5, +20] → accumulator: 100, 110, 105, 125
        final bytes = _buildSyntheticKwin(
          stationCode: 'TST001',
          channelCount: 3,
          samplingHz: 100,
          samples: [100, 110, 105, 125],
          useDeltaEncoding: true,
        );
        final record = parser.parse(bytes);
        expect(record.channels[0].rawData, [100, 110, 105, 125]);
      });

      test('16 ビットデルタ圧縮を正しくデコードできる', () {
        // 値域が広い場合は 16-bit デルタを使用
        final bytes = _buildSyntheticKwin(
          stationCode: 'TST001',
          channelCount: 3,
          samplingHz: 100,
          samples: [1000, 1500, 800, 2000],
          use16BitDelta: true,
        );
        final record = parser.parse(bytes);
        expect(record.channels[0].rawData, [1000, 1500, 800, 2000]);
      });
    });

    group('実ファイル（防災科研ダウンロードデータ）', () {
      final realDir = Directory('test/fixtures/real');
      final hasRealFiles =
          realDir.existsSync() &&
          realDir.listSync().whereType<File>().any(
            (f) => f.path.endsWith('.kwin'),
          );

      test(
        '2024年日向灘地震 EHM001 KWIN をパースできる (K-NET 3ch)',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に .kwin ファイルがありません',
        () {
          final file = File('test/fixtures/real/EHM0012408081643.kwin');
          if (!file.existsSync()) {
            markTestSkipped('EHM0012408081643.kwin が存在しません');
            return;
          }
          final bytes = file.readAsBytesSync();
          final record = parser.parse(bytes);

          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2024);
          expect(record.earthquakeInfo!.originTime.month, 8);
          expect(record.earthquakeInfo!.originTime.day, 8);
          expect(record.earthquakeInfo!.magnitude, closeTo(7.1, 0.1));
          expect(
            record.earthquakeInfo!.latitude,
            closeTo(31.737, 0.01),
          );
          expect(
            record.earthquakeInfo!.longitude,
            closeTo(131.722, 0.01),
          );
          expect(record.earthquakeInfo!.depthKm, closeTo(31.0, 5.0));

          expect(record.stationInfo.stationCode, 'EHM001');
          expect(record.samplingFrequencyHz, closeTo(100.0, 0.1));
          expect(record.networkType, KnetNetworkType.knet);

          expect(record.channels.length, 3);
          expect(record.channels[0].direction, KnetChannelDirection.ns);
          expect(record.channels[1].direction, KnetChannelDirection.ew);
          expect(record.channels[2].direction, KnetChannelDirection.ud);

          // データが存在すること（最低 1 秒分 = 100 サンプル）
          expect(record.channels[0].rawData.length, greaterThanOrEqualTo(100));
          expect(
            record.channels[0].scaleFactorNumerator,
            greaterThan(0),
          );
          expect(
            record.channels[0].scaleFactorDenominator,
            greaterThan(0),
          );

          // 物理値変換できること
          final acc = record.channels[0].accelerationGal;
          expect(acc.isNotEmpty, isTrue);
          expect(acc.every((v) => v.isFinite), isTrue);
        },
      );

      test(
        '2024年日向灘地震 EHMH01 KWIN をパースできる (KiK-net 6ch)',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に .kwin ファイルがありません',
        () {
          final file = File('test/fixtures/real/EHMH012408081643.kwin');
          if (!file.existsSync()) {
            markTestSkipped('EHMH012408081643.kwin が存在しません');
            return;
          }
          final bytes = file.readAsBytesSync();
          final record = parser.parse(bytes);

          expect(record.stationInfo.stationCode, 'EHMH01');
          expect(record.samplingFrequencyHz, closeTo(100.0, 0.1));
          expect(record.networkType, KnetNetworkType.kiknet);

          expect(record.channels.length, 6);
          expect(record.channels[0].direction, KnetChannelDirection.ns);
          expect(record.channels[1].direction, KnetChannelDirection.ew);
          expect(record.channels[2].direction, KnetChannelDirection.ud);
          expect(record.channels[3].direction, KnetChannelDirection.ns2);
          expect(record.channels[4].direction, KnetChannelDirection.ew2);
          expect(record.channels[5].direction, KnetChannelDirection.ud2);

          expect(record.channels[0].rawData.length, greaterThanOrEqualTo(100));

          // 地震情報
          expect(record.earthquakeInfo, isNotNull);
          expect(record.earthquakeInfo!.originTime.year, 2024);
          expect(record.earthquakeInfo!.magnitude, closeTo(7.1, 0.1));
        },
      );

      test(
        'K-NET と KiK-net でスケールファクタが異なること',
        skip: hasRealFiles ? false : 'test/fixtures/real/ に .kwin ファイルがありません',
        () {
          final knetFile = File('test/fixtures/real/EHM0012408081643.kwin');
          final kikFile = File('test/fixtures/real/EHMH012408081643.kwin');
          if (!knetFile.existsSync() || !kikFile.existsSync()) {
            markTestSkipped('実ファイルが存在しません');
            return;
          }

          final knetRecord = parser.parse(knetFile.readAsBytesSync());
          final kikRecord = parser.parse(kikFile.readAsBytesSync());

          // EHM001 K-NET NS チャンネル: 7845/8223790
          expect(
            knetRecord.channels[0].scaleFactorNumerator,
            closeTo(7845.0, 1.0),
          );
          expect(
            knetRecord.channels[0].scaleFactorDenominator,
            closeTo(8223790.0, 1.0),
          );

          // KiK-net は異なるスケールファクタを持つ
          expect(
            kikRecord.channels[0].scaleFactorDenominator,
            isNot(closeTo(knetRecord.channels[0].scaleFactorDenominator, 1.0)),
          );
        },
      );
    });
  });
}

// ---------------------------------------------------------------------------
// 合成 KWIN ビルダー
// ---------------------------------------------------------------------------

/// テスト用 KWIN バイナリを生成する
///
/// 実際の KWIN ファイルの構造を模した最小構成:
///   16 bytes: グローバルヘッダ
///   情報ブロック群（e0 00 + オプション e0 20）
///   1 秒データブロック群
Uint8List _buildSyntheticKwin({
  required String stationCode,
  required int channelCount,
  required int samplingHz,
  required List<int> samples,
  bool isKiknet = false,
  int numerator = 1,
  int denominator = 1,
  bool includeEqInfo = false,
  int eqYear = 2024,
  int eqMonth = 8,
  int eqDay = 8,
  int eqHour = 16,
  int eqMinute = 43,
  int eqSecond = 0,
  List<int> eqLatBcd = const [0x03, 0x17, 0x37, 0xee],
  List<int> eqLonBcd = const [0x13, 0x17, 0x22, 0xee],
  List<int> eqDepthBcd = const [0xc0, 0x03, 0x1e, 0xee],
  int eqMagBcd = 0x71,
  bool useDeltaEncoding = false,
  bool use16BitDelta = false,
}) {
  final buf = BytesBuilder();

  // -----------------------------------------------------------------------
  // 1. グローバルヘッダ (0x00-0x0f)
  // -----------------------------------------------------------------------
  // 0x00-0x03: シグネチャ
  buf.add([0x0a, 0x02, 0x00, 0x00]);
  // 0x04-0x07: フィールド (固定値)
  buf.add([0x0c, 0x00, 0x00, 0x00]);
  // 0x08-0x0b: ステーション ID (ダミー)
  buf.add([0x01, 0x10, 0x11, 0xf9]);
  // 0x0c-0x0f: 情報ブロック全体長（後で書き込む、プレースホルダ）
  final infoBuf = BytesBuilder();

  // -----------------------------------------------------------------------
  // 2. 情報ブロック e0 00 (K-NET) or e0 01 (KiK-net)
  // -----------------------------------------------------------------------
  final blockSubtype = isKiknet ? 0x01 : 0x00;
  final e0Content = BytesBuilder();

  // 観測点座標（lat, lon, height, [borehole depth for KiK-net]）
  e0Content.add([0x03, 0x39, 0x78, 0x8e]); // lat: 33.9788
  e0Content.add([0x13, 0x35, 0x49, 0x4e]); // lon: 133.549
  e0Content.add([0xc0, 0x00, 0x25, 0xee]); // height: 25m
  if (isKiknet) {
    e0Content.add([0xc0, 0x02, 0x75, 0xee]); // borehole depth
  }

  // 観測点コード (6 bytes ASCII + 6 bytes null padding = 12 bytes)
  final codeBytes = stationCode.padRight(6, '\x00').codeUnits.take(6).toList();
  e0Content.add(codeBytes);
  e0Content.add(List.filled(6, 0)); // null padding

  // 記録開始時刻 BCD (8 bytes): 2024/08/08 16:44:15
  e0Content.add([0x20, 0x24, 0x08, 0x08, 0x16, 0x44, 0x15, 0x00]);
  // カウントフィールド (4 bytes)
  e0Content.add([0x00, 0x00, 0x00, 0x64]);
  // 記録終了時刻 BCD (8 bytes): 2024/08/08 16:44:30
  e0Content.add([0x20, 0x24, 0x08, 0x08, 0x16, 0x44, 0x30, 0x00]);

  // チャンネル情報ヘッダ (8 bytes) at relative position 0x30 from block content start
  // offset 0x44 + shift (absolute) = block_content_start + 0x30 + shift
  e0Content.add([0x01, 0x02, 0x00, 0x07]); // type header
  e0Content.add([
    (samplingHz >> 8) & 0xff,
    samplingHz & 0xff,
  ]); // sampling rate uint16 BE
  e0Content.add([channelCount]); // channel count
  e0Content.add([0x02]); // padding

  // チャンネルエントリ (20 bytes × channelCount)
  for (var ch = 0; ch < channelCount; ch++) {
    final chId = 0x0110b3bb + ch;
    e0Content.add([
      (chId >> 24) & 0xff,
      (chId >> 16) & 0xff,
      (chId >> 8) & 0xff,
      chId & 0xff,
    ]); // channel ID
    e0Content.add([(numerator >> 8) & 0xff, numerator & 0xff]); // numerator
    e0Content.add([0x01, 0x23]); // unit code
    e0Content.add([
      (denominator >> 24) & 0xff,
      (denominator >> 16) & 0xff,
      (denominator >> 8) & 0xff,
      denominator & 0xff,
    ]); // denominator
    e0Content.add(List.filled(8, 0)); // reserved
  }

  // e0 00 / e0 01 ブロックヘッダ + コンテンツ
  final contentBytes = e0Content.toBytes();
  final contentLen = contentBytes.length;
  infoBuf.add([
    0xe0,
    blockSubtype,
    (contentLen >> 8) & 0xff,
    contentLen & 0xff,
  ]);
  infoBuf.add(contentBytes);

  // -----------------------------------------------------------------------
  // 3. 地震情報ブロック e0 20 (オプション)
  // -----------------------------------------------------------------------
  if (includeEqInfo) {
    final eqContent = BytesBuilder();
    // 発生時刻 BCD (8 bytes)
    eqContent.add([
      _decToBcd(eqYear ~/ 100),
      _decToBcd(eqYear % 100),
      _decToBcd(eqMonth),
      _decToBcd(eqDay),
      _decToBcd(eqHour),
      _decToBcd(eqMinute),
      _decToBcd(eqSecond),
      0x00,
    ]);
    // 緯度 BCD (4 bytes)
    eqContent.add(eqLatBcd);
    // 経度 BCD (4 bytes)
    eqContent.add(eqLonBcd);
    // 深さ (4 bytes)
    eqContent.add(eqDepthBcd);
    // マグニチュード (1 byte BCD)
    eqContent.add([eqMagBcd]);
    // パディング (3 bytes)
    eqContent.add([0x00, 0x00, 0x00]);

    infoBuf.add([0xe0, 0x20, 0x00, 0x18]);
    infoBuf.add(eqContent.toBytes());
  }

  // 情報ブロック長をグローバルヘッダに書き込む
  final infoBytes = infoBuf.toBytes();
  final infoLen = infoBytes.length;
  buf.add([
    (infoLen >> 24) & 0xff,
    (infoLen >> 16) & 0xff,
    (infoLen >> 8) & 0xff,
    infoLen & 0xff,
  ]);
  buf.add(infoBytes);

  // -----------------------------------------------------------------------
  // 4. 1 秒データブロック (1 ブロックのみ)
  // -----------------------------------------------------------------------
  final dataBuf = BytesBuilder();

  for (var ch = 0; ch < channelCount; ch++) {
    final chId = 0x0110b3bb + ch;
    dataBuf.add([
      (chId >> 24) & 0xff,
      (chId >> 16) & 0xff,
      (chId >> 8) & 0xff,
      chId & 0xff,
    ]); // channel ID

    if (use16BitDelta) {
      // 16-bit delta encoding
      dataBuf.add([0x20]); // size code: 2 bytes per delta
      dataBuf.add([samples.length]); // num samples
      // first sample (int32 BE)
      _writeInt32BE(dataBuf, samples.first);
      // deltas (int16 BE)
      for (var i = 1; i < samples.length; i++) {
        final delta = samples[i] - samples[i - 1];
        dataBuf.add([(delta >> 8) & 0xff, delta & 0xff]);
      }
    } else {
      // 8-bit delta encoding
      dataBuf.add([0x10]); // size code: 1 byte per delta
      dataBuf.add([samples.length]); // num samples
      // first sample (int32 BE)
      _writeInt32BE(dataBuf, samples.first);
      // deltas (int8)
      for (var i = 1; i < samples.length; i++) {
        final delta = (samples[i] - samples[i - 1]).clamp(-128, 127);
        dataBuf.add([delta & 0xff]);
      }
    }
  }

  final dataBytes = dataBuf.toBytes();
  final dataLen = dataBytes.length;

  // 1 秒ブロックヘッダ: timestamp (8 bytes) + marker (4 bytes) + len (4 bytes)
  buf.add([0x20, 0x24, 0x08, 0x08, 0x16, 0x44, 0x15, 0x00]); // timestamp
  buf.add([0x00, 0x00, 0x00, 0x0a]); // marker
  buf.add([
    (dataLen >> 24) & 0xff,
    (dataLen >> 16) & 0xff,
    (dataLen >> 8) & 0xff,
    dataLen & 0xff,
  ]); // data length
  buf.add(dataBytes);

  return buf.toBytes();
}

int _decToBcd(int value) => ((value ~/ 10) << 4) | (value % 10);

void _writeInt32BE(BytesBuilder buf, int value) {
  final unsigned = value & 0xffffffff;
  buf.add([
    (unsigned >> 24) & 0xff,
    (unsigned >> 16) & 0xff,
    (unsigned >> 8) & 0xff,
    unsigned & 0xff,
  ]);
}
