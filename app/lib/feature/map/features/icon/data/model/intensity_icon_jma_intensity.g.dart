// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon_jma_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityIconJmaIntensity _$IntensityIconJmaIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityIconJmaIntensity', json, ($checkedConvert) {
  final val = _IntensityIconJmaIntensity(
    filled: $checkedConvert(
      'filled',
      (v) => const MapJmaIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    small: $checkedConvert(
      'small',
      (v) => const MapJmaIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    smallWithoutText: $checkedConvert(
      'small_without_text',
      (v) => const MapJmaIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
  );
  return val;
}, fieldKeyMap: const {'smallWithoutText': 'small_without_text'});

Map<String, dynamic> _$IntensityIconJmaIntensityToJson(
  _IntensityIconJmaIntensity instance,
) => <String, dynamic>{
  'filled': const MapJmaIntensityUint8ListJsonConverter().toJson(
    instance.filled,
  ),
  'small': const MapJmaIntensityUint8ListJsonConverter().toJson(instance.small),
  'small_without_text': const MapJmaIntensityUint8ListJsonConverter().toJson(
    instance.smallWithoutText,
  ),
};
