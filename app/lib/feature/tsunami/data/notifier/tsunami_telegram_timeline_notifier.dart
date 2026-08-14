import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/logic/tracked_tsunami_timeline_to_public_mapper.dart';
import 'package:eqmonitor/feature/tsunami/data/logic/tsunami_telegrams_response_to_tracked_timeline_builder.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_telegram_timeline_notifier.g.dart';

@riverpod
Future<TsunamiTimeline> tsunamiTelegramTimeline(
  Ref ref,
  String tsunamiId,
) async {
  final client = await ref.read(apiClientProvider.future);
  final response = await client.tsunami.getV2TsunamiTsunamiIdTelegrams(
    tsunamiId: tsunamiId,
  );
  return response.data.toTrackedTimeline().toPublic();
}
