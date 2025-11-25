import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'qzss_dc_report.freezed.dart';

/// Hypocenter coordinates data class.
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

  final int latNs;
  final int latD;
  final int latM;
  final int latS;
  final int lonEw;
  final int lonD;
  final int lonM;
  final int lonS;

  String get latitude => '${latNs == 0 ? 'N' : 'S'}$latD°$latM\'$latS"';
  String get longitude => '${lonEw == 0 ? 'E' : 'W'}$lonD°$lonM\'$lonS"';

  double get latitudeDecimal {
    final decimal = latD + latM / 60 + latS / 3600;
    return latNs == 0 ? decimal : -decimal;
  }

  double get longitudeDecimal {
    final decimal = lonD + lonM / 60 + lonS / 3600;
    return lonEw == 0 ? decimal : -decimal;
  }
}

/// QZSS Disaster and Crisis Report base sealed class.
///
/// This is a sealed class representing all types of DCR/DCX reports.
@Freezed(copyWith: false, toJson: false, fromJson: false, equal: false)
sealed class QzssDcReport with _$QzssDcReport {
  const QzssDcReport._();

  /// Earthquake Early Warning Report.
  const factory QzssDcReport.earthquakeEarlyWarning({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
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
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
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
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
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
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
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

  /// DCX Null Message.
  const factory QzssDcReport.dcxNull({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxNull;

  /// DCX Outside Japan Message.
  const factory QzssDcReport.dcxOutsideJapan({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxOutsideJapan;

  /// DCX L-Alert Message.
  const factory QzssDcReport.dcxLAlert({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxLAlert;

  /// DCX J-Alert Message.
  const factory QzssDcReport.dcxJAlert({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxJAlert;

  /// DCX Municipality-Transmitted Information Message.
  const factory QzssDcReport.dcxMTInfo({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxMTInfo;

  /// DCX Unknown Message.
  const factory QzssDcReport.dcxUnknown({
    required String sentence,
    required Uint8List message,
    required String nmea,
    String? messageHeader,
    int? satelliteId,
    int? satellitePrn,
    required Uint8List raw,
    required String preamble,
    required String messageType,
    required String dcxMessageType,
  }) = QzssDcReportDcxUnknown;
}
