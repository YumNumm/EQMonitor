import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';

class EarthquakeHistorySearchResult {
  const new({
    required this.name,
    required this.areaDescription,
    required this.parameter,
  });

  final String name;
  final String areaDescription;
  final EarthquakeHistoryParameter parameter;
}
