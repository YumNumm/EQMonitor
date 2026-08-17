import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_icon_jma_lpgm_intensity.freezed.dart';
part 'intensity_icon_jma_lpgm_intensity.g.dart';

@freezed
abstract class IntensityIconJmaLpgmIntensity
    with _$IntensityIconJmaLpgmIntensity {
  const factory({
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> filled,
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> small,
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> smallWithoutText,
  }) = _IntensityIconJmaLpgmIntensity;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityIconJmaLpgmIntensityFromJson(json);
}
