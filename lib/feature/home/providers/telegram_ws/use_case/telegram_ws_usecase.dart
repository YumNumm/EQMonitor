import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_ws_usecase.g.dart';

@riverpod
TelegramWsUseCase telegramWsUseCase(TelegramWsUseCaseRef ref) =>
    TelegramWsUseCase();

class TelegramWsUseCase {
  TelegramWsUseCase();

  // Future<EewHistoryItem> getEewHistoryItem(int eventId) async {
  //   final response = await _telegramRepository.getEewHistoryItem(eventId);
  //   return response;
  // }
  Future<void> connectToWs() async {
    const url = '';
  }
}
