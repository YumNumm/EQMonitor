// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app.dart';
import 'start_flags.dart';

part 'start_response.freezed.dart';
part 'start_response.g.dart';

@Freezed()
abstract class StartResponse with _$StartResponse {
  const factory StartResponse({
    required StartFlags flags,
    required App app,
  }) = _StartResponse;

  factory StartResponse.fromJson(Map<String, Object?> json) =>
      _$StartResponseFromJson(json);
}
