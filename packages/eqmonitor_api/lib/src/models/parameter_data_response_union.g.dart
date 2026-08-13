// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_data_response_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterDataResponseUnionJmaCodeTableParameter
_$ParameterDataResponseUnionJmaCodeTableParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ParameterDataResponseUnionJmaCodeTableParameter', json, (
  $checkedConvert,
) {
  final val = ParameterDataResponseUnionJmaCodeTableParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => JmaCodeTableParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    codeTables: $checkedConvert(
      'code_tables',
      (v) =>
          JmaCodeTableParameterCodeTables.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'codeTables': 'code_tables', r'$type': 'runtimeType'});

Map<String, dynamic> _$ParameterDataResponseUnionJmaCodeTableParameterToJson(
  ParameterDataResponseUnionJmaCodeTableParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'code_tables': instance.codeTables,
  'runtimeType': instance.$type,
};

ParameterDataResponseUnionKyoshinObservationPointsParameter
_$ParameterDataResponseUnionKyoshinObservationPointsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ParameterDataResponseUnionKyoshinObservationPointsParameter',
  json,
  ($checkedConvert) {
    final val = ParameterDataResponseUnionKyoshinObservationPointsParameter(
      metadata: $checkedConvert(
        'metadata',
        (v) => KyoshinObservationPointsParameterMetadata.fromJson(
          v as Map<String, dynamic>,
        ),
      ),
      points: $checkedConvert(
        'points',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  KyoshinObservationPoint.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$ParameterDataResponseUnionKyoshinObservationPointsParameterToJson(
  ParameterDataResponseUnionKyoshinObservationPointsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'points': instance.points,
  'runtimeType': instance.$type,
};

ParameterDataResponseUnionEarthquakeStationsParameter
_$ParameterDataResponseUnionEarthquakeStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ParameterDataResponseUnionEarthquakeStationsParameter',
  json,
  ($checkedConvert) {
    final val = ParameterDataResponseUnionEarthquakeStationsParameter(
      metadata: $checkedConvert(
        'metadata',
        (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>)
            .map(
              (e) => EarthquakeStationPrefecture.fromJson(
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

Map<String, dynamic>
_$ParameterDataResponseUnionEarthquakeStationsParameterToJson(
  ParameterDataResponseUnionEarthquakeStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'prefectures': instance.prefectures,
  'runtimeType': instance.$type,
};

ParameterDataResponseUnionTsunamiStationsParameter
_$ParameterDataResponseUnionTsunamiStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ParameterDataResponseUnionTsunamiStationsParameter',
  json,
  ($checkedConvert) {
    final val = ParameterDataResponseUnionTsunamiStationsParameter(
      metadata: $checkedConvert(
        'metadata',
        (v) => TsunamiStationsParameterMetadata.fromJson(
          v as Map<String, dynamic>,
        ),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  TsunamiStationPrefecture.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$ParameterDataResponseUnionTsunamiStationsParameterToJson(
  ParameterDataResponseUnionTsunamiStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'prefectures': instance.prefectures,
  'runtimeType': instance.$type,
};

ParameterDataResponseUnionShindoDbStationsParameter
_$ParameterDataResponseUnionShindoDbStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ParameterDataResponseUnionShindoDbStationsParameter',
  json,
  ($checkedConvert) {
    final val = ParameterDataResponseUnionShindoDbStationsParameter(
      metadata: $checkedConvert(
        'metadata',
        (v) => ShindoDbStationsParameterMetadata.fromJson(
          v as Map<String, dynamic>,
        ),
      ),
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>)
            .map((e) => ShindoDbStation.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$ParameterDataResponseUnionShindoDbStationsParameterToJson(
  ParameterDataResponseUnionShindoDbStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'stations': instance.stations,
  'runtimeType': instance.$type,
};
