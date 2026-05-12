import 'package:knet_waveform_parser/src/ascii/knet_ascii_parser.dart';
import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:knet_waveform_parser/src/model/knet_network_type.dart';
import 'package:knet_waveform_parser/src/model/knet_record.dart';

/// K-NET CSV フォーマットパーサ
///
/// K-NET CSV は物理値（gal）を直接記録した形式。
/// ヘッダ部（震源情報・観測点情報・オフセット情報・カラムヘッダ）と
/// データ部（時刻、相対時刻、各チャンネルの加速度）で構成される。
class KnetCsvParser {
  const KnetCsvParser();

  /// CSV テキストを [KnetCsvRecord] にパースする
  KnetCsvRecord parse(String source) {
    final lines = source.split('\n').map((l) => l.trim()).toList();

    try {
      KnetEarthquakeInfo? earthquakeInfo;
      KnetStationInfo? stationInfo;
      List<double>? offsets;
      List<String>? columnNames;
      var dataStartLine = 0;

      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.startsWith('OriginTime')) {
          earthquakeInfo = _parseEarthquakeInfoBlock(lines, i);
        } else if (line.startsWith('Code')) {
          stationInfo = _parseStationInfoBlock(lines, i);
        } else if (line.startsWith('Offset')) {
          final parts = line.split(',');
          offsets = parts.skip(1).map((p) => double.parse(p.trim())).toList();
        } else if (line.startsWith('Time,')) {
          columnNames = line.split(',').map((p) => p.trim()).toList();
          dataStartLine = i + 1;
          break;
        }
      }

      if (columnNames == null) {
        throw const KnetParseException('CSV header not found');
      }

      final dataPoints = <KnetCsvDataPoint>[];
      for (var i = dataStartLine; i < lines.length; i++) {
        final line = lines[i];
        if (line.isEmpty) {
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

      final channels = columnNames.skip(2).map((name) {
        switch (name.toUpperCase()) {
          case 'NS(GAL)':
          case 'NS':
            return KnetChannelDirection.ns;
          case 'EW(GAL)':
          case 'EW':
            return KnetChannelDirection.ew;
          case 'UD(GAL)':
          case 'UD':
            return KnetChannelDirection.ud;
          default:
            return KnetChannelDirection.ns;
        }
      }).toList();

      double? samplingFreqHz;
      if (dataPoints.length >= 2) {
        final dt =
            dataPoints[1].relativeTimeSec - dataPoints[0].relativeTimeSec;
        if (dt > 0) {
          samplingFreqHz = 1.0 / dt;
        }
      }

      final networkType = _detectNetworkType(channels.length);

      return KnetCsvRecord(
        earthquakeInfo: earthquakeInfo,
        stationInfo: stationInfo,
        offsets: offsets ?? [],
        channelDirections: channels,
        dataPoints: dataPoints,
        samplingFrequencyHz: samplingFreqHz ?? 100.0,
        networkType: networkType,
      );
    } on KnetParseException {
      rethrow;
    } on Exception catch (e, st) {
      throw KnetParseException('Failed to parse K-NET CSV: $e', st);
    }
  }

  KnetEarthquakeInfo? _parseEarthquakeInfoBlock(
    List<String> lines,
    int start,
  ) {
    final values = <String, String>{};
    for (var i = start; i < lines.length && i < start + 10; i++) {
      final line = lines[i];
      if (!line.contains(',')) {
        break;
      }
      final idx = line.indexOf(',');
      final key = line.substring(0, idx).trim();
      final value = line.substring(idx + 1).trim();
      values[key] = value;
      if (key == 'Magnitude') {
        break;
      }
    }

    if (!values.containsKey('OriginTime')) {
      return null;
    }

    try {
      final originTime = _parseCsvDateTime(values['OriginTime']!);
      final lat = double.parse(values['Latitude'] ?? '0');
      final lon = double.parse(values['Longitude'] ?? '0');
      final depth = double.parse(
        (values['Depth(km)'] ?? '0').split(' ').first,
      );
      final mag = double.parse(values['Magnitude'] ?? '0');

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

  KnetStationInfo? _parseStationInfoBlock(List<String> lines, int start) {
    final values = <String, String>{};
    for (var i = start; i < lines.length && i < start + 10; i++) {
      final line = lines[i];
      if (!line.contains(',')) {
        break;
      }
      final idx = line.indexOf(',');
      final key = line.substring(0, idx).trim();
      final value = line.substring(idx + 1).trim();
      values[key] = value;
      if (key.startsWith('Height')) {
        break;
      }
    }

    if (!values.containsKey('Code')) {
      return null;
    }

    try {
      final code = values['Code'] ?? '';
      final lat = double.parse(values['Latitude'] ?? '0');
      final lon = double.parse(values['Longitude'] ?? '0');
      final heightKey = values.keys.firstWhere(
        (k) => k.startsWith('Height'),
        orElse: () => '',
      );
      final height = double.parse(values[heightKey] ?? '0');

      return KnetStationInfo(
        stationCode: code,
        latitude: lat,
        longitude: lon,
        heightM: height,
      );
    } on FormatException {
      return null;
    }
  }

  /// "YYYY/MM/DD-HH:MM:SS" 形式をパース
  DateTime _parseCsvDateTime(String s) {
    final parts = s.split('-');
    if (parts.length < 2) {
      throw FormatException('Cannot parse CSV datetime: $s');
    }
    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      int.parse(timeParts[2]),
    );
  }

  DateTime _parseDateTime(String s) {
    if (s.contains('-') && !s.contains(' ')) {
      return _parseCsvDateTime(s);
    }
    final parts = s.split(' ');
    if (parts.length < 2) {
      throw FormatException('Cannot parse datetime: $s');
    }
    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
      int.parse(timeParts[2]),
    );
  }

  KnetNetworkType _detectNetworkType(int channelCount) {
    return channelCount >= 6 ? KnetNetworkType.kiknet : KnetNetworkType.knet;
  }
}

/// K-NET CSV 1データポイント
class KnetCsvDataPoint {
  const KnetCsvDataPoint({
    required this.time,
    required this.relativeTimeSec,
    required this.accelerationsGal,
  });

  /// 絶対時刻（JST）
  final DateTime time;

  /// 記録開始からの相対時刻 (秒)
  final double relativeTimeSec;

  /// 各チャンネルの加速度 (gal)
  final List<double> accelerationsGal;
}

/// K-NET CSV パース結果
class KnetCsvRecord {
  const KnetCsvRecord({
    required this.earthquakeInfo,
    required this.stationInfo,
    required this.offsets,
    required this.channelDirections,
    required this.dataPoints,
    required this.samplingFrequencyHz,
    required this.networkType,
  });

  final KnetEarthquakeInfo? earthquakeInfo;
  final KnetStationInfo? stationInfo;
  final List<double> offsets;
  final List<KnetChannelDirection> channelDirections;
  final List<KnetCsvDataPoint> dataPoints;
  final double samplingFrequencyHz;
  final KnetNetworkType networkType;
}
