// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data3.dart';
import 'hypocenter_meta.dart';

part 'hypocenter_list_response.freezed.dart';
part 'hypocenter_list_response.g.dart';

@Freezed()
abstract class HypocenterListResponse with _$HypocenterListResponse {
  const factory HypocenterListResponse({
    required Data3 data,
    required HypocenterMeta meta,
  }) = _HypocenterListResponse;
  
  factory HypocenterListResponse.fromJson(Map<String, Object?> json) => _$HypocenterListResponseFromJson(json);
}
