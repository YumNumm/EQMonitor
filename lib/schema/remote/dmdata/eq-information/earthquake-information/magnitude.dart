// ## 地震の規模(マグニチュード)

import 'package:eqmonitor/utils/extension/japanese_string.dart';

import 'magnitude/magnitude_condition.dart';

class Magnitude {
  Magnitude({
    required this.type,
    required this.unit,
    required this.value,
    required this.condition,
  });

  Magnitude.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value =
            (j['value'] == null) ? null : double.parse(j['value'].toString()),
        condition = (j['condition'] == null)
            ? null
            : MagnitudeCondition.values.firstWhere(
                (element) =>
                    element.description ==
                    j['condition'].toString().alphanumericToHalfLength(),
                orElse: () => MagnitudeCondition.unknown,
              );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'unit': unit,
        'value': value,
        'condition': condition?.description,
      };

  /// `マグニチュード`で固定
  final String type;

  /// マグニチュードの種別。`Mj`または`M`が入る
  final String unit;

  /// マグニチュードの数値。不明時またはM8以上の巨大地震と推測される場合は`Null`とする
  final double? value;

  /// マグニチュードの数値が求まらない事項を記載。`Ｍ不明`又は`Ｍ８を超える巨大地震`が入る
  final MagnitudeCondition? condition;
}
