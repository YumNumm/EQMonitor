import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_area_info.freezed.dart';
part 'intensity_area_info.g.dart';

/// 地域震度情報（都道府県・地域・市区町村共通）
@freezed
abstract class IntensityAreaInfo with _$IntensityAreaInfo {
  const factory IntensityAreaInfo({
    required String code,
    required String name,
    required JmaIntensity? intensity,
    required JmaLpgmIntensity? lpgmIntensity,
  }) = _IntensityAreaInfo;

  factory IntensityAreaInfo.fromJson(Map<String, dynamic> json) =>
      _$IntensityAreaInfoFromJson(json);
}
