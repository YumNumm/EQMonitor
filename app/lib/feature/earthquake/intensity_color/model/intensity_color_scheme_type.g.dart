// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_scheme_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Predefined _$PredefinedFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Predefined', json, ($checkedConvert) {
      final val = _Predefined(
        scheme: $checkedConvert(
          'scheme',
          (v) => $enumDecode(_$PredefinedSchemeEnumMap, v),
        ),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$PredefinedToJson(_Predefined instance) =>
    <String, dynamic>{
      'scheme': _$PredefinedSchemeEnumMap[instance.scheme]!,
      'runtimeType': instance.$type,
    };

const _$PredefinedSchemeEnumMap = {
  PredefinedScheme.eqmonitor: 'eqmonitor',
  PredefinedScheme.jma: 'jma',
  PredefinedScheme.earthQuickly: 'earthQuickly',
  PredefinedScheme.nhk: 'nhk',
};

_Custom _$CustomFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Custom', json, ($checkedConvert) {
      final val = _Custom(
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$CustomToJson(_Custom instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};
