import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';

class const EarthquakeHistoryDetailsDisplayResolver() {
  EarthquakeDataSource initialSource({required bool hasCatalog}) => hasCatalog
      ? EarthquakeDataSource.jmaIntensityDatabase
      : EarthquakeDataSource.jmaDisasterInformationXml;

  EarthquakeDataSource effectiveSource({
    required EarthquakeDataSource selected,
    required bool hasCatalog,
  }) => selected == EarthquakeDataSource.jmaIntensityDatabase && hasCatalog
      ? EarthquakeDataSource.jmaIntensityDatabase
      : EarthquakeDataSource.jmaDisasterInformationXml;

  // 長周期地震動階級は震度データベースに含まれないため、DB 表示では選べない。
  List<IntensityDisplayMode> availableModes({
    required bool showingDb,
    required bool hasLpgm,
    required bool hasEstimated,
  }) => [
    IntensityDisplayMode.jma,
    if (hasLpgm && !showingDb) IntensityDisplayMode.lpgm,
    if (hasEstimated) IntensityDisplayMode.estimated,
  ];

  IntensityDisplayMode effectiveMode({
    required IntensityDisplayMode selected,
    required List<IntensityDisplayMode> availableModes,
  }) => availableModes.contains(selected) ? selected : IntensityDisplayMode.jma;
}
