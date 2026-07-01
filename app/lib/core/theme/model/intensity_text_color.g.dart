// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_text_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntensityTextColorAuto _$IntensityTextColorAutoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('IntensityTextColorAuto', json, ($checkedConvert) {
  final val = IntensityTextColorAuto(
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$IntensityTextColorAutoToJson(
  IntensityTextColorAuto instance,
) => <String, dynamic>{'type': instance.$type};

IntensityTextColorManual _$IntensityTextColorManualFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('IntensityTextColorManual', json, ($checkedConvert) {
  final val = IntensityTextColorManual(
    color: $checkedConvert(
      'color',
      (v) => const ColorJsonConverter().fromJson(v as String),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$IntensityTextColorManualToJson(
  IntensityTextColorManual instance,
) => <String, dynamic>{
  'color': const ColorJsonConverter().toJson(instance.color),
  'type': instance.$type,
};
