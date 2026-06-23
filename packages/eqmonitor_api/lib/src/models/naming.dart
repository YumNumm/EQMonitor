// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'naming.freezed.dart';
part 'naming.g.dart';

@Freezed()
abstract class Naming with _$Naming {
  const factory Naming({
    required String text,
    @JsonKey(includeIfNull: false)
    String? en,
  }) = _Naming;
  
  factory Naming.fromJson(Map<String, Object?> json) => _$NamingFromJson(json);
}
