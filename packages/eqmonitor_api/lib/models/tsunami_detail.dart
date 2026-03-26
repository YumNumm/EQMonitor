// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_header_only_item.dart';

part 'tsunami_detail.freezed.dart';
part 'tsunami_detail.g.dart';

@Freezed()
abstract class TsunamiDetail with _$TsunamiDetail {
  const factory TsunamiDetail({
    required String id,
    @JsonKey(name: 'event_ids') required List<String> eventIds,
    required List<TsunamiTelegramHeaderOnlyItem> telegrams,
  }) = _TsunamiDetail;

  factory TsunamiDetail.fromJson(Map<String, Object?> json) =>
      _$TsunamiDetailFromJson(json);
}
