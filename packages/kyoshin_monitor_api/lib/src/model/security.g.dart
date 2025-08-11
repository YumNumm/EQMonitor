// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'security.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Security _$SecurityFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Security', json, ($checkedConvert) {
      final val = _Security(
        realm: $checkedConvert('realm', (v) => v as String?),
        hash: $checkedConvert('hash', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SecurityToJson(_Security instance) => <String, dynamic>{
  'realm': instance.realm,
  'hash': instance.hash,
};
