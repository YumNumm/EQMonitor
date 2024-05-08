// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kmoni_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KmoniConfigImpl _$$KmoniConfigImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KmoniConfigImpl',
      json,
      ($checkedConvert) {
        final val = _$KmoniConfigImpl(
          counter: $checkedConvert('counter', (v) => (v as num?)?.toInt() ?? 0),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KmoniConfigImplToJson(_$KmoniConfigImpl instance) =>
    <String, dynamic>{
      'counter': instance.counter,
    };
