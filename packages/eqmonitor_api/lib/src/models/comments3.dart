// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'warning.dart';

part 'comments3.freezed.dart';
part 'comments3.g.dart';

@Freezed()
abstract class Comments3 with _$Comments3 {
  const factory Comments3({
    @JsonKey(includeIfNull: false)
    String? free,
    @JsonKey(includeIfNull: false)
    Warning? warning,
  }) = _Comments3;
  
  factory Comments3.fromJson(Map<String, Object?> json) => _$Comments3FromJson(json);
}
