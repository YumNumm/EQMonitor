import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MapJmaIntensityUint8ListJsonConverter
    implements
        JsonConverter<Map<JmaIntensity, Uint8List>, Map<String, dynamic>> {
  const new();

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
  const new();

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
