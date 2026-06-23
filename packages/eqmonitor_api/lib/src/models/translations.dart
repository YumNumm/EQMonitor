// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'translations.freezed.dart';
part 'translations.g.dart';

@Freezed()
abstract class Translations with _$Translations {
  const factory Translations({
    required String locale,
    @JsonKey(includeIfNull: false)
    String? title,
    @JsonKey(includeIfNull: false)
    String? summary,
    @JsonKey(includeIfNull: false)
    String? body,
  }) = _Translations;
  
  factory Translations.fromJson(Map<String, Object?> json) => _$TranslationsFromJson(json);
}
