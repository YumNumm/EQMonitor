// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'socket_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SocketStatusModel _$$_SocketStatusModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_SocketStatusModel',
      json,
      ($checkedConvert) {
        final val = _$_SocketStatusModel(
          connected: $checkedConvert('connected', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_SocketStatusModelToJson(
        _$_SocketStatusModel instance) =>
    <String, dynamic>{
      'connected': instance.connected,
    };
