import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@Riverpod(keepAlive: true)
Future<EarthquakeV1Extended> earthquakeHistoryDetailsNotifier(
  EarthquakeHistoryDetailsNotifierRef ref,
  String eventId,
) async {
  final api = ref.watch(eqApiProvider);
  final response = await api.v1.getEarthquakeDetail(eventId: eventId);
  final data = response.data;
  // TODO(YumNumm): ここでWebSocketからの情報を結合する
  // TODO(YumNumm): WebSocketの仕様決めてくれyo

  final extended = await ref.read(earthquakeV1ExtendedProvider(data).future);
  return extended;
}
