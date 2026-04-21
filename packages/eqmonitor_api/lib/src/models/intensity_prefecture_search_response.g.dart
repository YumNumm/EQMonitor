// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_prefecture_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityPrefectureSearchResponse _$IntensityPrefectureSearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityPrefectureSearchResponse',
  json,
  ($checkedConvert) {
    final val = _IntensityPrefectureSearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map(
              (e) => IntensityPrefectureSearchItem.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$IntensityPrefectureSearchResponseToJson(
  _IntensityPrefectureSearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': ?instance.nextToken,
  'next_pooling': ?instance.nextPooling,
};
