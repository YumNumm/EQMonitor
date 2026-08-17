import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_with_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_telegrams_provider.g.dart';

@riverpod
Future<List<TsunamiTelegramWithState>> tsunamiTelegrams(
  Ref ref,
  String tsunamiId,
) async {
  final client = await ref.read(apiClientProvider.future);
  final response = await client.tsunami.getV2TsunamiTsunamiIdTelegrams(
    tsunamiId: tsunamiId,
  );
  return [...response.data.telegrams.map((e) => e.toDomain())]
    ..sort((a, b) => a.telegram.publishedAt.compareTo(b.telegram.publishedAt));
}
