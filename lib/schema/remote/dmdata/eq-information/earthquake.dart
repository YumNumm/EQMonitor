import 'earthquake-information/hypocenter.dart';
import 'earthquake-information/magnitude.dart';

/// ## Earthquake component
/// 地震情報・津波情報における地震の発生位置、規模を記載。
class EarthQuakeInformationComponent {
  EarthQuakeInformationComponent({
    required this.originTime,
    required this.arrivalTime,
    required this.hypoCenter,
    required this.magnitude,
  });

  factory EarthQuakeInformationComponent.fromJson(Map<String, dynamic> j) =>
      EarthQuakeInformationComponent(
        originTime: DateTime.parse(j['originTime'].toString()),
        arrivalTime: DateTime.parse(j['arrivalTime'].toString()),
        hypoCenter: HypoCenter.fromJson(
          j['hypocenter'] as Map<String, dynamic>,
        ),
        magnitude: Magnitude.fromJson(j['magnitude'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'originTime': originTime.toIso8601String(),
        'arraivalTime': arrivalTime.toIso8601String(),
        'hypocenter': hypoCenter.toJson(),
        'magnitude': magnitude.toJson(),
      };

  /// 地震発生時刻を分単位で、ISO8601の日本時間で記載する
  final DateTime originTime;

  /// 地震検知時刻を分単位で、ISO8601の日本時間で記載する
  final DateTime arrivalTime;

  /// 地震の震源要素
  /// [#3. hypocenter](https://dmdata.jp/doc/reference/conversion/json/component/#3-hypocenter)
  final HypoCenter hypoCenter;

  /// 地震の規模
  /// [#4. magnitude](https://dmdata.jp/doc/reference/conversion/json/component/#4-magnitude)
  final Magnitude magnitude;
}
