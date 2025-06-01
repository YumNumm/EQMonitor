// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intensity_color_scheme_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PredefinedImpl _$$PredefinedImplFromJson(Map<String, dynamic> json) =>
    _$PredefinedImpl(
      scheme: $enumDecode(_$PredefinedSchemeEnumMap, json['scheme']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PredefinedImplToJson(_$PredefinedImpl instance) =>
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

_$CustomImpl _$$CustomImplFromJson(Map<String, dynamic> json) => _$CustomImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomImplToJson(_$CustomImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };