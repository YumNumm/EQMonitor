// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'size.freezed.dart';
part 'size.g.dart';

@Freezed()
abstract class Size with _$Size {
  const factory Size({
    /// 画像幅(px)
    required num x,

    /// 画像高さ(px)
    required num y,
  }) = _Size;

  factory Size.fromJson(Map<String, Object?> json) => _$SizeFromJson(json);
}
