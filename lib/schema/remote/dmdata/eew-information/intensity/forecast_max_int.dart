
import 'package:eqmonitor/ui/theme/jma_intensity.dart';

/// 最大予測震度を記載する
class ForecastMaxInt {
  ForecastMaxInt({
    required this.from,
    required this.to,
  });

  ForecastMaxInt.fromJson(Map<String, dynamic> j)
      : from = JmaIntensity.values.firstWhere(
          (element) => element.name == j['from'].toString(),
          orElse: () => JmaIntensity.Error,
        ),
        to = JmaIntensity.values.firstWhere(
          (element) => element.name == j['to'].toString(),
          orElse: () => JmaIntensity.Error,
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'from': from.name,
        'to': to.name,
      };

  @override
  String toString() {
    if (to == JmaIntensity.over) {
      // 程度以上
      return '震度${from.name}程度以上';
    } else {
      return '震度${to.name}';
    }
  }

  int toValue() {
    if (to == JmaIntensity.over) {
      return from.intValue;
    } else {
      return to.intValue;
    }
  }

  final JmaIntensity from;
  final JmaIntensity to;
}
