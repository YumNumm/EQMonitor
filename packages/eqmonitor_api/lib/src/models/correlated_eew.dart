// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'correlated_eew.freezed.dart';
part 'correlated_eew.g.dart';

@Freezed()
abstract class CorrelatedEew with _$CorrelatedEew {
  const factory CorrelatedEew({
    required String eventId,
    required num score,
  }) = _CorrelatedEew;

  factory CorrelatedEew.fromJson(Map<String, Object?> json) => _$CorrelatedEewFromJson(json);
}
