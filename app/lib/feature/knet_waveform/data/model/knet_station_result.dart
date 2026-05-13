import 'dart:math';

import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 1観測点の CSV パース結果 + 計測震度
class KnetStationResult {
  const KnetStationResult({
    required this.filename,
    required this.record,
    required this.rawInt,
  });

  final String filename;
  final KnetCsvRecord record;

  /// JMA 計測震度（小数第1位まで）
  final double rawInt;

  KnetStationInfo? get stationInfo => record.stationInfo;
  String get stationCode => stationInfo?.stationCode ?? filename;

  /// 最大加速度 (gal) — NS/EW/UD の合成最大値
  double get maxAccelGal {
    var maxSq = 0.0;
    for (final pt in record.dataPoints) {
      var sq = 0.0;
      for (final a in pt.accelerationsGal) {
        sq += a * a;
      }
      if (sq > maxSq) {
        maxSq = sq;
      }
    }
    return maxSq > 0 ? sqrt(maxSq) : 0.0;
  }
}
