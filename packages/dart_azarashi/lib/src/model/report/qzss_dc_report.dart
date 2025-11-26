import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qzss_dc_report.freezed.dart';
part 'qzss_dc_report.g.dart';

/// Hypocenter coordinates data class.
@JsonSerializable()
class HypocenterCoordinates {
  const HypocenterCoordinates({
    required this.latNs,
    required this.latD,
    required this.latM,
    required this.latS,
    required this.lonEw,
    required this.lonD,
    required this.lonM,
    required this.lonS,
  });

  factory HypocenterCoordinates.fromJson(Map<String, dynamic> json) =>
      _$HypocenterCoordinatesFromJson(json);

  final int latNs;
  final int latD;
  final int latM;
  final int latS;
  final int lonEw;
  final int lonD;
  final int lonM;
  final int lonS;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get latitude => '${latNs == 0 ? 'N' : 'S'}$latD°$latM\'$latS"';
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get longitude => '${lonEw == 0 ? 'E' : 'W'}$lonD°$lonM\'$lonS"';

  @JsonKey(includeFromJson: false, includeToJson: false)
  double get latitudeDecimal {
    final decimal = latD + latM / 60 + latS / 3600;
    return latNs == 0 ? decimal : -decimal;
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  double get longitudeDecimal {
    final decimal = lonD + lonM / 60 + lonS / 3600;
    return lonEw == 0 ? decimal : -decimal;
  }

  Map<String, dynamic> toJson() => _$HypocenterCoordinatesToJson(this);
}

/// QZSS Disaster and Crisis Report base sealed class.
///
/// This is a sealed class representing all types of DCR/DCX reports.
@freezed
sealed class QzssDcReport with _$QzssDcReport {
  const QzssDcReport._();

  /// Earthquake Early Warning Report.
  const factory QzssDcReport.earthquakeEarlyWarning({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required String? longPeriodGroundMotionLowerLimit,
    required int longPeriodGroundMotionLowerLimitRaw,
    required String? longPeriodGroundMotionUpperLimit,
    required int longPeriodGroundMotionUpperLimitRaw,
    required List<String> notificationsOnDisasterPrevention,
    required List<int> notificationsOnDisasterPreventionRaw,
    required DateTime occurrenceTimeOfEarthquake,
    required String depthOfHypocenter,
    required int depthOfHypocenterRaw,
    required String magnitude,
    required int magnitudeRaw,
    required bool assumptive,
    required String seismicEpicenter,
    required int seismicEpicenterRaw,
    required String seismicIntensityLowerLimit,
    required int seismicIntensityLowerLimitRaw,
    required String seismicIntensityUpperLimit,
    required int seismicIntensityUpperLimitRaw,
    required List<String> eewForecastRegions,
    required List<int> eewForecastRegionsRaw,
  }) = QzssDcReportEarthquakeEarlyWarning;

  /// Hypocenter Report.
  const factory QzssDcReport.hypocenter({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required List<String> notificationsOnDisasterPrevention,
    required List<int> notificationsOnDisasterPreventionRaw,
    required DateTime occurrenceTimeOfEarthquake,
    required String depthOfHypocenter,
    required int depthOfHypocenterRaw,
    required String magnitude,
    required int magnitudeRaw,
    required String seismicEpicenter,
    required int seismicEpicenterRaw,
    required HypocenterCoordinates coordinatesOfHypocenter,
  }) = QzssDcReportHypocenter;

  /// Seismic Intensity Report.
  const factory QzssDcReport.seismicIntensity({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required DateTime occurrenceTimeOfEarthquake,
    required List<String> seismicIntensities,
    required List<int> seismicIntensitiesRaw,
    required List<String> prefectures,
    required List<int> prefecturesRaw,
  }) = QzssDcReportSeismicIntensity;

  /// Tsunami Report.
  const factory QzssDcReport.tsunami({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required List<String> notificationsOnDisasterPrevention,
    required List<int> notificationsOnDisasterPreventionRaw,
    required String tsunamiWarningCode,
    required int tsunamiWarningCodeRaw,
    required List<DateTime?> expectedTsunamiArrivalTimes,
    required List<String> tsunamiHeights,
    required List<int> tsunamiHeightsRaw,
    required List<String> tsunamiForecastRegions,
    required List<int> tsunamiForecastRegionsRaw,
  }) = QzssDcReportTsunami;

  /// Nankai Trough Earthquake Report.
  const factory QzssDcReport.nankaiTroughEarthquake({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required String informationSerialCode,
    required int informationSerialCodeRaw,
    @Uint8ListConverter() required Uint8List textInformation,
    required int pageNumber,
    required int totalPage,
  }) = QzssDcReportNankaiTroughEarthquake;

  /// Northwest Pacific Tsunami Report.
  const factory QzssDcReport.northwestPacificTsunami({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required String tsunamigenicPotentialEn,
    required int tsunamigenicPotentialRaw,
    required List<DateTime?> expectedTsunamiArrivalTimes,
    required List<String> tsunamiHeightsEn,
    required List<int> tsunamiHeightsRaw,
    required List<String> coastalRegionsEn,
    required List<int> coastalRegionsRaw,
  }) = QzssDcReportNorthwestPacificTsunami;

  /// Flood Report.
  const factory QzssDcReport.flood({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required List<String> floodWarningLevels,
    required List<int> floodWarningLevelsRaw,
    required List<String> floodForecastRegions,
    required List<int> floodForecastRegionsRaw,
  }) = QzssDcReportFlood;

  /// Marine Report.
  const factory QzssDcReport.marine({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required List<String> marineWarningCodes,
    required List<int> marineWarningCodesRaw,
    required List<String> marineForecastRegions,
    required List<int> marineForecastRegionsRaw,
  }) = QzssDcReportMarine;

  /// Weather Report.
  const factory QzssDcReport.weather({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required String weatherWarningState,
    required int weatherWarningStateRaw,
    required List<String> weatherRelatedDisasterSubCategories,
    required List<int> weatherRelatedDisasterSubCategoriesRaw,
    required List<String> weatherForecastRegions,
    required List<int> weatherForecastRegionsRaw,
  }) = QzssDcReportWeather;

  /// Volcano Report.
  const factory QzssDcReport.volcano({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required int ambiguityOfActivityTimeNo,
    required DateTime activityTime,
    required String volcanicWarningCode,
    required int volcanicWarningCodeRaw,
    required String volcanoName,
    required int volcanoNameRaw,
    required List<String> localGovernments,
    required List<int> localGovernmentsRaw,
  }) = QzssDcReportVolcano;

  /// Ash Fall Report.
  const factory QzssDcReport.ashFall({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required DateTime activityTime,
    required String ashFallWarningType,
    required int ashFallWarningTypeRaw,
    required String volcanoName,
    required int volcanoNameRaw,
    required List<int> expectedAshFallTimes,
    required List<String> ashFallWarningCodes,
    required List<int> ashFallWarningCodesRaw,
    required List<String> localGovernments,
    required List<int> localGovernmentsRaw,
  }) = QzssDcReportAshFall;

  /// Typhoon Report.
  const factory QzssDcReport.typhoon({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required int version,
    required String reportClassification,
    required String reportClassificationEn,
    required int reportClassificationNo,
    required String disasterCategory,
    required String disasterCategoryEn,
    required int disasterCategoryNo,
    required DateTime reportTime,
    required String informationType,
    required String informationTypeEn,
    required int informationTypeNo,
    required DateTime referenceTime,
    required String referenceTimeType,
    required int referenceTimeTypeRaw,
    required int elapsedTimeFromReferenceTime,
    required String typhoonNumber,
    required int typhoonNumberRaw,
    required String typhoonScaleCategory,
    required int typhoonScaleCategoryRaw,
    required String typhoonIntensityCategory,
    required int typhoonIntensityCategoryRaw,
    required HypocenterCoordinates coordinatesOfTyphoon,
    required String centralPressure,
    required int centralPressureRaw,
    required String maximumWindSpeed,
    required int maximumWindSpeedRaw,
    required String maximumGustWindSpeed,
    required int maximumGustWindSpeedRaw,
  }) = QzssDcReportTyphoon;

  /// DCX Null Message.
  const factory QzssDcReport.dcxNull({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxNull;

  /// DCX Outside Japan Message.
  const factory QzssDcReport.dcxOutsideJapan({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxOutsideJapan;

  /// DCX L-Alert Message.
  const factory QzssDcReport.dcxLAlert({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxLAlert;

  /// DCX J-Alert Message.
  const factory QzssDcReport.dcxJAlert({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxJAlert;

  /// DCX Municipality-Transmitted Information Message.
  const factory QzssDcReport.dcxMTInfo({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxMTInfo;

  /// DCX Unknown Message.
  const factory QzssDcReport.dcxUnknown({
    required String sentence,
    @Uint8ListConverter() required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    @Uint8ListConverter() required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxUnknown;

  factory QzssDcReport.fromJson(Map<String, dynamic> json) =>
      _$QzssDcReportFromJson(json);
}
