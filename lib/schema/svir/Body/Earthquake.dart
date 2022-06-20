

import 'Hypocenter.dart';
import 'accuracy.dart';

/// 震源情報
/// `Body > Earthquake`
class SvirBodyEarthquake {
  SvirBodyEarthquake({
    required this.originTime,
    required this.hypocenter,
    required this.accuracy,
    required this.magnitude,
  });
  SvirBodyEarthquake.fromJson(Map<String, dynamic> j)
      : originTime = DateTime.parse(j['OriginTime'].toString()),
        hypocenter = SvirBodyEQHypocenter.fromJson(
          j['Hypocenter'] as Map<String, dynamic>,
        ),
        accuracy = Accuracy.fromJson(j['Accuracy'] as Map<String, dynamic>),
        magnitude = (j['Magnitude'].toString() == '/./')
            ? null
            : double.tryParse(j['Magnitude'].toString());

  /// 発生時刻
  final DateTime originTime;

  /// 震源要素
  final SvirBodyEQHypocenter hypocenter;

  /// 精度情報
  /// `Accuracy`
  final Accuracy accuracy;

  /// マグニチュード
  final double? magnitude;
}
