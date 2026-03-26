// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiDetail _$TsunamiDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiDetail', json, ($checkedConvert) {
      final val = _TsunamiDetail(
        id: $checkedConvert('id', (v) => v as String),
        eventIds: $checkedConvert(
          'event_ids',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        telegrams: $checkedConvert(
          'telegrams',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TsunamiTelegramHeaderOnlyItem.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventIds': 'event_ids'});

Map<String, dynamic> _$TsunamiDetailToJson(_TsunamiDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_ids': instance.eventIds,
      'telegrams': instance.telegrams,
    };
