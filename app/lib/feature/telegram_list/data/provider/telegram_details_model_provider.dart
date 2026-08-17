import 'package:eqmonitor/feature/telegram_list/data/model/telegram_detail_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_details_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_model_provider.g.dart';

/// UI 層がドメイン型のみを参照できるよう、
/// 電文詳細レスポンスをアプリ用ドメインモデルへ変換したマップを返す。
@riverpod
AsyncValue<Map<String, TelegramDetailModel>> telegramDetailsModel(
  Ref ref,
  String eventId,
) {
  final state = ref.watch(telegramDetailsProvider(eventId));
  return state.whenData(
    (details) => details.map(
      (key, value) => MapEntry(key, value.toTelegramDetailModel()),
    ),
  );
}
