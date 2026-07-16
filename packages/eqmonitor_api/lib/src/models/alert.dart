// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

@Freezed()
abstract class Alert with _$Alert {
  const factory Alert({
    required String title,
    required String body,
  }) = _Alert;
  
  factory Alert.fromJson(Map<String, Object?> json) => _$AlertFromJson(json);
}
