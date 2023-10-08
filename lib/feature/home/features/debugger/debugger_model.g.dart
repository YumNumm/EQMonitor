// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'debugger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DebuggerModel _$$_DebuggerModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_DebuggerModel',
      json,
      ($checkedConvert) {
        final val = _$_DebuggerModel(
          isDebugger: $checkedConvert('isDebugger', (v) => v as bool? ?? false),
          isDeveloper:
              $checkedConvert('isDeveloper', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_DebuggerModelToJson(_$_DebuggerModel instance) =>
    <String, dynamic>{
      'isDebugger': instance.isDebugger,
      'isDeveloper': instance.isDeveloper,
    };
