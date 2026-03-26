// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'not_found_response.freezed.dart';
part 'not_found_response.g.dart';

@Freezed()
abstract class NotFoundResponse with _$NotFoundResponse {
  const factory NotFoundResponse({
    required dynamic code,
    required dynamic message,
  }) = _NotFoundResponse;
  
  factory NotFoundResponse.fromJson(Map<String, Object?> json) => _$NotFoundResponseFromJson(json);
}
