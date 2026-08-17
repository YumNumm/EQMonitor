import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';

/// `['match', ['get', propertyKey], code1, color1, ..., 'rgba(0,0,0,0)']` 形式の
/// MapLibre match 式を構築する純粋関数。
///
/// [pairs] に指定した各 code に [IntensityColors] から算出した震度背景色を
/// 割り当てる。該当なし区域は透明(`rgba(0,0,0,0)`)。
///
/// 同一 code が複数含まれる場合は最大震度側に畳み込む。MapLibre の match 式は
/// ラベルの重複を許容せず、1 件でも重複すると式全体が不正になりレイヤーが
/// 一切描画されないため、呼び出し側の入力に依らず必ず一意化する。
///
/// [propertyKey] はフィーチャの照合に使うプロパティ名。
/// - `areaForecastLocalE`(細分区域): `code`(デフォルト)。
/// - `areaInformationCityQuake`(市区町村): `regioncode`。
///   (`earthquake_history_fill_layer.dart` の `cityCodeFilter` 参照)
///
/// `earthquake_history_region_intensity_layer.dart` の `_buildFillColorExpression`
/// を純粋関数として切り出したもの。
class IntensityMatchExpressionBuilder {
  const new _();

  static List<Object> build(
    List<({String code, JmaIntensity intensity})> pairs,
    IntensityColors colorModel, {
    String propertyKey = 'code',
  }) {
    final intensityByCode = <String, JmaIntensity>{};
    for (final pair in pairs) {
      final current = intensityByCode[pair.code];
      if (current == null || pair.intensity.orderIndex > current.orderIndex) {
        intensityByCode[pair.code] = pair.intensity;
      }
    }

    final args = <Object>[
      'match',
      <Object>['get', propertyKey],
    ];

    for (final entry in intensityByCode.entries) {
      args
        ..add(entry.key)
        ..add(
          colorModel.fromJmaIntensity(entry.value).background.toHexStringRGB(),
        );
    }

    // 該当なし区域は透明
    args.add('rgba(0,0,0,0)');
    return args;
  }
}
