import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_v1_extended.freezed.dart';
part 'earthquake_v1_extended.g.dart';

@freezed
abstract class EarthquakeV1Extended with _$EarthquakeV1Extended {
  const factory EarthquakeV1Extended({
    required EarthquakeV1 earthquake,
    required List<String>? maxIntensityRegionNames,
  }) = _EarthquakeV1Extended;

  factory EarthquakeV1Extended.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeV1ExtendedFromJson(json);

  const EarthquakeV1Extended._();

  int? get depth => earthquake.depth;

  int? get epicenterCode => earthquake.epicenterCode;

  int? get epicenterDetailCode => earthquake.epicenterDetailCode;

  int get eventId => earthquake.eventId;

  String? get headline => earthquake.headline;

  List<ObservedRegionIntensity>? get intensityCities =>
      earthquake.intensityCities;

  List<ObservedRegionIntensity>? get intensityPrefectures =>
      earthquake.intensityPrefectures;

  List<ObservedRegionIntensity>? get intensityRegions =>
      earthquake.intensityRegions;

  List<ObservedRegionIntensity>? get intensityStations =>
      earthquake.intensityStations;

  double? get latitude => earthquake.latitude;

  double? get longitude => earthquake.longitude;

  List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures =>
      earthquake.lpgmIntensityPrefectures;

  List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions =>
      earthquake.lpgmIntensityRegions;

  List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations =>
      earthquake.lpgmIntenstiyStations;

  double? get magnitude => earthquake.magnitude;

  String? get magnitudeCondition => earthquake.magnitudeCondition;

  JmaIntensity? get maxIntensity => earthquake.maxIntensity;

  List<int>? get maxIntensityRegionIds => earthquake.maxIntensityRegionIds;

  JmaLgIntensity? get maxLpgmIntensity => earthquake.maxLpgmIntensity;

  DateTime? get originTime => earthquake.originTime;

  String get status => earthquake.status;

  String? get text => earthquake.text;

  DateTime? get arrivalTime => earthquake.arrivalTime;
}

extension EarthquakeV1ExtendedEx on EarthquakeV1Extended {
  bool get isVolcano =>
      (text?.contains('大規模な噴火が発生しました') ?? false) &&
      (text?.contains('実際には、規模の大きな地震は発生していない点に留意') ?? false);

  String? get volcanoName {
    if (!isVolcano) {
      return null;
    }

    final splitted = text?.split('分頃（日本時間）に') ?? [];
    if (splitted.length != 2) {
      return null;
    }
    return splitted[1].split('で大規模な噴火が発生しました')[0];
  }
}
