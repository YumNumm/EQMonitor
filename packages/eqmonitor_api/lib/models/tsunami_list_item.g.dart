// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiListItem _$TsunamiListItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiListItem', json, ($checkedConvert) {
      final val = _TsunamiListItem(
        id: $checkedConvert('id', (v) => v as String),
        eventIds: $checkedConvert(
          'event_ids',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventIds': 'event_ids'});

Map<String, dynamic> _$TsunamiListItemToJson(_TsunamiListItem instance) =>
    <String, dynamic>{'id': instance.id, 'event_ids': instance.eventIds};
