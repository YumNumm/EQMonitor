// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_map_image_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityMapImageGroup _$IntensityMapImageGroupFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityMapImageGroup',
  json,
  ($checkedConvert) {
    final val = _IntensityMapImageGroup(
      telegramId: $checkedConvert('telegram_id', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      images: $checkedConvert(
        'images',
        (v) => (v as List<dynamic>)
            .map(
              (e) => IntensityMapImageItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'telegramId': 'telegram_id', 'createdAt': 'created_at'},
);

Map<String, dynamic> _$IntensityMapImageGroupToJson(
  _IntensityMapImageGroup instance,
) => <String, dynamic>{
  'telegram_id': instance.telegramId,
  'created_at': instance.createdAt.toIso8601String(),
  'images': instance.images,
};
