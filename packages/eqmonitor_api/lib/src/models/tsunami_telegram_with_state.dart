// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'latest_telegram.dart';
import 'tsunami_state.dart';

part 'tsunami_telegram_with_state.freezed.dart';
part 'tsunami_telegram_with_state.g.dart';

@Freezed()
abstract class TsunamiTelegramWithState with _$TsunamiTelegramWithState {
  const factory TsunamiTelegramWithState({
    required LatestTelegram telegram,
    required TsunamiState state,
  }) = _TsunamiTelegramWithState;

  factory TsunamiTelegramWithState.fromJson(Map<String, Object?> json) =>
      _$TsunamiTelegramWithStateFromJson(json);
}
