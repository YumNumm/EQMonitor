// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'items.dart';

part 'admin_dispatch_summary_list_response.freezed.dart';
part 'admin_dispatch_summary_list_response.g.dart';

@Freezed()
abstract class AdminDispatchSummaryListResponse with _$AdminDispatchSummaryListResponse {
  const factory AdminDispatchSummaryListResponse({
    required List<Items> items,
  }) = _AdminDispatchSummaryListResponse;
  
  factory AdminDispatchSummaryListResponse.fromJson(Map<String, Object?> json) => _$AdminDispatchSummaryListResponseFromJson(json);
}
