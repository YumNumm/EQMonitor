// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_map_image_item.dart';

part 'intensity_map_image_group.freezed.dart';
part 'intensity_map_image_group.g.dart';

@Freezed()
abstract class IntensityMapImageGroup with _$IntensityMapImageGroup {
  const factory IntensityMapImageGroup({
    /// 電文ID
    @JsonKey(name: 'telegram_id') required String telegramId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required List<IntensityMapImageItem> images,
  }) = _IntensityMapImageGroup;

  factory IntensityMapImageGroup.fromJson(Map<String, Object?> json) =>
      _$IntensityMapImageGroupFromJson(json);
}
