// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'version.dart';
import 'store_url.dart';

part 'app.freezed.dart';
part 'app.g.dart';

@Freezed()
abstract class App with _$App {
  const factory App({
    required Version version,
    @JsonKey(name: 'store_url') required StoreUrl storeUrl,
  }) = _App;

  factory App.fromJson(Map<String, Object?> json) => _$AppFromJson(json);
}
