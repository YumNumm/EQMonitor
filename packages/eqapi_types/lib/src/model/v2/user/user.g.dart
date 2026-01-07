// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_User', json, ($checkedConvert) {
      final val = _User(id: $checkedConvert('id', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
};
