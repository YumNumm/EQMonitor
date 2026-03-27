// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_item_arrival_time_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime
_$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime',
  json,
  ($checkedConvert) {
    final val =
        EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime(
          type: $checkedConvert('type', (v) => v),
          value: $checkedConvert('value', (v) => DateTime.parse(v as String)),
          $type: $checkedConvert('runtimeType', (v) => v as String?),
        );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeToJson(
  EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime instance,
) => <String, dynamic>{
  'type': instance.type,
  'value': instance.value.toIso8601String(),
  'runtimeType': instance.$type,
};

EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived
_$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived',
  json,
  ($checkedConvert) {
    final val =
        EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived(
          type: $checkedConvert('type', (v) => v),
          $type: $checkedConvert('runtimeType', (v) => v as String?),
        );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedToJson(
  EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived instance,
) => <String, dynamic>{'type': instance.type, 'runtimeType': instance.$type};
