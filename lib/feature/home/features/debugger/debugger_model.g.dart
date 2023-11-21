// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
          isDebugger: $checkedConvert('isDebugger', (v) => v as bool? ?? false),
          isDeveloper:
              $checkedConvert('isDeveloper', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$DebuggerModelImplToJson(_$DebuggerModelImpl instance) =>
    <String, dynamic>{
      'isDebugger': instance.isDebugger,
      'isDeveloper': instance.isDeveloper,
    };
