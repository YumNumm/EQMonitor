// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'epicenter_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpicenterSearchItem _$EpicenterSearchItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EpicenterSearchItem', json, ($checkedConvert) {
      final val = _EpicenterSearchItem(
        eventId: $checkedConvert('event_id', (v) => v as String),
        epicenter: $checkedConvert(
          'epicenter',
          (v) => EpicenterInfo.fromJson(v as Map<String, dynamic>),
        ),
        earthquake: $checkedConvert(
          'earthquake',
          (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$EpicenterSearchItemToJson(
  _EpicenterSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'epicenter': instance.epicenter,
  'earthquake': instance.earthquake,
};
