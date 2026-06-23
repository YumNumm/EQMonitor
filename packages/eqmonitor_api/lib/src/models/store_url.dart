// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_url.freezed.dart';
part 'store_url.g.dart';

@Freezed()
abstract class StoreUrl with _$StoreUrl {
  const factory StoreUrl({
    required String ios,
    required String android,
  }) = _StoreUrl;

  factory StoreUrl.fromJson(Map<String, Object?> json) =>
      _$StoreUrlFromJson(json);
}
