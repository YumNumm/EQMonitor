import 'dart:typed_data';

import 'package:knet_waveform_parser/src/ascii/knet_ascii_parser.dart';
import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:knet_waveform_parser/src/model/knet_network_type.dart';
import 'package:knet_waveform_parser/src/model/knet_record.dart';

/// KWIN バイナリフォーマットパーサ（K-NET / KiK-net）
///
/// 防災科研 NIED が提供する WIN32 派生バイナリ形式（`.kwin`）を解析する。
/// ファイルは可変長 TLV ブロックで構成される情報ブロックと、
/// 1秒単位のデータブロック（デルタ圧縮）から成る。
class KnetBinaryParser {
  const KnetBinaryParser();

  static const _kwinSignature = [0x0a, 0x02, 0x00, 0x00];

  /// KWIN バイナリを [KnetBinaryRecord] にパースする
  KnetBinaryRecord parse(Uint8List bytes) {
    if (bytes.length < 80) {
      throw const KnetParseException('KWIN file too short');
    }

    // シグネチャ検証
    for (var i = 0; i < 4; i++) {
      if (bytes[i] != _kwinSignature[i]) {
        throw const KnetParseException(
          'Invalid KWIN signature: expected 0a 02 00 00',
        );
      }
    }

    try {
      // 情報ブロック全体長（0x0c から big-endian uint32）
      final infoLength = _uint32(bytes, 0x0c);
      final infoEnd = 0x10 + infoLength;
      if (infoEnd > bytes.length) {
        throw const KnetParseException('File truncated in info block area');
      }

      // ブロック種別: 0x11 バイトで K-NET (0x00) / KiK-net (0x01) を判別
      // KiK-net は地表 + 孔底の 2 センサ分の座標フィールドを持つため
      // 後続フィールドが 4 バイト後方にずれる
      final blockSubtype = bytes[0x11];
      final shift = blockSubtype * 4; // 0 or 4

      // サンプリング周波数とチャンネル数
      final samplingHz = _uint16(bytes, 0x44 + shift).toDouble();
      final channelCount = bytes[0x46 + shift];

      // 観測点コード（6 バイト ASCII、null 終端）
      final stationCodeOffset = 0x20 + shift;
      final stationCode = _readAscii(bytes, stationCodeOffset, 6);

      // 観測点座標（BCD エンコード）
      final stationLat = _parseBcdCoord(bytes, 0x14);
      final stationLon = _parseBcdCoord(bytes, 0x18);
      final stationHeight = _parseBcdHeight(bytes, 0x1c);

      // スケールファクタ（チャンネル毎）
      final channelEntriesBase = 0x48 + shift;
      final scaleFactors = _extractScaleFactors(
        bytes,
        channelEntriesBase,
        channelCount,
      );

      // 地震情報ブロック（e0 20 00 18）を情報ブロック内で探索
      final earthquakeInfo = _findEarthquakeInfo(bytes, infoEnd);

      // 1秒データブロックを順次解析
      final secondBlocks = _parseSecondBlocks(bytes, infoEnd);

      // 全チャンネルの生データ合算
      DateTime? recordTime;
      final channelSamples = List.generate(channelCount, (_) => <int>[]);
      for (final block in secondBlocks) {
        recordTime ??= block.timestamp;
        for (
          var ch = 0;
          ch < block.channelData.length && ch < channelCount;
          ch++
        ) {
          channelSamples[ch].addAll(block.channelData[ch]);
        }
      }

      // チャンネル方向の割り当て
      final directions = _buildDirections(channelCount);
      final channels = List.generate(channelCount, (i) {
        final (num, den) = i < scaleFactors.length
            ? scaleFactors[i]
            : (1.0, 1.0);
        return KnetBinaryChannel(
          direction: directions[i],
          scaleFactorNumerator: num,
          scaleFactorDenominator: den,
          rawData: List.unmodifiable(channelSamples[i]),
        );
      });

      final networkType = channelCount >= 6
          ? KnetNetworkType.kiknet
          : KnetNetworkType.knet;

      return KnetBinaryRecord(
        earthquakeInfo: earthquakeInfo,
        stationInfo: KnetStationInfo(
          stationCode: stationCode,
          latitude: stationLat,
          longitude: stationLon,
          heightM: stationHeight,
        ),
        recordTime: recordTime ?? DateTime(2000),
        samplingFrequencyHz: samplingHz,
        channels: List.unmodifiable(channels),
        networkType: networkType,
      );
    } on KnetParseException {
      rethrow;
    } on Exception catch (e, st) {
      throw KnetParseException('Failed to parse KWIN binary: $e', st);
    }
  }

  // ---------------------------------------------------------------------------
  // 情報ブロック解析
  // ---------------------------------------------------------------------------

  /// チャンネルエントリからスケールファクタを抽出する
  ///
  /// 各エントリ（20 バイト）: 4(ID) + 2(numerator) + 2(unit=0x0123) + 4(denominator) + 8(その他)
  List<(double, double)> _extractScaleFactors(
    Uint8List bytes,
    int base,
    int channelCount,
  ) {
    const entrySize = 20;
    const unitCode0 = 0x01;
    const unitCode1 = 0x23;

    final factors = <(double, double)>[];
    for (var ch = 0; ch < channelCount; ch++) {
      final pos = base + ch * entrySize;
      if (pos + 12 > bytes.length) {
        break;
      }

      final numAt = pos + 4;
      final unitAt = pos + 6;

      if (bytes[unitAt] == unitCode0 && bytes[unitAt + 1] == unitCode1) {
        final num = _uint16(bytes, numAt).toDouble();
        final den = _uint32(bytes, pos + 8).toDouble();
        factors.add((num, den));
      } else {
        factors.add((1.0, 1.0));
      }
    }
    return factors;
  }

  /// 地震情報ブロック（e0 20 00 18）を情報ブロック内から探索してパースする
  KnetEarthquakeInfo? _findEarthquakeInfo(Uint8List bytes, int infoEnd) {
    for (var i = 0x10; i < infoEnd - 4; i++) {
      if (bytes[i] == 0xe0 &&
          bytes[i + 1] == 0x20 &&
          bytes[i + 2] == 0x00 &&
          bytes[i + 3] == 0x18) {
        final contentStart = i + 4;
        if (contentStart + 24 > bytes.length) {
          return null;
        }
        return _parseEarthquakeBlock(bytes, contentStart);
      }
    }
    return null;
  }

  /// 地震情報 24 バイトブロックをパースする
  ///
  /// 0-7:  発生時刻 BCD (8 bytes)
  /// 8-11: 震源緯度 BCD (4 bytes)
  /// 12-15: 震源経度 BCD (4 bytes)
  /// 16-19: 震源深さ (符号バイト + BCD 3 bytes)
  /// 20:   マグニチュード BCD (1 byte)
  /// 21-23: パディング
  KnetEarthquakeInfo _parseEarthquakeBlock(Uint8List bytes, int offset) {
    final originTime = _parseBcdTimestamp(bytes, offset);
    final lat = _parseBcdCoord(bytes, offset + 8);
    final lon = _parseBcdCoord(bytes, offset + 12);
    final depth = _parseBcdDepth(bytes, offset + 16);
    final mag = _parseBcdMagnitude(bytes[offset + 20]);

    return KnetEarthquakeInfo(
      originTime: originTime,
      latitude: lat,
      longitude: lon,
      depthKm: depth,
      magnitude: mag,
    );
  }

  // ---------------------------------------------------------------------------
  // 1 秒データブロック解析
  // ---------------------------------------------------------------------------

  /// 1 秒データブロックを startOffset 以降から順次パースする
  ///
  /// 各ブロック:
  ///   8 bytes: BCD タイムスタンプ
  ///   4 bytes: マーカ 00 00 00 0a
  ///   4 bytes: データ長 (big-endian uint32)
  ///   N bytes: チャンネルデータ
  List<_SecondBlock> _parseSecondBlocks(Uint8List bytes, int startOffset) {
    final blocks = <_SecondBlock>[];
    var pos = startOffset;

    while (pos + 16 <= bytes.length) {
      // マーカ確認
      if (bytes[pos + 8] != 0x00 ||
          bytes[pos + 9] != 0x00 ||
          bytes[pos + 10] != 0x00 ||
          bytes[pos + 11] != 0x0a) {
        break;
      }

      final timestamp = _parseBcdTimestamp(bytes, pos);
      final dataLen = _uint32(bytes, pos + 12);

      if (pos + 16 + dataLen > bytes.length) {
        break;
      }

      final channelData = _parseChannelData(bytes, pos + 16, dataLen);
      if (channelData.isNotEmpty) {
        blocks.add(
          _SecondBlock(timestamp: timestamp, channelData: channelData),
        );
      }

      pos += 16 + dataLen;
    }

    return blocks;
  }

  /// チャンネルデータ（デルタ圧縮）をデコードする
  ///
  /// チャンネルエントリ:
  ///   4 bytes: チャンネル ID
  ///   1 byte:  サイズコード（上位 4 ビット = デルタバイト数: 1=8bit, 2=16bit, 4=32bit）
  ///   1 byte:  サンプル数
  ///   4 bytes: 先頭サンプル (signed int32 BE)
  ///   (N-1) × deltaBytes: デルタ値列
  List<List<int>> _parseChannelData(
    Uint8List bytes,
    int offset,
    int dataLen,
  ) {
    final channels = <List<int>>[];
    var pos = offset;
    final end = offset + dataLen;

    while (pos + 10 <= end) {
      pos += 4; // skip channel ID
      final sizeCode = bytes[pos++];
      final numSamples = bytes[pos++];
      final firstSample = _int32(bytes, pos);
      pos += 4;

      final deltaBytes = sizeCode >> 4; // 1, 2, or 4
      if (deltaBytes == 0 || numSamples == 0) {
        break;
      }

      final required = (numSamples - 1) * deltaBytes;
      if (pos + required > end) {
        break;
      }

      final samples = <int>[firstSample];
      var acc = firstSample;

      for (var s = 1; s < numSamples; s++) {
        final int delta;
        switch (deltaBytes) {
          case 1:
            delta = bytes[pos++].toSigned(8);
          case 2:
            delta = _int16(bytes, pos);
            pos += 2;
          case 4:
            delta = _int32(bytes, pos);
            pos += 4;
          default:
            delta = 0;
        }
        acc += delta;
        samples.add(acc);
      }

      channels.add(samples);
    }

    return channels;
  }

  // ---------------------------------------------------------------------------
  // BCD / 座標パーシング
  // ---------------------------------------------------------------------------

  /// 8 バイト BCD タイムスタンプ（YYYY MM DD HH mm SS xx xx）を DateTime に変換
  DateTime _parseBcdTimestamp(Uint8List bytes, int offset) {
    final year = _bcdToDec(bytes[offset]) * 100 + _bcdToDec(bytes[offset + 1]);
    final month = _bcdToDec(bytes[offset + 2]);
    final day = _bcdToDec(bytes[offset + 3]);
    final hour = _bcdToDec(bytes[offset + 4]);
    final minute = _bcdToDec(bytes[offset + 5]);
    final second = _bcdToDec(bytes[offset + 6]);
    return DateTime(year, month, day, hour, minute, second);
  }

  /// 4 バイト BCD 座標値（緯度・経度共通）を double に変換する
  ///
  /// BCD ニブル列から E 以外の数字を抽出し、合計桁数 - 3 桁を小数点以下とする。
  /// 例: `03 17 37 ee` → [0,3,1,7,3,7] → 31737 / 10^3 = 31.737
  ///     `03 39 78 8e` → [0,3,3,9,7,8,8] → 339788 / 10^4 = 33.9788
  double _parseBcdCoord(Uint8List bytes, int offset) {
    final digits = <int>[];
    for (var i = 0; i < 4; i++) {
      final b = bytes[offset + i];
      final hi = b >> 4;
      final lo = b & 0x0f;
      if (hi <= 9) {
        digits.add(hi);
      }
      if (lo <= 9) {
        digits.add(lo);
      }
    }
    if (digits.isEmpty) {
      return 0;
    }

    final raw = int.parse(digits.join());
    final fracDigits = digits.length - 3;
    return fracDigits <= 0 ? raw.toDouble() : raw / _pow10(fracDigits);
  }

  /// 観測点標高（4 バイト: 符号バイト + BCD 3 バイト）
  double _parseBcdHeight(Uint8List bytes, int offset) {
    final digits = <int>[];
    for (var i = 1; i < 4; i++) {
      final b = bytes[offset + i];
      final hi = b >> 4;
      final lo = b & 0x0f;
      if (hi <= 9) {
        digits.add(hi);
      }
      if (lo <= 9) {
        digits.add(lo);
      }
    }
    if (digits.isEmpty) {
      return 0;
    }
    return double.parse(digits.join());
  }

  /// 震源深さ（4 バイト: 符号バイト + BCD 3 バイト）
  double _parseBcdDepth(Uint8List bytes, int offset) {
    final isNegative = (bytes[offset] & 0x01) == 0x01;
    final digits = <int>[];
    for (var i = 1; i < 4; i++) {
      final b = bytes[offset + i];
      final hi = b >> 4;
      final lo = b & 0x0f;
      if (hi <= 9) {
        digits.add(hi);
      }
      if (lo <= 9) {
        digits.add(lo);
      }
    }
    if (digits.isEmpty) {
      return 0;
    }
    final raw = double.parse(digits.join());
    return isNegative ? -raw : raw;
  }

  /// マグニチュード（1 バイト BCD）: 0x71 → 7.1
  double _parseBcdMagnitude(int bcdByte) {
    final hi = bcdByte >> 4;
    final lo = bcdByte & 0x0f;
    return hi + lo / 10.0;
  }

  // ---------------------------------------------------------------------------
  // チャンネル方向
  // ---------------------------------------------------------------------------

  List<KnetChannelDirection> _buildDirections(int count) {
    const all = [
      KnetChannelDirection.ns,
      KnetChannelDirection.ew,
      KnetChannelDirection.ud,
      KnetChannelDirection.ns2,
      KnetChannelDirection.ew2,
      KnetChannelDirection.ud2,
    ];
    return all.take(count).toList();
  }

  // ---------------------------------------------------------------------------
  // バイナリ読み取りユーティリティ
  // ---------------------------------------------------------------------------

  String _readAscii(Uint8List bytes, int offset, int length) {
    final buf = StringBuffer();
    for (var i = 0; i < length && offset + i < bytes.length; i++) {
      final b = bytes[offset + i];
      if (b == 0) {
        break;
      }
      buf.writeCharCode(b);
    }
    return buf.toString();
  }

  int _bcdToDec(int bcd) => (bcd >> 4) * 10 + (bcd & 0x0f);

  int _uint16(Uint8List b, int o) => (b[o] << 8) | b[o + 1];

  int _uint32(Uint8List b, int o) =>
      ((b[o] << 24) | (b[o + 1] << 16) | (b[o + 2] << 8) | b[o + 3]) &
      0xffffffff;

  int _int16(Uint8List b, int o) => _uint16(b, o).toSigned(16);

  int _int32(Uint8List b, int o) => _uint32(b, o).toSigned(32);

  double _pow10(int n) {
    var r = 1.0;
    for (var i = 0; i < n; i++) {
      r *= 10;
    }
    return r;
  }
}

/// KWIN バイナリパース結果
class KnetBinaryRecord {
  const KnetBinaryRecord({
    required this.earthquakeInfo,
    required this.stationInfo,
    required this.recordTime,
    required this.samplingFrequencyHz,
    required this.channels,
    required this.networkType,
  });

  final KnetEarthquakeInfo? earthquakeInfo;
  final KnetStationInfo stationInfo;

  /// 記録開始時刻（第 1 秒ブロックのタイムスタンプ）
  final DateTime recordTime;

  /// サンプリング周波数 (Hz)
  final double samplingFrequencyHz;

  /// チャンネルリスト
  final List<KnetBinaryChannel> channels;

  final KnetNetworkType networkType;
}

/// KWIN バイナリの 1 チャンネル分データ
class KnetBinaryChannel {
  const KnetBinaryChannel({
    required this.direction,
    required this.scaleFactorNumerator,
    required this.scaleFactorDenominator,
    required this.rawData,
  });

  final KnetChannelDirection direction;

  /// スケール係数の分子
  final double scaleFactorNumerator;

  /// スケール係数の分母
  final double scaleFactorDenominator;

  /// 生デジタル値列
  final List<int> rawData;

  double get scaleFactor => scaleFactorNumerator / scaleFactorDenominator;

  /// 加速度波形 (gal)
  List<double> get accelerationGal =>
      rawData.map((v) => v * scaleFactor).toList();
}

class _SecondBlock {
  const _SecondBlock({required this.timestamp, required this.channelData});
  final DateTime timestamp;
  final List<List<int>> channelData;
}
