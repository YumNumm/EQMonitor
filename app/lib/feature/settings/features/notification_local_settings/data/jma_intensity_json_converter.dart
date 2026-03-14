import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:json_annotation/json_annotation.dart';

/// JSON で JmaIntensity を enum 名で保存するための Converter
class JmaIntensityJsonConverter extends JsonConverter<JmaIntensity?, String?> {
  const JmaIntensityJsonConverter();

  @override
  JmaIntensity? fromJson(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    for (final e in JmaIntensity.values) {
      if (e.name == value) {
        return e;
      }
    }
    return null;
  }

  @override
  String? toJson(JmaIntensity? value) => value?.name;
}
