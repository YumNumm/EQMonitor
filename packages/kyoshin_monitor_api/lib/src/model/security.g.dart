// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'security.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityImpl _$$SecurityImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$SecurityImpl', json, (
  $checkedConvert,
) {
  final val = _$SecurityImpl(
    realm: $checkedConvert('realm', (v) => v as String?),
    hash: $checkedConvert('hash', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$$SecurityImplToJson(
  _$SecurityImpl instance,
) => <String, dynamic>{
  'realm': instance.realm,
  'hash': instance.hash,
};
