// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Result _$ResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Result', json, ($checkedConvert) {
      final val = _Result(
        status: $checkedConvert('status', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
};
