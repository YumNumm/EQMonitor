import 'package:eqapi_types/eqapi_types.dart';

class EarthquakeV1Extended implements EarthquakeV1 {
  EarthquakeV1Extended({
    required this.maxIntensityRegionNames,
    required EarthquakeV1 earthquake,
  }) : _earthquake = earthquake;

  final List<String>? maxIntensityRegionNames;
  final EarthquakeV1 _earthquake;

  @override
  DateTime? get arrivalTime => _earthquake.arrivalTime;

  @override
  $EarthquakeV1CopyWith<EarthquakeV1> get copyWith =>
      throw UnimplementedError();

  @override
  int? get depth => _earthquake.depth;

  @override
  int? get epicenterCode => _earthquake.epicenterCode;

  @override
  int? get epicenterDetailCode => _earthquake.epicenterDetailCode;

  @override
  int get eventId => _earthquake.eventId;

  @override
  String? get headline => _earthquake.headline;

  @override
  List<ObservedRegionIntensity>? get intensityCities =>
      _earthquake.intensityCities;
  @override
  List<ObservedRegionIntensity>? get intensityPrefectures =>
      _earthquake.intensityPrefectures;
  @override
  List<ObservedRegionIntensity>? get intensityRegions =>
      _earthquake.intensityRegions;
  @override
  List<ObservedRegionIntensity>? get intensityStations =>
      _earthquake.intensityStations;
  @override
  double? get latitude => _earthquake.latitude;

  @override
  double? get longitude => _earthquake.longitude;

  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures =>
      _earthquake.lpgmIntensityPrefectures;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions =>
      _earthquake.lpgmIntensityRegions;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations =>
      _earthquake.lpgmIntenstiyStations;
  @override
  double? get magnitude => _earthquake.magnitude;

  @override
  String? get magnitudeCondition => _earthquake.magnitudeCondition;

  @override
  JmaIntensity? get maxIntensity => _earthquake.maxIntensity;

  @override
  List<int>? get maxIntensityRegionIds => _earthquake.maxIntensityRegionIds;

  @override
  JmaLgIntensity? get maxLpgmIntensity => _earthquake.maxLpgmIntensity;

  @override
  DateTime? get originTime => _earthquake.originTime;

  @override
  String get status => _earthquake.status;

  @override
  String? get text => _earthquake.text;

  EarthquakeV1 get v1 => _earthquake;

  @override
  Map<String, dynamic> toJson() => _earthquake.toJson();
}
