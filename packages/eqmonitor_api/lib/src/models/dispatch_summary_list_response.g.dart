// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'dispatch_summary_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DispatchSummaryListResponse _$DispatchSummaryListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DispatchSummaryListResponse', json, ($checkedConvert) {
  final val = _DispatchSummaryListResponse(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => Items3.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DispatchSummaryListResponseToJson(
  _DispatchSummaryListResponse instance,
) => <String, dynamic>{'items': instance.items};
