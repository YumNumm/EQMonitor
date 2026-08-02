// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_name.freezed.dart';
part 'localized_name.g.dart';

@Freezed()
abstract class LocalizedName with _$LocalizedName {
  const factory LocalizedName({
    required String ja,
    @JsonKey(includeIfNull: false)
    String? en,
    @JsonKey(includeIfNull: false,name: 'zh_hans')
    String? zhHans,
    @JsonKey(includeIfNull: false,name: 'zh_hant')
    String? zhHant,
    @JsonKey(includeIfNull: false)
    String? ko,
    @JsonKey(includeIfNull: false)
    String? es,
    @JsonKey(includeIfNull: false)
    String? pt,
    @JsonKey(includeIfNull: false)
    String? id,
    @JsonKey(includeIfNull: false)
    String? vi,
    @JsonKey(includeIfNull: false)
    String? tl,
    @JsonKey(includeIfNull: false)
    String? th,
    @JsonKey(includeIfNull: false)
    String? ne,
    @JsonKey(includeIfNull: false)
    String? km,
    @JsonKey(includeIfNull: false)
    String? my,
    @JsonKey(includeIfNull: false)
    String? mn,
  }) = _LocalizedName;

  factory LocalizedName.fromJson(Map<String, Object?> json) => _$LocalizedNameFromJson(json);
}
