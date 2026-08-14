import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_telegram_with_state.freezed.dart';

/// 電文とその電文受信時点の津波状態のドメインモデル
@freezed
abstract class TsunamiTelegramWithState with _$TsunamiTelegramWithState {
  const factory TsunamiTelegramWithState({
    required TsunamiTelegramMeta telegram,
    required TsunamiState state,
  }) = _TsunamiTelegramWithState;
}

extension TsunamiTelegramWithStateApiExt on api.TsunamiTelegramWithState {
  TsunamiTelegramWithState toDomain() => TsunamiTelegramWithState(
    telegram: telegram.toTelegramMeta(),
    state: state.toDomain(),
  );
}
