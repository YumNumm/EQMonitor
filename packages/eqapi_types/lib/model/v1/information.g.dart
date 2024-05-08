// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InformationV1Impl _$$InformationV1ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$InformationV1Impl',
      json,
      ($checkedConvert) {
        final val = _$InformationV1Impl(
          author: $checkedConvert(
              'author',
              (v) =>
                  $enumDecodeNullable(_$InformationAuthorEnumMap, v,
                      unknownValue: InformationAuthor.unknown) ??
                  InformationAuthor.unknown),
          body: $checkedConvert('body', (v) => v as Map<String, dynamic>),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          level: $checkedConvert(
              'level',
              (v) =>
                  $enumDecodeNullable(_$InformationLevelEnumMap, v,
                      unknownValue: InformationLevel.info) ??
                  InformationLevel.info),
          title: $checkedConvert('title', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$InformationV1ImplToJson(_$InformationV1Impl instance) =>
    <String, dynamic>{
      'author': _$InformationAuthorEnumMap[instance.author]!,
      'body': instance.body,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'level': _$InformationLevelEnumMap[instance.level]!,
      'title': instance.title,
      'type': instance.type,
    };

const _$InformationAuthorEnumMap = {
  InformationAuthor.jma: 'jma',
  InformationAuthor.developer: 'developer',
  InformationAuthor.unknown: 'unknown',
};

const _$InformationLevelEnumMap = {
  InformationLevel.info: 'info',
  InformationLevel.warning: 'warning',
  InformationLevel.critical: 'critical',
};
