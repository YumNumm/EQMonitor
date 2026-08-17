import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';

class EarthquakeActivityEligibility {
  const new();

  bool isEligible(Earthquake earthquake) {
    final magnitudeEligible = switch (earthquake.hypocenter?.magnitude) {
      EarthquakeMagnitudeValue(:final value) => value >= 6,
      EarthquakeMagnitudeOverM8() => true,
      EarthquakeMagnitudeUnknown() || null => false,
    };
    final intensityEligible = switch (earthquake.intensity?.maxIntensity) {
      JmaIntensity.fiveUnknown ||
      JmaIntensity.fiveLower ||
      JmaIntensity.fiveUpper ||
      JmaIntensity.sixUnknown ||
      JmaIntensity.sixLower ||
      JmaIntensity.sixUpper ||
      JmaIntensity.seven => true,
      _ => false,
    };

    return earthquake.earthquakeType == EarthquakeType.normal &&
        earthquake.originTime != null &&
        earthquake.hypocenter?.coordinates is CoordinateLatLng &&
        (magnitudeEligible || intensityEligible);
  }
}
