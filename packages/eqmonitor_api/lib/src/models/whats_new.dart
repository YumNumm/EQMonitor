// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'whats_new.freezed.dart';
part 'whats_new.g.dart';

@Freezed()
abstract class WhatsNew with _$WhatsNew {
  const factory WhatsNew({
    required String content,
    @JsonKey(includeIfNull: false) String? title,
  }) = _WhatsNew;

  factory WhatsNew.fromJson(Map<String, Object?> json) =>
      _$WhatsNewFromJson(json);
}
