// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami.dart';

part 'tsunami_detail_response.freezed.dart';
part 'tsunami_detail_response.g.dart';

@Freezed()
abstract class TsunamiDetailResponse with _$TsunamiDetailResponse {
  const factory TsunamiDetailResponse({
    required Tsunami tsunami,
  }) = _TsunamiDetailResponse;
  
  factory TsunamiDetailResponse.fromJson(Map<String, Object?> json) => _$TsunamiDetailResponseFromJson(json);
}
