// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'data3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data3 _$Data3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Data3', json, ($checkedConvert) {
      final val = _Data3(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    HypocenterResponseItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        nextToken: $checkedConvert('next_token', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'nextToken': 'next_token'});

Map<String, dynamic> _$Data3ToJson(_Data3 instance) => <String, dynamic>{
  'items': instance.items,
  'next_token': ?instance.nextToken,
};
