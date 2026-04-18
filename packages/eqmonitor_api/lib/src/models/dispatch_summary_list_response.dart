// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'items3.dart';

part 'dispatch_summary_list_response.freezed.dart';
part 'dispatch_summary_list_response.g.dart';

@Freezed()
abstract class DispatchSummaryListResponse with _$DispatchSummaryListResponse {
  const factory DispatchSummaryListResponse({
    required List<Items3> items,
  }) = _DispatchSummaryListResponse;

  factory DispatchSummaryListResponse.fromJson(Map<String, Object?> json) =>
      _$DispatchSummaryListResponseFromJson(json);
}
