import 'package:eqmonitor/schema/dmdata/parameter-earthquake/parameter-earthquake.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter-earthquake_model.freezed.dart';

@freezed
class ParameterEarthquakeModel with _$ParameterEarthquakeModel {
  const factory ParameterEarthquakeModel({
    /// parameterEarthquake
    required ParameterEarthquake? parameterEarthquake,

    /// ロードされたかどうか
    required bool isMapLoaded,

    /// 読み込みにかかった時間
    required Duration? loadDuration,
  }) = _ParameterEarthquakeModel;
}
