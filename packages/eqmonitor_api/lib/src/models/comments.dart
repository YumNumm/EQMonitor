// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'comments.freezed.dart';
part 'comments.g.dart';

@Freezed()
abstract class Comments with _$Comments {
  const factory Comments({
    required String free,
  }) = _Comments;
  
  factory Comments.fromJson(Map<String, Object?> json) => _$CommentsFromJson(json);
}
