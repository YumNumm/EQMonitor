import '../../eq-information/earthquake-information/hypocenter/coordinate_component.dart';
import 'accuracy.dart';
import 'depth.dart';
import 'reduce.dart';

class HypoCenter {
  HypoCenter({
    required this.name,
    required this.code,
    required this.coordinateComponent,
    required this.depth,
    required this.reduce,
    required this.landOrSea,
    required this.accuracy,
  });

  factory HypoCenter.fromJson(Map<String, dynamic> j) => HypoCenter(
        code: int.parse(j['code'].toString()),
        name: j['name'].toString(),
        coordinateComponent: CoordinateComponent.fromJson(
          j['coordinate'] as Map<String, dynamic>,
        ),
        depth: Depth.fromJson(j['depth'] as Map<String, dynamic>),
        reduce: Reduce.fromJson(j['reduce'] as Map<String, dynamic>),
        landOrSea: j['landOrSea']?.toString(),
        accuracy: Accuracy.fromJson(j['accuracy'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
        'coordinate': coordinateComponent.toJson(),
        'depth': depth.toJson(),
        'reduce': reduce.toJson(),
        'landOrSea': landOrSea,
        'accuracy': accuracy.toJson(),
      };

  /// ## 震央地名
  final String name;

  /// ## 震央地名コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ## 震源地の空間座標
  /// [#Coordinate component](https://dmdata.jp/doc/reference/conversion/json/component/#coordinate-component)を参照
  final CoordinateComponent coordinateComponent;

  /// ## 深さ情報
  /// [#7.4 depth](https://dmdata.jp/doc/reference/conversion/json/schema/eew-information#7-4-4-depth)を参照
  final Depth depth;

  /// 短縮用震央地名
  /// [#7.4.5 reduce](https://dmdata.jp/doc/reference/conversion/json/schema/eew-information#7-4-5-reduce)
  final Reduce reduce;

  /// 震源の場所が陸域か海域かを判別する、取りうる値は `内陸`,`海域`
  final String? landOrSea;

  /// 震源及びマグニチュードの計算精度情報
  /// [#7.4.7. reduce](https://dmdata.jp/doc/reference/conversion/json/schema/eew-information#7-4-7-accuracy)を参照
  final Accuracy accuracy;
}
