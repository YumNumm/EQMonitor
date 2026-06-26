// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'start_app_version.dart';
import 'store_url.dart';

part 'start_app.freezed.dart';
part 'start_app.g.dart';

@Freezed()
abstract class StartApp with _$StartApp {
  const factory StartApp({
    required StartAppVersion version,
    @JsonKey(name: 'store_url')
    required StoreUrl storeUrl,
  }) = _StartApp;
  
  factory StartApp.fromJson(Map<String, Object?> json) => _$StartAppFromJson(json);
}
