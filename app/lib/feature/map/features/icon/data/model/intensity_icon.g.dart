// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityIconData _$IntensityIconDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityIconData',
      json,
      ($checkedConvert) {
        final val = _IntensityIconData(
          jmaIntensity: $checkedConvert(
            'jma_intensity',
            (v) =>
                IntensityIconJmaIntensity.fromJson(v as Map<String, dynamic>),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => IntensityIconJmaLpgmIntensity.fromJson(
              v as Map<String, dynamic>,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'jmaIntensity': 'jma_intensity',
        'lpgmIntensity': 'lpgm_intensity',
      },
    );

Map<String, dynamic> _$IntensityIconDataToJson(_IntensityIconData instance) =>
    <String, dynamic>{
      'jma_intensity': instance.jmaIntensity,
      'lpgm_intensity': instance.lpgmIntensity,
    };

_IntensityIconJmaIntensity _$IntensityIconJmaIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityIconJmaIntensity',
  json,
  ($checkedConvert) {
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
  },
  fieldKeyMap: const {'smallWithoutText': 'small_without_text'},
);

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

_IntensityIconJmaLpgmIntensity _$IntensityIconJmaLpgmIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityIconJmaLpgmIntensity',
  json,
  ($checkedConvert) {
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
  },
  fieldKeyMap: const {'smallWithoutText': 'small_without_text'},
);

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
