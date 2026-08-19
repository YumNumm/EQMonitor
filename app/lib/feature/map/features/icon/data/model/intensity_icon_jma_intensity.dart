import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_icon_jma_intensity.freezed.dart';
part 'intensity_icon_jma_intensity.g.dart';

@freezed
abstract class IntensityIconJmaIntensity with _$IntensityIconJmaIntensity {
  const factory({
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> filled,
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> small,
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> smallWithoutText,
  }) = _IntensityIconJmaIntensity;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityIconJmaIntensityFromJson(json);
}
