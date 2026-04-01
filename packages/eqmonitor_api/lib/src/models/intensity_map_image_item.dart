// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_locale.dart';
import 'size.dart';

part 'intensity_map_image_item.freezed.dart';
part 'intensity_map_image_item.g.dart';

@Freezed()
abstract class IntensityMapImageItem with _$IntensityMapImageItem {
  const factory IntensityMapImageItem({
    /// 画像レコードID
    required String id,
    required AppLocale language,

    /// 画像URL
    @JsonKey(name: 'image_url')
    required String imageUrl,

    /// 画像ファイルサイズ(bytes)
    @JsonKey(name: 'file_size')
    required num fileSize,
    required Size size,

    /// 生成インスタンス名
    @JsonKey(name: 'generator_instance')
    required String generatorInstance,

    /// レンダリング時間(ms)
    @JsonKey(name: 'render_duration_ms')
    required num renderDurationMs,

    /// アップロード時間(ms)
    @JsonKey(name: 'upload_duration_ms')
    required num uploadDurationMs,

    /// 総処理時間(ms)
    @JsonKey(name: 'total_duration_ms')
    required num totalDurationMs,
    @JsonKey(name: 'generated_at')
    required DateTime generatedAt,
  }) = _IntensityMapImageItem;
  
  factory IntensityMapImageItem.fromJson(Map<String, Object?> json) => _$IntensityMapImageItemFromJson(json);
}
