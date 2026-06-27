// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'item2.dart';

part 'dispatch_summary_detail_response.freezed.dart';
part 'dispatch_summary_detail_response.g.dart';

@Freezed()
abstract class DispatchSummaryDetailResponse with _$DispatchSummaryDetailResponse {
  const factory DispatchSummaryDetailResponse({
    required Item2 item,
  }) = _DispatchSummaryDetailResponse;
  
  factory DispatchSummaryDetailResponse.fromJson(Map<String, Object?> json) => _$DispatchSummaryDetailResponseFromJson(json);
}
