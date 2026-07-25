import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_map_layer_parameter.freezed.dart';
part 'earthquake_history_map_layer_parameter.g.dart';

@freezed
abstract class EarthquakeHistoryMapLayerParameter
    with _$EarthquakeHistoryMapLayerParameter {
  const factory EarthquakeHistoryMapLayerParameter({
    // ズーム閾値
    @Default(0) double regionToCity,
    @Default(8) double stationMinZoom,
    @Default(9) double stationLabelMinZoom,
    @Default(9) double stationTextZoom,
    @Default(8) double hypocenterFadeZoom,
    @Default(8) double hypocenterErrorMinZoom,

    // 塗りつぶし透明度
    @Default(0.6) double regionFillOpacity,
    @Default(0.8) double regionLineOpacity,
    @Default(0.6) double cityFillOpacity,

    // 観測点サイズ (circle-radius interpolation)
    @Default(2) double stationCircleRadiusMin,
    @Default(8) double stationCircleRadiusMax,

    // 観測点アイコンサイズ (icon-size interpolation)
    @Default(0.025) double stationIconSizeMin,
    @Default(0.18) double stationIconSizeMid,
    @Default(0.6) double stationIconSizeMax,

    // 震央マーカー
    @Default(0.15) double hypocenterIconSizeMin,
    @Default(0.4) double hypocenterIconSizeMax,
    @Default(0.6) double hypocenterFadeOpacity,
  }) = _EarthquakeHistoryMapLayerParameter;

  factory EarthquakeHistoryMapLayerParameter.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeHistoryMapLayerParameterFromJson(json);
}
