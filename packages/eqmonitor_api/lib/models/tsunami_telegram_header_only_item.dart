// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_header.dart';

part 'tsunami_telegram_header_only_item.freezed.dart';
part 'tsunami_telegram_header_only_item.g.dart';

@Freezed()
abstract class TsunamiTelegramHeaderOnlyItem
    with _$TsunamiTelegramHeaderOnlyItem {
  const factory TsunamiTelegramHeaderOnlyItem({
    required TsunamiTelegramHeader telegram,
  }) = _TsunamiTelegramHeaderOnlyItem;

  factory TsunamiTelegramHeaderOnlyItem.fromJson(Map<String, Object?> json) =>
      _$TsunamiTelegramHeaderOnlyItemFromJson(json);
}
