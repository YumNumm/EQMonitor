// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'dispatch_summary_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DispatchSummaryDetailResponse _$DispatchSummaryDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DispatchSummaryDetailResponse', json, ($checkedConvert) {
  final val = _DispatchSummaryDetailResponse(
    item: $checkedConvert(
      'item',
      (v) => Item2.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$DispatchSummaryDetailResponseToJson(
  _DispatchSummaryDetailResponse instance,
) => <String, dynamic>{'item': instance.item};
