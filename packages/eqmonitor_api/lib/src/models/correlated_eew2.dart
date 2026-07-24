// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'correlated_eew2.freezed.dart';
part 'correlated_eew2.g.dart';

@Freezed()
abstract class CorrelatedEew2 with _$CorrelatedEew2 {
  const factory CorrelatedEew2({
    required String eventId,
    required num score,
  }) = _CorrelatedEew2;

  factory CorrelatedEew2.fromJson(Map<String, Object?> json) => _$CorrelatedEew2FromJson(json);
}
