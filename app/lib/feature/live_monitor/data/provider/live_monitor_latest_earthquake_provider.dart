import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_latest_earthquake_selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_latest_earthquake_provider.g.dart';

const liveMonitorLatestParameter = EarthquakeHistoryParameter.all(
  sortBy: EarthquakeSortBy.eventId,
  sortOrder: SortOrder.desc,
);

@riverpod
Future<Earthquake?> liveMonitorLatestEarthquake(Ref ref) async {
  final page = await ref.watch(
    earthquakeHistoryProvider(liveMonitorLatestParameter).future,
  );
  final eventId = const LiveMonitorLatestEarthquakeSelector().selectEventId(
    page.items,
  );
  if (eventId == null) {
    return null;
  }
  return ref.watch(earthquakeHistoryDetailsProvider(eventId).future);
}
