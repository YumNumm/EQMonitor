// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_array_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
