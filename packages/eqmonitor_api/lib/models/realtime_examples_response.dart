// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_examples_response.freezed.dart';
part 'realtime_examples_response.g.dart';

@Freezed()
abstract class RealtimeExamplesResponse with _$RealtimeExamplesResponse {
  const factory RealtimeExamplesResponse({required List<dynamic> examples}) =
      _RealtimeExamplesResponse;

  factory RealtimeExamplesResponse.fromJson(Map<String, Object?> json) =>
      _$RealtimeExamplesResponseFromJson(json);
}
