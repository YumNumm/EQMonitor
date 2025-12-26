// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedResponseMeta _$PaginatedResponseMetaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PaginatedResponseMeta',
  json,
  ($checkedConvert) {
    final val = _PaginatedResponseMeta(
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$PaginatedResponseMetaToJson(
  _PaginatedResponseMeta instance,
) => <String, dynamic>{
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};
