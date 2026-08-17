import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_jma_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_jma_lpgm_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_icon_data.freezed.dart';
part 'intensity_icon_data.g.dart';

@freezed
abstract class IntensityIconData with _$IntensityIconData {
  const factory IntensityIconData({
    required IntensityIconJmaIntensity jmaIntensity,
    required IntensityIconJmaLpgmIntensity lpgmIntensity,
  }) = _IntensityIconData;

  factory IntensityIconData.fromJson(Map<String, dynamic> json) =>
      _$IntensityIconDataFromJson(json);
}
