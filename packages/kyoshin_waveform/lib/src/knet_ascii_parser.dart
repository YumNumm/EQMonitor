import 'dart:typed_data';

import 'package:kyoshin_waveform/src/kyoshin_raw_channel.dart';
import 'package:kyoshin_waveform/src/kyoshin_waveform_component.dart';

final class const KnetAsciiParser() {
  static const _headerLineCount = 17;
  static const _labelWidth = 18;
  static const _jstOffset = Duration(hours: 9);

  KyoshinRawChannel parse(String source) {
    final lines = source.split('\n');
    if (lines.length < _headerLineCount) {
      throw const FormatException('K-NET ASCII header is too short');
    }
    final header = [
      for (var i = 0; i < _headerLineCount; i++) _value(lines[i]),
    ];
    return KyoshinRawChannel(
      stationCode: header[5],
      stationLatitude: double.parse(header[6]),
      stationLongitude: double.parse(header[7]),
      stationHeightMeters: double.parse(header[8]),
      recordTime: _parseJst(header[9]),
      samplingRate: int.parse(header[10].replaceAll(RegExp('[Hh][Zz]'), '')),
      component: KyoshinWaveformComponent.fromDirection(header[12]),
      scaleFactor: _parseScaleFactor(header[13]),
      maxAccelerationGal: double.parse(header[14]),
      counts: _parseCounts(lines),
    );
  }

  String _value(String line) =>
      line.length > _labelWidth ? line.substring(_labelWidth).trim() : '';

  // ヘッダの時刻は JST。アプリは UTC で扱うため、ここで UTC に直す。
  DateTime _parseJst(String value) {
    final match = RegExp(
      r'^(\d{4})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2})$',
    ).firstMatch(value);
    if (match == null) {
      throw FormatException('Invalid K-NET ASCII time', value);
    }
    final fields = [for (var i = 1; i <= 6; i++) int.parse(match[i] ?? '')];
    return DateTime.utc(
      fields[0],
      fields[1],
      fields[2],
      fields[3],
      fields[4],
      fields[5],
    ).subtract(_jstOffset);
  }

  double _parseScaleFactor(String value) {
    final match = RegExp(
      r'^([\d.]+)\(gal\)/([\d.]+)$',
    ).firstMatch(value.replaceAll(' ', ''));
    if (match == null) {
      throw FormatException('Invalid K-NET ASCII scale factor', value);
    }
    return double.parse(match[1] ?? '') / double.parse(match[2] ?? '');
  }

  Int32List _parseCounts(List<String> lines) {
    final counts = <int>[];
    final separator = RegExp(r'\s+');
    for (var i = _headerLineCount; i < lines.length; i++) {
      for (final token in lines[i].trim().split(separator)) {
        if (token.isNotEmpty) {
          counts.add(int.parse(token));
        }
      }
    }
    return Int32List.fromList(counts);
  }
}
