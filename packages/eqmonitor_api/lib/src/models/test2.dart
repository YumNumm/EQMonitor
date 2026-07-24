// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test2.freezed.dart';
part 'test2.g.dart';

@Freezed()
abstract class Test2 with _$Test2 {
  const factory Test2({
    required String targetDeviceId,
  }) = _Test2;

  factory Test2.fromJson(Map<String, Object?> json) => _$Test2FromJson(json);
}
