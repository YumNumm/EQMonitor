// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_latest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
