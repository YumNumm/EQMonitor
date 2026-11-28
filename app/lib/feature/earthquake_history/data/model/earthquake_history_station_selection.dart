import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:maplibre/maplibre.dart';

sealed class const EarthquakeHistoryStationSelection() {
  Geographic get point;
}

class const EarthquakeHistoryShindoDbStationSelection({
  required final ShindoDbStationNode station,
  required final Geographic point,
}) extends EarthquakeHistoryStationSelection;

class const EarthquakeHistoryJmaStationSelection({
  required final StationLpgmIntensityNode station,
  required final bool showingLpgmIntensity,
}) extends EarthquakeHistoryStationSelection {
  @override
  Geographic get point => Geographic(
    lon: station.station.location.lon,
    lat: station.station.location.lat,
  );
}
