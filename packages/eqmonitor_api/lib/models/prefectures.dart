// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefectures.freezed.dart';
part 'prefectures.g.dart';

@Freezed()
abstract class Prefectures with _$Prefectures {
  const factory Prefectures({
    required String code,
    required String name,
    required String intensity,
  }) = _Prefectures;
  
  factory Prefectures.fromJson(Map<String, Object?> json) => _$PrefecturesFromJson(json);
}
