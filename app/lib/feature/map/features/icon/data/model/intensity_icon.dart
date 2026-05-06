import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_icon.freezed.dart';
part 'intensity_icon.g.dart';

enum IntensityIconType {
  filled,
  small,
  smallWithoutText,
}

@freezed
abstract class IntensityIconData with _$IntensityIconData {
  const factory IntensityIconData({
    required IntensityIconJmaIntensity jmaIntensity,
    required IntensityIconJmaLpgmIntensity lpgmIntensity,
  }) = _IntensityIconData;

  factory IntensityIconData.fromJson(Map<String, dynamic> json) =>
      _$IntensityIconDataFromJson(json);
}

@freezed
abstract class IntensityIconJmaIntensity with _$IntensityIconJmaIntensity {
  const factory IntensityIconJmaIntensity({
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> filled,
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> small,
    @MapJmaIntensityUint8ListJsonConverter()
    required Map<JmaIntensity, Uint8List> smallWithoutText,
  }) = _IntensityIconJmaIntensity;

  factory IntensityIconJmaIntensity.fromJson(Map<String, dynamic> json) =>
      _$IntensityIconJmaIntensityFromJson(json);
}

@freezed
abstract class IntensityIconJmaLpgmIntensity
    with _$IntensityIconJmaLpgmIntensity {
  const factory IntensityIconJmaLpgmIntensity({
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> filled,
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> small,
    @MapJmaLpgmIntensityUint8ListJsonConverter()
    required Map<JmaLpgmIntensity, Uint8List> smallWithoutText,
  }) = _IntensityIconJmaLpgmIntensity;

  factory IntensityIconJmaLpgmIntensity.fromJson(Map<String, dynamic> json) =>
      _$IntensityIconJmaLpgmIntensityFromJson(json);
}

class MapJmaIntensityUint8ListJsonConverter
    implements
        JsonConverter<Map<JmaIntensity, Uint8List>, Map<String, dynamic>> {
  const MapJmaIntensityUint8ListJsonConverter();

  @override
  Map<JmaIntensity, Uint8List> fromJson(Map<String, dynamic> json) =>
      Map<JmaIntensity, Uint8List>.from(
        json.map(
          (key, value) => MapEntry(
            JmaIntensity.values.byName(key),
            Uint8List.fromList(value as List<int>),
          ),
        ),
      );

  @override
  Map<String, dynamic> toJson(Map<JmaIntensity, Uint8List> object) =>
      object.map((key, value) => MapEntry(key.name, value.toList()));
}

class MapJmaLpgmIntensityUint8ListJsonConverter
    implements
        JsonConverter<Map<JmaLpgmIntensity, Uint8List>, Map<String, dynamic>> {
  const MapJmaLpgmIntensityUint8ListJsonConverter();

  @override
  Map<JmaLpgmIntensity, Uint8List> fromJson(Map<String, dynamic> json) =>
      Map<JmaLpgmIntensity, Uint8List>.from(
        json.map(
          (key, value) => MapEntry(
            JmaLpgmIntensity.values.byName(key),
            Uint8List.fromList(value as List<int>),
          ),
        ),
      );

  @override
  Map<String, dynamic> toJson(Map<JmaLpgmIntensity, Uint8List> object) =>
      object.map((key, value) => MapEntry(key.name, value.toList()));
}
