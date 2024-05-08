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
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>)
                  .map((e) => InformationV3.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$InformationV3ResultImplToJson(
        _$InformationV3ResultImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

_$InformationV3Impl _$$InformationV3ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$InformationV3Impl',
      json,
      ($checkedConvert) {
        final val = _$InformationV3Impl(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
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
          eventId: $checkedConvert('event_id', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'eventId': 'event_id'},
    );

Map<String, dynamic> _$$InformationV3ImplToJson(_$InformationV3Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'author': _$AuthorEnumMap[instance.author]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'level': _$LevelEnumMap[instance.level]!,
      'event_id': instance.eventId,
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
