// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewListResponse _$EewListResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewListResponse',
      json,
      ($checkedConvert) {
        final val = _EewListResponse(
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map(
                  (e) =>
                      EewItemWithRelations.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          nextToken: $checkedConvert('next_token', (v) => v as String?),
          nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'nextToken': 'next_token',
        'nextPooling': 'next_pooling',
      },
    );

Map<String, dynamic> _$EewListResponseToJson(_EewListResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next_token': instance.nextToken,
      'next_pooling': instance.nextPooling,
    };

_EewArrayResponse _$EewArrayResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewArrayResponse', json, ($checkedConvert) {
      final val = _EewArrayResponse(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => EewItemWithRelations.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EewArrayResponseToJson(_EewArrayResponse instance) =>
    <String, dynamic>{'items': instance.items};

_EewLatestResponse _$EewLatestResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewLatestResponse', json, ($checkedConvert) {
      final val = _EewLatestResponse(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => EewItemWithRelations.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EewLatestResponseToJson(_EewLatestResponse instance) =>
    <String, dynamic>{'items': instance.items};
