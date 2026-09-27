import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_map_layer_parameter.freezed.dart';
part 'earthquake_history_map_layer_parameter.g.dart';

@freezed
abstract class EarthquakeHistoryMapLayerParameter
    with _$EarthquakeHistoryMapLayerParameter {
  const factory({
    // ズーム閾値
    // 市区町村ポリゴンは全ズームのタイルに存在する
    // (BaseMapTileSpec.cityMinZoom = 0) ので、これは見やすさの既定値。
    // 下限は EarthquakeHistoryMapLayerModeResolver が切り上げる。
    @Default(6) double regionToCity,
    @Default(6) double stationMinZoom,
    @Default(9) double stationLabelMinZoom,
    @Default(9) double stationTextZoom,
    @Default(8) double hypocenterFadeZoom,
    @Default(8) double hypocenterErrorMinZoom,

    // 塗りつぶし透明度
    @Default(0.6) double regionFillOpacity,
    @Default(0.8) double regionLineOpacity,
    @Default(0.6) double cityFillOpacity,

    // 観測点アイコンサイズ (icon-size interpolation)
    @Default(0.03) double stationIconSizeMin,
    @Default(0.13) double stationIconSizeMid,
    @Default(0.5) double stationIconSizeMax,

    // 震央マーカー
    @Default(0.15) double hypocenterIconSizeMin,
    @Default(0.4) double hypocenterIconSizeMax,
    @Default(0.6) double hypocenterFadeOpacity,
  }) = _EarthquakeHistoryMapLayerParameter;

  factory fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerParameterFromJson(json);
}
