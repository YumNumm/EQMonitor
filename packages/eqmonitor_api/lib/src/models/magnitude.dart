// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type3.dart';

part 'magnitude.freezed.dart';
part 'magnitude.g.dart';

/// 地震の規模を表すマグニチュード
@Freezed()
abstract class Magnitude with _$Magnitude {
  const factory Magnitude({
    required Type3 type,

    /// typeがNORMALのときのみ出現する
    @JsonKey(includeIfNull: false)
    num? value,
  }) = _Magnitude;
  
  factory Magnitude.fromJson(Map<String, Object?> json) => _$MagnitudeFromJson(json);
}
