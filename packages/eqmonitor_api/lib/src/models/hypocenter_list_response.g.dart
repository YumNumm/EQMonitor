// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterListResponse _$HypocenterListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HypocenterListResponse', json, ($checkedConvert) {
  final val = _HypocenterListResponse(
    data: $checkedConvert(
      'data',
      (v) => Data3.fromJson(v as Map<String, dynamic>),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => HypocenterMeta.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$HypocenterListResponseToJson(
  _HypocenterListResponse instance,
) => <String, dynamic>{'data': instance.data, 'meta': instance.meta};
