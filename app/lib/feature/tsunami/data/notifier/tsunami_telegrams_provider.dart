// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
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
  final telegrams = response.data.telegrams;
  telegrams.sort(
    (a, b) => a.telegram.pressedAt.compareTo(b.telegram.pressedAt),
  );
  return telegrams;
}
