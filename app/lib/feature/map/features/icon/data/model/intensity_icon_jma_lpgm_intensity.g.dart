// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon_jma_lpgm_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityIconJmaLpgmIntensity _$IntensityIconJmaLpgmIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityIconJmaLpgmIntensity', json, ($checkedConvert) {
  final val = _IntensityIconJmaLpgmIntensity(
    filled: $checkedConvert(
      'filled',
      (v) => const MapJmaLpgmIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    small: $checkedConvert(
      'small',
      (v) => const MapJmaLpgmIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    smallWithoutText: $checkedConvert(
      'small_without_text',
      (v) => const MapJmaLpgmIntensityUint8ListJsonConverter().fromJson(
        v as Map<String, dynamic>,
      ),
    ),
  );
  return val;
}, fieldKeyMap: const {'smallWithoutText': 'small_without_text'});

Map<String, dynamic> _$IntensityIconJmaLpgmIntensityToJson(
  _IntensityIconJmaLpgmIntensity instance,
) => <String, dynamic>{
  'filled': const MapJmaLpgmIntensityUint8ListJsonConverter().toJson(
    instance.filled,
  ),
  'small': const MapJmaLpgmIntensityUint8ListJsonConverter().toJson(
    instance.small,
  ),
  'small_without_text': const MapJmaLpgmIntensityUint8ListJsonConverter()
      .toJson(instance.smallWithoutText),
};
