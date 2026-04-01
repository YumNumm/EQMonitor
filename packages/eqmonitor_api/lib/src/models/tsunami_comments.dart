// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'warning.dart';

part 'tsunami_comments.freezed.dart';
part 'tsunami_comments.g.dart';

@Freezed()
abstract class TsunamiComments with _$TsunamiComments {
  const factory TsunamiComments({
    @JsonKey(includeIfNull: false)
    String? free,
    @JsonKey(includeIfNull: false)
    Warning? warning,
  }) = _TsunamiComments;
  
  factory TsunamiComments.fromJson(Map<String, Object?> json) => _$TsunamiCommentsFromJson(json);
}
