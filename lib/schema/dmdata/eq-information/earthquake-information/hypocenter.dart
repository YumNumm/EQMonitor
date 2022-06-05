
import '../../alphabet_extension.dart';

import 'hypocenter/auxiliary.dart';
import 'hypocenter/coordinate_component.dart';
import 'hypocenter/depth.dart';
import 'hypocenter/detailed.dart';
import 'hypocenter/hypo_center_source.dart';
class HypoCenter {
  HypoCenter({
    required this.name,
    required this.code,
    required this.coordinateComponent,
    required this.depth,
    required this.detailed,
    required this.auxiliary,
    required this.source,
  });

  HypoCenter.fromJson(Map<String, dynamic> j)
      : name = j['name'].toString(),
        code = int.parse(j['code'].toString()),
        depth = Depth.fromJson(j['depth'] as Map<String, dynamic>),
        coordinateComponent = CoordinateComponent.fromJson(
          j['coordinate'] as Map<String, dynamic>,
        ),
        detailed = (j['detailed'] == null)
            ? null
            : Detailed.fromJson(j['detailed'] as Map<String, dynamic>),
        auxiliary = (j['auxiliary'] == null)
            ? null
            : Auxiliary.fromJson(j['auxiliary'] as Map<String, dynamic>),
        source = (j['source'] == null)
            ? null
            : HypoCenterSource.values.firstWhere(
                (element) =>
                    element.description ==
                    j['source'].toString().alphanumericToHalfLength(),
              );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'code': code,
        'depth': depth.toJson(),
        'coordinate': coordinateComponent.toJson(),
        'detailed': detailed?.toJson(),
        'auxiliary': auxiliary?.toJson(),
        'source': source?.description,
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
  /// [#3.4.depth](https://dmdata.jp/doc/reference/conversion/json/component/#3-4-depth)を参照
  final Depth depth;

  /// ##震源地の詳細
  /// [#3.5.detailed](https://dmdata.jp/doc/reference/conversion/json/component/#3-5-detailed)を参照
  final Detailed? detailed;

  /// 震源位置の補足情報 [#3.6.auxiliary](https://dmdata.jp/doc/reference/conversion/json/component/#3-6-auxiliary)を参照
  final Auxiliary? auxiliary;

  /// 震源・規模のデータソース。取りうる値は`ＵＳＧＳ`,`ＰＴＷＣ`,`ＷＣＡＴＷＣ`
  /// 遠地地震で、気象庁以外が震源決定した場合に出現
  final HypoCenterSource? source;
}
