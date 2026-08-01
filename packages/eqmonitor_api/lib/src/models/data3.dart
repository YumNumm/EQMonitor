// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hypocenter_response_item.dart';

part 'data3.freezed.dart';
part 'data3.g.dart';

@Freezed()
abstract class Data3 with _$Data3 {
  const factory Data3({
    required List<HypocenterResponseItem> items,
    @JsonKey(includeIfNull: false,name: 'next_token')
    String? nextToken,
  }) = _Data3;
  
  factory Data3.fromJson(Map<String, Object?> json) => _$Data3FromJson(json);
}
