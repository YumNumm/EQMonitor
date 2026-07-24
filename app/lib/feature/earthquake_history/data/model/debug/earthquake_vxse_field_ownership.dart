import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';

enum EarthquakeVxseOwnedField {
  hypocenter,
  magnitude,
  depth,
  maxIntensity,
  intensityRegions,
  intensityPrefectures,
  intensityCities,
  intensityStations,
  maxLpgmIntensity,
  lpgmRegions,
  lpgmPrefectures,
  lpgmStations,
  comments,
}

class EarthquakeVxseFieldOwnership {
  const EarthquakeVxseFieldOwnership._(this.fields);

  final Set<EarthquakeVxseOwnedField> fields;

  bool owns(EarthquakeVxseOwnedField field) => fields.contains(field);

  static EarthquakeVxseFieldOwnership forType(EarthquakeTelegramType type) =>
      switch (type) {
        .vxse51 => const EarthquakeVxseFieldOwnership._({
          EarthquakeVxseOwnedField.maxIntensity,
          EarthquakeVxseOwnedField.intensityRegions,
          EarthquakeVxseOwnedField.intensityPrefectures,
          EarthquakeVxseOwnedField.comments,
        }),
        .vxse52 => const EarthquakeVxseFieldOwnership._({
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.comments,
        }),
        .vxse53 => const EarthquakeVxseFieldOwnership._({
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.maxIntensity,
          EarthquakeVxseOwnedField.intensityRegions,
          EarthquakeVxseOwnedField.intensityPrefectures,
          EarthquakeVxseOwnedField.intensityCities,
          EarthquakeVxseOwnedField.intensityStations,
          EarthquakeVxseOwnedField.comments,
        }),
        .vxse61 => const EarthquakeVxseFieldOwnership._({
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.comments,
        }),
        .vxse62 => const EarthquakeVxseFieldOwnership._({
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.maxLpgmIntensity,
          EarthquakeVxseOwnedField.lpgmRegions,
          EarthquakeVxseOwnedField.lpgmPrefectures,
          EarthquakeVxseOwnedField.lpgmStations,
          EarthquakeVxseOwnedField.comments,
        }),
        .vxse45Forecast || .vxse45Warning => throw ArgumentError.value(
          type,
          'type',
          'VXSE51/52/53/61/62 only',
        ),
      };
}
