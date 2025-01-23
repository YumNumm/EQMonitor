// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'debugger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DebuggerModelImpl _$$DebuggerModelImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$DebuggerModelImpl',
      json,
      ($checkedConvert) {
        final val = _$DebuggerModelImpl(
          isDebugger:
              $checkedConvert('is_debugger', (v) => v as bool? ?? false),
          isDeveloper:
              $checkedConvert('is_developer', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'isDebugger': 'is_debugger',
        'isDeveloper': 'is_developer'
      },
    );

Map<String, dynamic> _$$DebuggerModelImplToJson(_$DebuggerModelImpl instance) =>
    <String, dynamic>{
      'is_debugger': instance.isDebugger,
      'is_developer': instance.isDeveloper,
    };
