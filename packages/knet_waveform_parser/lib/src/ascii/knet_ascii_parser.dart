import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:knet_waveform_parser/src/model/knet_network_type.dart';
import 'package:knet_waveform_parser/src/model/knet_record.dart';

/// K-NET ASCII フォーマットパーサ
///
/// K-NET ASCII フォーマットは 17 行のヘッダと 18 行目以降のデータで構成される。
/// 各ヘッダ行のラベルフィールドは固定幅（最大18文字）で、
/// 19文字目以降（0-indexed では位置18以降）が値フィールドになる。
class KnetAsciiParser {
  const KnetAsciiParser();

  /// ASCII テキストを [KnetRecord] にパースする
  ///
  /// [source] K-NET ASCII フォーマットのテキスト
  /// Throws [KnetParseException] on parse failure
  KnetRecord parse(String source) {
    final lines = source.split('\n');
    if (lines.length < 17) {
      throw KnetParseException(
        'Invalid K-NET ASCII format: expected at least 17 header lines, '
        'got ${lines.length}',
      );
    }

    try {
      final originTimeStr = _extractValue(lines[0]);
      final latStr = _extractValue(lines[1]);
      final lonStr = _extractValue(lines[2]);
      final depthStr = _extractValue(lines[3]);
      final magStr = _extractValue(lines[4]);
      final stationCode = _extractValue(lines[5]);
      final stationLatStr = _extractValue(lines[6]);
      final stationLonStr = _extractValue(lines[7]);
      final stationHeightStr = _extractValue(lines[8]);
      final recordTimeStr = _extractValue(lines[9]);
      final samplingFreqStr = _extractValue(lines[10]);
      final durationStr = _extractValue(lines[11]);
      final dirStr = _extractValue(lines[12]);
      final scaleFactorStr = _extractValue(lines[13]);
      final maxAccStr = _extractValue(lines[14]);
      final lastCorrectionStr = _extractValue(lines[15]);
      // 17行目（index 16）はメモ行。値フィールドが空の場合もある
      final memo = _extractValue(lines[16]);

      final earthquakeInfo = _parseEarthquakeInfo(
        originTimeStr,
        latStr,
        lonStr,
        depthStr,
        magStr,
      );

      final stationInfo = KnetStationInfo(
        stationCode: stationCode.trim(),
        latitude: double.parse(stationLatStr.trim()),
        longitude: double.parse(stationLonStr.trim()),
        heightM: double.parse(stationHeightStr.trim()),
      );

      final recordTime = _parseDateTime(recordTimeStr.trim());

      // "100Hz" -> 100.0
      final samplingFreq = double.parse(
        samplingFreqStr.trim().replaceAll(RegExp('[Hh][Zz]'), '').trim(),
      );

      final duration = double.parse(durationStr.trim().split(' ').first);

      final direction = KnetChannelDirection.fromString(dirStr.trim());

      // スケールファクタ: "(gal)/6291456" -> (1.0, 6291456.0)
      //                  "3920(gal)/6182761" -> (3920.0, 6182761.0)
      final scaleFactor = _parseScaleFactor(scaleFactorStr.trim());

      final maxAcc = double.parse(maxAccStr.trim().split(' ').first);

      DateTime? lastCorrection;
      final trimmedCorrection = lastCorrectionStr.trim();
      if (trimmedCorrection.isNotEmpty && trimmedCorrection != '-') {
        try {
          lastCorrection = _parseDateTime(trimmedCorrection);
        } on FormatException {
          // 補正時刻が不正な場合は null
        }
      }

      // データ部をパース（18行目以降）
      final rawData = <int>[];
      for (var i = 17; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) {
          continue;
        }
        final parts = line.split(RegExp(r'\s+'));
        for (final part in parts) {
          if (part.isEmpty) {
            continue;
          }
          rawData.add(int.parse(part));
        }
      }

      final networkType = _detectNetworkType(stationInfo.stationCode);

      return KnetRecord(
        earthquakeInfo: earthquakeInfo,
        stationInfo: stationInfo,
        recordTime: recordTime,
        samplingFrequencyHz: samplingFreq,
        durationTimeSec: duration,
        direction: direction,
        scaleFactorNumerator: scaleFactor.$1,
        scaleFactorDenominator: scaleFactor.$2,
        maxAccelerationGal: maxAcc,
        lastCorrection: lastCorrection,
        memo: memo.trim(),
        rawData: rawData,
        networkType: networkType,
      );
    } on KnetParseException {
      rethrow;
    } on Exception catch (e, st) {
      throw KnetParseException('Failed to parse K-NET ASCII: $e', st);
    }
  }

  /// ヘッダ行からラベル以降の値を抽出する
  ///
  /// K-NET ASCII の各ヘッダ行はラベルフィールド（最大18文字）+ 値フィールドの形式。
  /// ラベルが17文字の場合はその後に1スペースで値が続く。
  /// "Station Height(m) 5" → "5"
  /// "Origin Time       2011/03/11 14:46:00" → "2011/03/11 14:46:00"
  String _extractValue(String line) {
    const labelWidth = 18;
    if (line.length > labelWidth) {
      return line.substring(labelWidth).trim();
    }
    // フォールバック: 2スペース以上の区切りで分割
    final parts = line.split(RegExp(r'\s{2,}'));
    if (parts.length >= 2) {
      return parts.last;
    }
    return '';
  }

  KnetEarthquakeInfo? _parseEarthquakeInfo(
    String originTimeStr,
    String latStr,
    String lonStr,
    String depthStr,
    String magStr,
  ) {
    final trimmedOriginTime = originTimeStr.trim();
    if (trimmedOriginTime.isEmpty || trimmedOriginTime == '-') {
      return null;
    }

    try {
      final originTime = _parseDateTime(trimmedOriginTime);
      final lat = double.parse(latStr.trim());
      final lon = double.parse(lonStr.trim());
      final depth = double.parse(depthStr.trim().split(' ').first);
      final mag = double.parse(magStr.trim());

      return KnetEarthquakeInfo(
        originTime: originTime,
        latitude: lat,
        longitude: lon,
        depthKm: depth,
        magnitude: mag,
      );
    } on FormatException {
      return null;
    }
  }

  /// "YYYY/MM/DD HH:MM:SS" 形式の文字列を DateTime にパースする
  DateTime _parseDateTime(String s) {
    final cleaned = s.trim();
    final dateTimeParts = cleaned.split(' ');
    if (dateTimeParts.length < 2) {
      throw FormatException('Cannot parse datetime: $s');
    }
    final dateParts = dateTimeParts[0].split('/');
    final timeParts = dateTimeParts[1].split(':');
    if (dateParts.length < 3 || timeParts.length < 3) {
      throw FormatException('Cannot parse datetime: $s');
    }

    // 秒に小数部がある場合を処理（"14:48:19.00" → 19秒 0ミリ秒）
    final secParts = timeParts[2].split('.');
    final sec = int.parse(secParts[0]);
    final ms = secParts.length > 1
        ? (double.parse('0.${secParts[1]}') * 1000).round()
        : 0;

    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      sec,
      ms,
    );
  }

  /// スケールファクタ文字列をパース
  ///
  /// - "(gal)/6291456" → (1.0, 6291456.0)  分子 (gal) = 1 として扱う
  /// - "3920(gal)/6182761" → (3920.0, 6182761.0)
  /// - "3920/6162781(gal)" → (3920.0, 6162781.0)
  (double numerator, double denominator) _parseScaleFactor(String s) {
    // "(gal)" などの単位部分を除去
    final cleaned = s.replaceAll(RegExp(r'\(.*?\)'), '').trim();
    if (!cleaned.contains('/')) {
      if (cleaned.isEmpty) {
        return (1.0, 1.0);
      }
      return (double.parse(cleaned), 1.0);
    }
    final parts = cleaned.split('/');
    // 分子が空文字の場合は 1.0（"(gal)/6291456" → "/6291456" の分子部分が空）
    final numerator = parts[0].trim().isEmpty
        ? 1.0
        : double.parse(parts[0].trim());
    final denominator = double.parse(parts[1].trim());
    return (numerator, denominator);
  }

  KnetNetworkType _detectNetworkType(String stationCode) {
    return KnetNetworkType.knet;
  }
}

/// K-NET パースエラー
class KnetParseException implements Exception {
  const KnetParseException(this.message, [this.stackTrace]);
  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'KnetParseException: $message';
}
