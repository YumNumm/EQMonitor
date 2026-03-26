// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ok_response.freezed.dart';
part 'get_ok_response.g.dart';

@Freezed()
abstract class GetOkResponse with _$GetOkResponse {
  const factory GetOkResponse({
    /// Indicates if the API is working
    required bool ok,
  }) = _GetOkResponse;
  
  factory GetOkResponse.fromJson(Map<String, Object?> json) => _$GetOkResponseFromJson(json);
}
