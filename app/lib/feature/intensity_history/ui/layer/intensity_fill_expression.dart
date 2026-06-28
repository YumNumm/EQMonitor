import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';

/// `['match', ['get', propertyKey], code1, color1, ..., 'rgba(0,0,0,0)']` 形式の
/// MapLibre match 式を構築する純粋関数。
///
/// [pairs] に指定した各 code に [IntensityColorModel] から算出した震度背景色を
/// 割り当てる。該当なし区域は透明(`rgba(0,0,0,0)`)。
///
/// [propertyKey] はフィーチャの照合に使うプロパティ名。
/// - `areaForecastLocalE`(細分区域): `code`(デフォルト)。
/// - `areaInformationCityQuake`(市区町村): `regioncode`。
///   (`earthquake_history_fill_layer.dart` の `cityCodeFilter` 参照)
///
/// `earthquake_history_region_intensity_layer.dart` の `_buildFillColorExpression`
/// を純粋関数として切り出したもの。
List<Object> buildIntensityMatchExpression(
  List<({String code, JmaIntensity intensity})> pairs,
  IntensityColorModel colorModel, {
  String propertyKey = 'code',
}) {
  final args = <Object>[
    'match',
    <Object>['get', propertyKey],
  ];

  for (final pair in pairs) {
    args
      ..add(pair.code)
      ..add(
        colorModel.fromJmaIntensity(pair.intensity).background.toHexStringRGB(),
      );
  }

  // 該当なし区域は透明
  args.add('rgba(0,0,0,0)');
  return args;
}
