// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_body_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelegramBodyUnionEarthquakeTelegramBody
_$TelegramBodyUnionEarthquakeTelegramBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TelegramBodyUnionEarthquakeTelegramBody',
      json,
      ($checkedConvert) {
        final val = TelegramBodyUnionEarthquakeTelegramBody(
          type: $checkedConvert('type', (v) => v as String),
          earthquake: $checkedConvert(
            'earthquake',
            (v) => v == null
                ? null
                : EarthquakeTelegramBodyQuake.fromJson(
                    v as Map<String, dynamic>,
                  ),
          ),
          intensityRegions: $checkedConvert(
            'intensityRegions',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
          intensityPrefectures: $checkedConvert(
            'intensityPrefectures',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
          intensityCities: $checkedConvert(
            'intensityCities',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
          intensityStations: $checkedConvert(
            'intensityStations',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => EarthquakeTelegramBodyIntensityStation.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
          $type: $checkedConvert('runtimeType', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {r'$type': 'runtimeType'},
    );

Map<String, dynamic> _$TelegramBodyUnionEarthquakeTelegramBodyToJson(
  TelegramBodyUnionEarthquakeTelegramBody instance,
) => <String, dynamic>{
  'type': instance.type,
  'earthquake': ?instance.earthquake,
  'intensityRegions': ?instance.intensityRegions,
  'intensityPrefectures': ?instance.intensityPrefectures,
  'intensityCities': ?instance.intensityCities,
  'intensityStations': ?instance.intensityStations,
  'runtimeType': instance.$type,
};

TelegramBodyUnionEewTelegramBody _$TelegramBodyUnionEewTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TelegramBodyUnionEewTelegramBody',
  json,
  ($checkedConvert) {
    final val = TelegramBodyUnionEewTelegramBody(
      type: $checkedConvert('type', (v) => v as String),
      eew: $checkedConvert('eew', (v) => v),
      eewIntensityRegions: $checkedConvert(
        'eewIntensityRegions',
        (v) => v as List<dynamic>,
      ),
      eewWarningZones: $checkedConvert(
        'eewWarningZones',
        (v) => v as List<dynamic>,
      ),
      eewWarningPrefectures: $checkedConvert(
        'eewWarningPrefectures',
        (v) => v as List<dynamic>,
      ),
      eewWarningRegions: $checkedConvert(
        'eewWarningRegions',
        (v) => v as List<dynamic>,
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$TelegramBodyUnionEewTelegramBodyToJson(
  TelegramBodyUnionEewTelegramBody instance,
) => <String, dynamic>{
  'type': instance.type,
  'eew': instance.eew,
  'eewIntensityRegions': instance.eewIntensityRegions,
  'eewWarningZones': instance.eewWarningZones,
  'eewWarningPrefectures': instance.eewWarningPrefectures,
  'eewWarningRegions': instance.eewWarningRegions,
  'runtimeType': instance.$type,
};

TelegramBodyUnionEarthquakeNoticeTelegramBody
_$TelegramBodyUnionEarthquakeNoticeTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TelegramBodyUnionEarthquakeNoticeTelegramBody',
  json,
  ($checkedConvert) {
    final val = TelegramBodyUnionEarthquakeNoticeTelegramBody(
      type: $checkedConvert('type', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$TelegramBodyUnionEarthquakeNoticeTelegramBodyToJson(
  TelegramBodyUnionEarthquakeNoticeTelegramBody instance,
) => <String, dynamic>{'type': instance.type, 'runtimeType': instance.$type};

TelegramBodyUnionEarthquakeExplanationTelegramBody
_$TelegramBodyUnionEarthquakeExplanationTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TelegramBodyUnionEarthquakeExplanationTelegramBody',
  json,
  ($checkedConvert) {
    final val = TelegramBodyUnionEarthquakeExplanationTelegramBody(
      type: $checkedConvert('type', (v) => v as String),
      text: $checkedConvert('text', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$TelegramBodyUnionEarthquakeExplanationTelegramBodyToJson(
  TelegramBodyUnionEarthquakeExplanationTelegramBody instance,
) => <String, dynamic>{
  'type': instance.type,
  'text': instance.text,
  'runtimeType': instance.$type,
};

TelegramBodyUnionEarthquakeCountsTelegramBody
_$TelegramBodyUnionEarthquakeCountsTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TelegramBodyUnionEarthquakeCountsTelegramBody',
  json,
  ($checkedConvert) {
    final val = TelegramBodyUnionEarthquakeCountsTelegramBody(
      type: $checkedConvert('type', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$TelegramBodyUnionEarthquakeCountsTelegramBodyToJson(
  TelegramBodyUnionEarthquakeCountsTelegramBody instance,
) => <String, dynamic>{'type': instance.type, 'runtimeType': instance.$type};

TelegramBodyUnionEarthquakeNankaiTelegramBody
_$TelegramBodyUnionEarthquakeNankaiTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TelegramBodyUnionEarthquakeNankaiTelegramBody',
  json,
  ($checkedConvert) {
    final val = TelegramBodyUnionEarthquakeNankaiTelegramBody(
      type: $checkedConvert('type', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$TelegramBodyUnionEarthquakeNankaiTelegramBodyToJson(
  TelegramBodyUnionEarthquakeNankaiTelegramBody instance,
) => <String, dynamic>{'type': instance.type, 'runtimeType': instance.$type};
