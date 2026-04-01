// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_left.freezed.dart';
part 'top_left.g.dart';

@Freezed()
abstract class TopLeft with _$TopLeft {
  const factory TopLeft({required num latitude, required num longitude}) =
      _TopLeft;

  factory TopLeft.fromJson(Map<String, Object?> json) =>
      _$TopLeftFromJson(json);
}
