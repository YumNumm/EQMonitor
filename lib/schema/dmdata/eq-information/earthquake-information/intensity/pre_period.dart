import 'preperiod/periodic_band.dart';
import 'sva.dart';

class PrePeriod {
  PrePeriod({
    required this.periodicBand,
    required this.lpgmInt,
    required this.sva,
  });
  PrePeriod.fromJson(Map<String, dynamic> j)
      : periodicBand =
            PeriodicBand.fromJson(j['periodicBand'] as Map<String, dynamic>),
        lpgmInt = j['lpgmInt'].toString(),
        sva = SVA.fromJson(j['sva'] as Map<String, dynamic>);

  /// ## 対象とする周期帯を記載する
  final PeriodicBand periodicBand;

  /// ## 対象とする周期帯における長周期地震動階級`0`,`1`,`2`,`3`,`4`で記載する
  final String lpgmInt;

  /// ## 対象とする周期帯における絶対応答スペクトルを記載する
  final SVA sva;
}
