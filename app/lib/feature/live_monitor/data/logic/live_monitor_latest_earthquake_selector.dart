import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';

class LiveMonitorLatestEarthquakeSelector {
  const new();

  String? selectEventId(List<EarthquakePartial> items) =>
      items.map((item) => item.earthquake.eventId).firstOrNull;
}
