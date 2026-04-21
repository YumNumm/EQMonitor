// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_dispatch_summary_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminDispatchSummaryDetailResponse
_$AdminDispatchSummaryDetailResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AdminDispatchSummaryDetailResponse', json, (
      $checkedConvert,
    ) {
      final val = _AdminDispatchSummaryDetailResponse(
        item: $checkedConvert(
          'item',
          (v) => Item.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AdminDispatchSummaryDetailResponseToJson(
  _AdminDispatchSummaryDetailResponse instance,
) => <String, dynamic>{'item': instance.item};
