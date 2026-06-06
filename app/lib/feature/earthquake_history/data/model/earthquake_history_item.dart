import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';

class EarthquakeHistoryItem {
  const EarthquakeHistoryItem({
    required this.earthquake,
    this.areaInfo,
  });

  final EarthquakePartial earthquake;

  /// 地域検索時にレスポンスに含まれる、検索対象地域の震度情報。
  final IntensityAreaInfo? areaInfo;
}
