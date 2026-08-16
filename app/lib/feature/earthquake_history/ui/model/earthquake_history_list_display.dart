import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';

class EarthquakeHistoryListDisplay {
  const EarthquakeHistoryListDisplay({
    required this.showBackgroundColor,
    required this.showDateSeparator,
  });

  factory EarthquakeHistoryListDisplay.resolve({
    required EarthquakeHistoryListConfig config,
    required EarthquakeSortBy sortBy,
  }) => EarthquakeHistoryListDisplay(
    showBackgroundColor: config.isFillBackground,
    showDateSeparator:
        config.showDateSeparator && sortBy == EarthquakeSortBy.eventId,
  );

  final bool showBackgroundColor;
  final bool showDateSeparator;
}
