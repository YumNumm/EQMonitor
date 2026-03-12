// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_item_arrival_time_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EewIntensityItemArrivalTimeUnionEewArrivalTimeTime
_$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EewIntensityItemArrivalTimeUnionEewArrivalTimeTime',
  json,
  ($checkedConvert) {
    final val = EewIntensityItemArrivalTimeUnionEewArrivalTimeTime(
      type: $checkedConvert('type', (v) => v),
      value: $checkedConvert('value', (v) => DateTime.parse(v as String)),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic> _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeToJson(
  EewIntensityItemArrivalTimeUnionEewArrivalTimeTime instance,
) => <String, dynamic>{
  'type': instance.type,
  'value': instance.value.toIso8601String(),
  'runtimeType': instance.$type,
};

EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived
_$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived',
  json,
  ($checkedConvert) {
    final val = EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived(
      type: $checkedConvert('type', (v) => v),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedToJson(
  EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived instance,
) => <String, dynamic>{'type': instance.type, 'runtimeType': instance.$type};
