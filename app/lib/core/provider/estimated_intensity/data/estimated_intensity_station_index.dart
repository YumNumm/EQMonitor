import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';

typedef EstimatedIntensityRegionStation = ({
  String regionCode,
  String regionName,
  CalculationPoint point,
});

/// JMA パラメータから推定震度計算用の観測点インデックスを構築する。
final class EstimatedIntensityStationIndex {
  const new({
    required this.regionStations,
    required this.calculationPoints,
  });

  factory fromEarthquakeParameter(
    EarthquakeParameter earthquake,
  ) {
    final regionStations = <EstimatedIntensityRegionStation>[];
    for (final prefecture in earthquake.prefectures) {
      for (final region in prefecture.regions) {
        for (final city in region.cities) {
          for (final station in city.stations) {
            if (station.arv400 case final arv400?) {
              regionStations.add((
                regionCode: region.code,
                regionName: region.name.ja,
                point: (
                  lat: station.location.lat,
                  lon: station.location.lon,
                  arv400: arv400,
                ),
              ));
            }
          }
        }
      }
    }

    return EstimatedIntensityStationIndex(
      regionStations: regionStations,
      calculationPoints: [
        for (final station in regionStations) station.point,
      ],
    );
  }

  final List<EstimatedIntensityRegionStation> regionStations;
  final List<CalculationPoint> calculationPoints;
}
