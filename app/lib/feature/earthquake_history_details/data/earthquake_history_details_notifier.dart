import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
Future<EarthquakeV1Extended> earthquakeHistoryDetailsNotifier(
  EarthquakeHistoryDetailsNotifierRef ref,
  int eventId,
) async {
  final api = ref.watch(eqApiProvider);
  final response = await api.v1.getEarthquakeDetail(eventId: eventId.toString());
  final data = response.data;

  final extended = await ref.read(earthquakeV1ExtendedProvider(data).future);
  return extended;
}
