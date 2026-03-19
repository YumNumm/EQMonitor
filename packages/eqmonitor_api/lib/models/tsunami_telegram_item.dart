// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_body.dart';
import 'tsunami_telegram_header.dart';

part 'tsunami_telegram_item.freezed.dart';
part 'tsunami_telegram_item.g.dart';

@Freezed()
abstract class TsunamiTelegramItem with _$TsunamiTelegramItem {
  const factory TsunamiTelegramItem({
    required TsunamiTelegramHeader telegram,
    required TsunamiTelegramBody body,
  }) = _TsunamiTelegramItem;

  factory TsunamiTelegramItem.fromJson(Map<String, Object?> json) =>
      _$TsunamiTelegramItemFromJson(json);
}
