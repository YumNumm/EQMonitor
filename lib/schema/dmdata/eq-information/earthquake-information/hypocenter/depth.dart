import '../../../../../extension/japanese_string.dart';
import 'depth/depth_condition.dart';

/// ## 震源の深さ
class Depth {
  Depth({
    required this.type,
    required this.unit,
    required this.value,
    required this.condition,
  });

  Depth.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value = (j['value'] == null) ? null : int.parse(j['value'].toString()),
        condition = (j['condition'] == null)
            ? null
            : DepthCondition.values.firstWhere(
                (element) =>
                    element.description ==
                    j['condition'].toString().alphanumericToHalfLength(),
              );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'unit': unit,
        'value': value,
        'condition': condition?.description,
      };

  /// 深さ情報のタイプ。`深さ`で固定
  final String type;

  /// 深さ情報の単位。`km`で固定
  final String unit;

  /// 震源の深さ。不明時は`Null`とする
  final int? value;

  /// 深さの例外的表現。取りうる値は`ごく浅い`、`７００ｋｍ以上`,`不明`
  final DepthCondition? condition;
}
