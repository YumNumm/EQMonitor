// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'socket_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocketStatusModelImpl _$$SocketStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$SocketStatusModelImpl',
      json,
      ($checkedConvert) {
        final val = _$SocketStatusModelImpl(
          connected: $checkedConvert('connected', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$SocketStatusModelImplToJson(
        _$SocketStatusModelImpl instance) =>
    <String, dynamic>{
      'connected': instance.connected,
    };
