// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'item.dart';

part 'admin_dispatch_summary_detail_response.freezed.dart';
part 'admin_dispatch_summary_detail_response.g.dart';

@Freezed()
abstract class AdminDispatchSummaryDetailResponse with _$AdminDispatchSummaryDetailResponse {
  const factory AdminDispatchSummaryDetailResponse({
    required Item item,
  }) = _AdminDispatchSummaryDetailResponse;
  
  factory AdminDispatchSummaryDetailResponse.fromJson(Map<String, Object?> json) => _$AdminDispatchSummaryDetailResponseFromJson(json);
}
