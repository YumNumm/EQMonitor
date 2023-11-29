// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'information_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InformationV3ResultImpl _$$InformationV3ResultImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$InformationV3ResultImpl',
      json,
      ($checkedConvert) {
        final val = _$InformationV3ResultImpl(
          results: $checkedConvert(
              'results',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          InformationV3.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          success: $checkedConvert('success', (v) => v as bool),
          meta: $checkedConvert('meta',
              (v) => D1DbExecutionResult.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$InformationV3ResultImplToJson(
        _$InformationV3ResultImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
      'success': instance.success,
      'meta': instance.meta,
    };

_$InformationV3Impl _$$InformationV3ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$InformationV3Impl',
      json,
      ($checkedConvert) {
        final val = _$InformationV3Impl(
          id: $checkedConvert('id', (v) => v as int),
          title: $checkedConvert('title', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
          author: $checkedConvert(
              'author',
              (v) => $enumDecode(_$AuthorEnumMap, v,
                  unknownValue: Author.unknown)),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
          level: $checkedConvert('level',
              (v) => $enumDecode(_$LevelEnumMap, v, unknownValue: Level.info)),
          tag: $checkedConvert('tag', (v) => tagFromString(v as String)),
          eventId: $checkedConvert('eventId', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$InformationV3ImplToJson(_$InformationV3Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'author': _$AuthorEnumMap[instance.author]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'level': _$LevelEnumMap[instance.level]!,
      'tag': tagToString(instance.tag),
      'eventId': instance.eventId,
    };

const _$AuthorEnumMap = {
  Author.developer: 'developer',
  Author.jma: 'jma',
  Author.unknown: 'unknown',
};

const _$LevelEnumMap = {
  Level.info: 'info',
  Level.warning: 'warning',
  Level.danger: 'danger',
};
