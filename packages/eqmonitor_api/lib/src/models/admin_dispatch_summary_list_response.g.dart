// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_dispatch_summary_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminDispatchSummaryListResponse _$AdminDispatchSummaryListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AdminDispatchSummaryListResponse', json, (
  $checkedConvert,
) {
  final val = _AdminDispatchSummaryListResponse(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => DispatchSummaryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AdminDispatchSummaryListResponseToJson(
  _AdminDispatchSummaryListResponse instance,
) => <String, dynamic>{'items': instance.items};
