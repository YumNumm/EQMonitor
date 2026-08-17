import 'package:knet_waveform_parser/src/ascii/knet_ascii_parser.dart';
import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:knet_waveform_parser/src/model/knet_network_type.dart';
import 'package:knet_waveform_parser/src/model/knet_record.dart';

/// K-NET CSV フォーマットパーサ
///
/// K-NET CSV は物理値（gal）を直接記録した形式。
/// `#` プレフィックスのコメント行でヘッダを記述し、
/// `#` なしのデータ行に時刻・相対時刻・各チャンネルの加速度が格納される。
class KnetCsvParser {
  const new();

  /// CSV テキストを [KnetCsvRecord] にパースする
  KnetCsvRecord parse(String source) {
    final lines = source.split('\n').map((l) => l.trim()).toList();

    try {
      KnetEarthquakeInfo? earthquakeInfo;
      KnetStationInfo? stationInfo;
      var offsets = <double>[];
      var channelDirections = <KnetChannelDirection>[];
      double? samplingFreqHz;
      double? durationSec;
      var dataStartLine = 0;

      var i = 0;
      while (i < lines.length) {
        final line = lines[i];

        if (line == '#Event') {
          // 次の行: カラムヘッダ "#OriginTime,..."
          // その次の行: 値 "#2011/03/11 14:46:00,..."
          if (i + 2 < lines.length) {
            final valueLine = lines[i + 2];
            if (valueLine.startsWith('#')) {
              earthquakeInfo = _parseEventLine(valueLine.substring(1).trim());
            }
          }
        } else if (line == '#Station') {
          // 次の行: カラムヘッダ "#Code,..."
          // その次の行: 値 "#AIC001,..."
          if (i + 2 < lines.length) {
            final valueLine = lines[i + 2];
            if (valueLine.startsWith('#')) {
              stationInfo = _parseStationLine(valueLine.substring(1).trim());
            }
          }
        } else if (line == '#SamplingFrequency(Hz)') {
          if (i + 1 < lines.length) {
            final valueLine = lines[i + 1];
            if (valueLine.startsWith('#')) {
              samplingFreqHz =
                  double.tryParse(valueLine.substring(1).trim()) ?? 100.0;
            }
          }
        } else if (line == '#DurationTime(s)') {
          if (i + 1 < lines.length) {
            final valueLine = lines[i + 1];
            if (valueLine.startsWith('#')) {
              durationSec = double.tryParse(valueLine.substring(1).trim());
            }
          }
        } else if (line == '#Offset') {
          // 次の行: チャンネル名 "#N-S(gal),E-W(gal),U-D(gal)"
          // その次の行: オフセット値 "#0.00,0.00,0.00"
          if (i + 2 < lines.length) {
            final valueLine = lines[i + 2];
            if (valueLine.startsWith('#')) {
              offsets = valueLine
                  .substring(1)
                  .split(',')
                  .map((p) => double.tryParse(p.trim()) ?? 0.0)
                  .toList();
            }
          }
        } else if (line.startsWith('#Time,')) {
          // カラムヘッダ行: "#Time,RelativeTime(s),N-S(gal),E-W(gal),U-D(gal)"
          final cols = line
              .substring(1)
              .split(',')
              .map((c) => c.trim())
              .toList();
          channelDirections = _parseChannelDirections(cols.skip(2).toList());
          dataStartLine = i + 1;
          break;
        }

        i++;
      }

      // データ部をパース
      final dataPoints = <KnetCsvDataPoint>[];
      for (var j = dataStartLine; j < lines.length; j++) {
        final line = lines[j];
        if (line.isEmpty || line.startsWith('#')) {
          continue;
        }
        final parts = line.split(',');
        if (parts.length < 2) {
          continue;
        }

        final time = _parseDateTime(parts[0].trim());
        final relativeTimeSec = double.parse(parts[1].trim());
        final accelerations = parts
            .skip(2)
            .map((p) => double.parse(p.trim()))
            .toList();

        dataPoints.add(
          KnetCsvDataPoint(
            time: time,
            relativeTimeSec: relativeTimeSec,
            accelerationsGal: accelerations,
          ),
        );
      }

      // サンプリング周波数の推定（明示されていない場合）
      if (samplingFreqHz == null && dataPoints.length >= 2) {
        final dt =
            dataPoints[1].relativeTimeSec - dataPoints[0].relativeTimeSec;
        if (dt > 0) {
          samplingFreqHz = 1.0 / dt;
        }
      }

      final networkType = _detectNetworkType(channelDirections.length);

      return KnetCsvRecord(
        earthquakeInfo: earthquakeInfo,
        stationInfo: stationInfo,
        offsets: offsets,
        channelDirections: channelDirections,
        dataPoints: dataPoints,
        samplingFrequencyHz: samplingFreqHz ?? 100.0,
        durationTimeSec: durationSec,
        networkType: networkType,
      );
    } on KnetParseException {
      rethrow;
    } on Exception catch (e, st) {
      throw KnetParseException('Failed to parse K-NET CSV: $e', st);
    }
  }

  /// イベント行をパース: "2011/03/11 14:46:00,38.103,142.860,24,9.0"
  KnetEarthquakeInfo? _parseEventLine(String line) {
    final parts = line.split(',');
    if (parts.length < 5) {
      return null;
    }
    try {
      return KnetEarthquakeInfo(
        originTime: _parseDateTime(parts[0].trim()),
        latitude: double.parse(parts[1].trim()),
        longitude: double.parse(parts[2].trim()),
        depthKm: double.parse(parts[3].trim()),
        magnitude: double.parse(parts[4].trim()),
      );
    } on FormatException {
      return null;
    }
  }

  /// 観測点行をパース: "AIC001,35.2974,136.7505,5"
  KnetStationInfo? _parseStationLine(String line) {
    final parts = line.split(',');
    if (parts.length < 4) {
      return null;
    }
    try {
      return KnetStationInfo(
        stationCode: parts[0].trim(),
        latitude: double.parse(parts[1].trim()),
        longitude: double.parse(parts[2].trim()),
        heightM: double.parse(parts[3].trim()),
      );
    } on FormatException {
      return null;
    }
  }

  /// チャンネル方向をカラム名リストからパース
  /// 例: ["N-S(gal)", "E-W(gal)", "U-D(gal)"] → [ns, ew, ud]
  List<KnetChannelDirection> _parseChannelDirections(List<String> cols) =>
      cols.map((name) {
        final upper = name.toUpperCase();
        if (upper.startsWith('N-S') || upper.startsWith('NS')) {
          return upper.contains('2')
              ? KnetChannelDirection.ns2
              : KnetChannelDirection.ns;
        } else if (upper.startsWith('E-W') || upper.startsWith('EW')) {
          return upper.contains('2')
              ? KnetChannelDirection.ew2
              : KnetChannelDirection.ew;
        } else if (upper.startsWith('U-D') || upper.startsWith('UD')) {
          return upper.contains('2')
              ? KnetChannelDirection.ud2
              : KnetChannelDirection.ud;
        }
        return KnetChannelDirection.ns;
      }).toList();

  /// "YYYY/MM/DD HH:MM:SS.ss" または "YYYY/MM/DD HH:MM:SS" 形式をパース
  DateTime _parseDateTime(String s) {
    final parts = s.split(' ');
    if (parts.length < 2) {
      throw FormatException('Cannot parse datetime: $s');
    }
    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

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

  KnetNetworkType _detectNetworkType(int channelCount) {
    return channelCount >= 6 ? KnetNetworkType.kiknet : KnetNetworkType.knet;
  }
}

/// K-NET CSV 1データポイント
class KnetCsvDataPoint {
  const new({
    required this.time,
    required this.relativeTimeSec,
    required this.accelerationsGal,
  });

  /// 絶対時刻（JST）
  final DateTime time;

  /// 記録開始からの相対時刻（秒）
  final double relativeTimeSec;

  /// 各チャンネルの加速度（gal）
  final List<double> accelerationsGal;
}

/// K-NET CSV パース結果
class KnetCsvRecord {
  const new({
    required this.earthquakeInfo,
    required this.stationInfo,
    required this.offsets,
    required this.channelDirections,
    required this.dataPoints,
    required this.samplingFrequencyHz,
    required this.durationTimeSec,
    required this.networkType,
  });

  final KnetEarthquakeInfo? earthquakeInfo;
  final KnetStationInfo? stationInfo;
  final List<double> offsets;
  final List<KnetChannelDirection> channelDirections;
  final List<KnetCsvDataPoint> dataPoints;
  final double samplingFrequencyHz;
  final double? durationTimeSec;
  final KnetNetworkType networkType;
}
