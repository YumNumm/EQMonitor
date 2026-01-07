// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qzss_dc_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HypocenterCoordinates _$HypocenterCoordinatesFromJson(
  Map<String, dynamic> json,
) => HypocenterCoordinates(
  latNs: (json['latNs'] as num).toInt(),
  latD: (json['latD'] as num).toInt(),
  latM: (json['latM'] as num).toInt(),
  latS: (json['latS'] as num).toInt(),
  lonEw: (json['lonEw'] as num).toInt(),
  lonD: (json['lonD'] as num).toInt(),
  lonM: (json['lonM'] as num).toInt(),
  lonS: (json['lonS'] as num).toInt(),
);

Map<String, dynamic> _$HypocenterCoordinatesToJson(
  HypocenterCoordinates instance,
) => <String, dynamic>{
  'latNs': instance.latNs,
  'latD': instance.latD,
  'latM': instance.latM,
  'latS': instance.latS,
  'lonEw': instance.lonEw,
  'lonD': instance.lonD,
  'lonM': instance.lonM,
  'lonS': instance.lonS,
};

QzssDcReportEarthquakeEarlyWarning _$QzssDcReportEarthquakeEarlyWarningFromJson(
  Map<String, dynamic> json,
) => QzssDcReportEarthquakeEarlyWarning(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  version: (json['version'] as num).toInt(),
  reportClassification: json['reportClassification'] as String,
  reportClassificationEn: json['reportClassificationEn'] as String,
  reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
  disasterCategory: json['disasterCategory'] as String,
  disasterCategoryEn: json['disasterCategoryEn'] as String,
  disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
  reportTime: DateTime.parse(json['reportTime'] as String),
  informationType: json['informationType'] as String,
  informationTypeEn: json['informationTypeEn'] as String,
  informationTypeNo: (json['informationTypeNo'] as num).toInt(),
  longPeriodGroundMotionLowerLimit:
      json['longPeriodGroundMotionLowerLimit'] as String?,
  longPeriodGroundMotionLowerLimitRaw:
      (json['longPeriodGroundMotionLowerLimitRaw'] as num).toInt(),
  longPeriodGroundMotionUpperLimit:
      json['longPeriodGroundMotionUpperLimit'] as String?,
  longPeriodGroundMotionUpperLimitRaw:
      (json['longPeriodGroundMotionUpperLimitRaw'] as num).toInt(),
  notificationsOnDisasterPrevention:
      (json['notificationsOnDisasterPrevention'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  notificationsOnDisasterPreventionRaw:
      (json['notificationsOnDisasterPreventionRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  occurrenceTimeOfEarthquake: DateTime.parse(
    json['occurrenceTimeOfEarthquake'] as String,
  ),
  depthOfHypocenter: json['depthOfHypocenter'] as String,
  depthOfHypocenterRaw: (json['depthOfHypocenterRaw'] as num).toInt(),
  magnitude: json['magnitude'] as String,
  magnitudeRaw: (json['magnitudeRaw'] as num).toInt(),
  assumptive: json['assumptive'] as bool,
  seismicEpicenter: json['seismicEpicenter'] as String,
  seismicEpicenterRaw: (json['seismicEpicenterRaw'] as num).toInt(),
  seismicIntensityLowerLimit: json['seismicIntensityLowerLimit'] as String,
  seismicIntensityLowerLimitRaw: (json['seismicIntensityLowerLimitRaw'] as num)
      .toInt(),
  seismicIntensityUpperLimit: json['seismicIntensityUpperLimit'] as String,
  seismicIntensityUpperLimitRaw: (json['seismicIntensityUpperLimitRaw'] as num)
      .toInt(),
  eewForecastRegions: (json['eewForecastRegions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  eewForecastRegionsRaw: (json['eewForecastRegionsRaw'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportEarthquakeEarlyWarningToJson(
  QzssDcReportEarthquakeEarlyWarning instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'longPeriodGroundMotionLowerLimit': instance.longPeriodGroundMotionLowerLimit,
  'longPeriodGroundMotionLowerLimitRaw':
      instance.longPeriodGroundMotionLowerLimitRaw,
  'longPeriodGroundMotionUpperLimit': instance.longPeriodGroundMotionUpperLimit,
  'longPeriodGroundMotionUpperLimitRaw':
      instance.longPeriodGroundMotionUpperLimitRaw,
  'notificationsOnDisasterPrevention':
      instance.notificationsOnDisasterPrevention,
  'notificationsOnDisasterPreventionRaw':
      instance.notificationsOnDisasterPreventionRaw,
  'occurrenceTimeOfEarthquake': instance.occurrenceTimeOfEarthquake
      .toIso8601String(),
  'depthOfHypocenter': instance.depthOfHypocenter,
  'depthOfHypocenterRaw': instance.depthOfHypocenterRaw,
  'magnitude': instance.magnitude,
  'magnitudeRaw': instance.magnitudeRaw,
  'assumptive': instance.assumptive,
  'seismicEpicenter': instance.seismicEpicenter,
  'seismicEpicenterRaw': instance.seismicEpicenterRaw,
  'seismicIntensityLowerLimit': instance.seismicIntensityLowerLimit,
  'seismicIntensityLowerLimitRaw': instance.seismicIntensityLowerLimitRaw,
  'seismicIntensityUpperLimit': instance.seismicIntensityUpperLimit,
  'seismicIntensityUpperLimitRaw': instance.seismicIntensityUpperLimitRaw,
  'eewForecastRegions': instance.eewForecastRegions,
  'eewForecastRegionsRaw': instance.eewForecastRegionsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportHypocenter _$QzssDcReportHypocenterFromJson(
  Map<String, dynamic> json,
) => QzssDcReportHypocenter(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  version: (json['version'] as num).toInt(),
  reportClassification: json['reportClassification'] as String,
  reportClassificationEn: json['reportClassificationEn'] as String,
  reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
  disasterCategory: json['disasterCategory'] as String,
  disasterCategoryEn: json['disasterCategoryEn'] as String,
  disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
  reportTime: DateTime.parse(json['reportTime'] as String),
  informationType: json['informationType'] as String,
  informationTypeEn: json['informationTypeEn'] as String,
  informationTypeNo: (json['informationTypeNo'] as num).toInt(),
  notificationsOnDisasterPrevention:
      (json['notificationsOnDisasterPrevention'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  notificationsOnDisasterPreventionRaw:
      (json['notificationsOnDisasterPreventionRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  occurrenceTimeOfEarthquake: DateTime.parse(
    json['occurrenceTimeOfEarthquake'] as String,
  ),
  depthOfHypocenter: json['depthOfHypocenter'] as String,
  depthOfHypocenterRaw: (json['depthOfHypocenterRaw'] as num).toInt(),
  magnitude: json['magnitude'] as String,
  magnitudeRaw: (json['magnitudeRaw'] as num).toInt(),
  seismicEpicenter: json['seismicEpicenter'] as String,
  seismicEpicenterRaw: (json['seismicEpicenterRaw'] as num).toInt(),
  coordinatesOfHypocenter: HypocenterCoordinates.fromJson(
    json['coordinatesOfHypocenter'] as Map<String, dynamic>,
  ),
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportHypocenterToJson(
  QzssDcReportHypocenter instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'notificationsOnDisasterPrevention':
      instance.notificationsOnDisasterPrevention,
  'notificationsOnDisasterPreventionRaw':
      instance.notificationsOnDisasterPreventionRaw,
  'occurrenceTimeOfEarthquake': instance.occurrenceTimeOfEarthquake
      .toIso8601String(),
  'depthOfHypocenter': instance.depthOfHypocenter,
  'depthOfHypocenterRaw': instance.depthOfHypocenterRaw,
  'magnitude': instance.magnitude,
  'magnitudeRaw': instance.magnitudeRaw,
  'seismicEpicenter': instance.seismicEpicenter,
  'seismicEpicenterRaw': instance.seismicEpicenterRaw,
  'coordinatesOfHypocenter': instance.coordinatesOfHypocenter.toJson(),
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportSeismicIntensity _$QzssDcReportSeismicIntensityFromJson(
  Map<String, dynamic> json,
) => QzssDcReportSeismicIntensity(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  version: (json['version'] as num).toInt(),
  reportClassification: json['reportClassification'] as String,
  reportClassificationEn: json['reportClassificationEn'] as String,
  reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
  disasterCategory: json['disasterCategory'] as String,
  disasterCategoryEn: json['disasterCategoryEn'] as String,
  disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
  reportTime: DateTime.parse(json['reportTime'] as String),
  informationType: json['informationType'] as String,
  informationTypeEn: json['informationTypeEn'] as String,
  informationTypeNo: (json['informationTypeNo'] as num).toInt(),
  occurrenceTimeOfEarthquake: DateTime.parse(
    json['occurrenceTimeOfEarthquake'] as String,
  ),
  seismicIntensities: (json['seismicIntensities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  seismicIntensitiesRaw: (json['seismicIntensitiesRaw'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  prefectures: (json['prefectures'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  prefecturesRaw: (json['prefecturesRaw'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportSeismicIntensityToJson(
  QzssDcReportSeismicIntensity instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'occurrenceTimeOfEarthquake': instance.occurrenceTimeOfEarthquake
      .toIso8601String(),
  'seismicIntensities': instance.seismicIntensities,
  'seismicIntensitiesRaw': instance.seismicIntensitiesRaw,
  'prefectures': instance.prefectures,
  'prefecturesRaw': instance.prefecturesRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportTsunami _$QzssDcReportTsunamiFromJson(Map<String, dynamic> json) =>
    QzssDcReportTsunami(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      notificationsOnDisasterPrevention:
          (json['notificationsOnDisasterPrevention'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      notificationsOnDisasterPreventionRaw:
          (json['notificationsOnDisasterPreventionRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      tsunamiWarningCode: json['tsunamiWarningCode'] as String,
      tsunamiWarningCodeRaw: (json['tsunamiWarningCodeRaw'] as num).toInt(),
      expectedTsunamiArrivalTimes:
          (json['expectedTsunamiArrivalTimes'] as List<dynamic>)
              .map((e) => e == null ? null : DateTime.parse(e as String))
              .toList(),
      tsunamiHeights: (json['tsunamiHeights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tsunamiHeightsRaw: (json['tsunamiHeightsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      tsunamiForecastRegions: (json['tsunamiForecastRegions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tsunamiForecastRegionsRaw:
          (json['tsunamiForecastRegionsRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportTsunamiToJson(
  QzssDcReportTsunami instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'notificationsOnDisasterPrevention':
      instance.notificationsOnDisasterPrevention,
  'notificationsOnDisasterPreventionRaw':
      instance.notificationsOnDisasterPreventionRaw,
  'tsunamiWarningCode': instance.tsunamiWarningCode,
  'tsunamiWarningCodeRaw': instance.tsunamiWarningCodeRaw,
  'expectedTsunamiArrivalTimes': instance.expectedTsunamiArrivalTimes
      .map((e) => e?.toIso8601String())
      .toList(),
  'tsunamiHeights': instance.tsunamiHeights,
  'tsunamiHeightsRaw': instance.tsunamiHeightsRaw,
  'tsunamiForecastRegions': instance.tsunamiForecastRegions,
  'tsunamiForecastRegionsRaw': instance.tsunamiForecastRegionsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportNankaiTroughEarthquake _$QzssDcReportNankaiTroughEarthquakeFromJson(
  Map<String, dynamic> json,
) => QzssDcReportNankaiTroughEarthquake(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  version: (json['version'] as num).toInt(),
  reportClassification: json['reportClassification'] as String,
  reportClassificationEn: json['reportClassificationEn'] as String,
  reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
  disasterCategory: json['disasterCategory'] as String,
  disasterCategoryEn: json['disasterCategoryEn'] as String,
  disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
  reportTime: DateTime.parse(json['reportTime'] as String),
  informationType: json['informationType'] as String,
  informationTypeEn: json['informationTypeEn'] as String,
  informationTypeNo: (json['informationTypeNo'] as num).toInt(),
  informationSerialCode: json['informationSerialCode'] as String,
  informationSerialCodeRaw: (json['informationSerialCodeRaw'] as num).toInt(),
  textInformation: const Uint8ListConverter().fromJson(
    json['textInformation'] as String,
  ),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportNankaiTroughEarthquakeToJson(
  QzssDcReportNankaiTroughEarthquake instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'informationSerialCode': instance.informationSerialCode,
  'informationSerialCodeRaw': instance.informationSerialCodeRaw,
  'textInformation': const Uint8ListConverter().toJson(
    instance.textInformation,
  ),
  'pageNumber': instance.pageNumber,
  'totalPage': instance.totalPage,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportNorthwestPacificTsunami
_$QzssDcReportNorthwestPacificTsunamiFromJson(Map<String, dynamic> json) =>
    QzssDcReportNorthwestPacificTsunami(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      tsunamigenicPotentialEn: json['tsunamigenicPotentialEn'] as String,
      tsunamigenicPotentialRaw: (json['tsunamigenicPotentialRaw'] as num)
          .toInt(),
      expectedTsunamiArrivalTimes:
          (json['expectedTsunamiArrivalTimes'] as List<dynamic>)
              .map((e) => e == null ? null : DateTime.parse(e as String))
              .toList(),
      tsunamiHeightsEn: (json['tsunamiHeightsEn'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tsunamiHeightsRaw: (json['tsunamiHeightsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      coastalRegionsEn: (json['coastalRegionsEn'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      coastalRegionsRaw: (json['coastalRegionsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportNorthwestPacificTsunamiToJson(
  QzssDcReportNorthwestPacificTsunami instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'tsunamigenicPotentialEn': instance.tsunamigenicPotentialEn,
  'tsunamigenicPotentialRaw': instance.tsunamigenicPotentialRaw,
  'expectedTsunamiArrivalTimes': instance.expectedTsunamiArrivalTimes
      .map((e) => e?.toIso8601String())
      .toList(),
  'tsunamiHeightsEn': instance.tsunamiHeightsEn,
  'tsunamiHeightsRaw': instance.tsunamiHeightsRaw,
  'coastalRegionsEn': instance.coastalRegionsEn,
  'coastalRegionsRaw': instance.coastalRegionsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportFlood _$QzssDcReportFloodFromJson(Map<String, dynamic> json) =>
    QzssDcReportFlood(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      floodWarningLevels: (json['floodWarningLevels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      floodWarningLevelsRaw: (json['floodWarningLevelsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      floodForecastRegions: (json['floodForecastRegions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      floodForecastRegionsRaw:
          (json['floodForecastRegionsRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportFloodToJson(QzssDcReportFlood instance) =>
    <String, dynamic>{
      'sentence': instance.sentence,
      'message': const Uint8ListConverter().toJson(instance.message),
      'nmea': instance.nmea,
      'raw': const Uint8ListConverter().toJson(instance.raw),
      'preamble': instance.preamble,
      'messageType': instance.messageType,
      'version': instance.version,
      'reportClassification': instance.reportClassification,
      'reportClassificationEn': instance.reportClassificationEn,
      'reportClassificationNo': instance.reportClassificationNo,
      'disasterCategory': instance.disasterCategory,
      'disasterCategoryEn': instance.disasterCategoryEn,
      'disasterCategoryNo': instance.disasterCategoryNo,
      'reportTime': instance.reportTime.toIso8601String(),
      'informationType': instance.informationType,
      'informationTypeEn': instance.informationTypeEn,
      'informationTypeNo': instance.informationTypeNo,
      'floodWarningLevels': instance.floodWarningLevels,
      'floodWarningLevelsRaw': instance.floodWarningLevelsRaw,
      'floodForecastRegions': instance.floodForecastRegions,
      'floodForecastRegionsRaw': instance.floodForecastRegionsRaw,
      'messageHeader': instance.messageHeader,
      'satelliteId': instance.satelliteId,
      'satellitePrn': instance.satellitePrn,
      'runtimeType': instance.$type,
    };

QzssDcReportMarine _$QzssDcReportMarineFromJson(Map<String, dynamic> json) =>
    QzssDcReportMarine(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      marineWarningCodes: (json['marineWarningCodes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      marineWarningCodesRaw: (json['marineWarningCodesRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      marineForecastRegions: (json['marineForecastRegions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      marineForecastRegionsRaw:
          (json['marineForecastRegionsRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportMarineToJson(QzssDcReportMarine instance) =>
    <String, dynamic>{
      'sentence': instance.sentence,
      'message': const Uint8ListConverter().toJson(instance.message),
      'nmea': instance.nmea,
      'raw': const Uint8ListConverter().toJson(instance.raw),
      'preamble': instance.preamble,
      'messageType': instance.messageType,
      'version': instance.version,
      'reportClassification': instance.reportClassification,
      'reportClassificationEn': instance.reportClassificationEn,
      'reportClassificationNo': instance.reportClassificationNo,
      'disasterCategory': instance.disasterCategory,
      'disasterCategoryEn': instance.disasterCategoryEn,
      'disasterCategoryNo': instance.disasterCategoryNo,
      'reportTime': instance.reportTime.toIso8601String(),
      'informationType': instance.informationType,
      'informationTypeEn': instance.informationTypeEn,
      'informationTypeNo': instance.informationTypeNo,
      'marineWarningCodes': instance.marineWarningCodes,
      'marineWarningCodesRaw': instance.marineWarningCodesRaw,
      'marineForecastRegions': instance.marineForecastRegions,
      'marineForecastRegionsRaw': instance.marineForecastRegionsRaw,
      'messageHeader': instance.messageHeader,
      'satelliteId': instance.satelliteId,
      'satellitePrn': instance.satellitePrn,
      'runtimeType': instance.$type,
    };

QzssDcReportWeather _$QzssDcReportWeatherFromJson(Map<String, dynamic> json) =>
    QzssDcReportWeather(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      weatherWarningState: json['weatherWarningState'] as String,
      weatherWarningStateRaw: (json['weatherWarningStateRaw'] as num).toInt(),
      weatherRelatedDisasterSubCategories:
          (json['weatherRelatedDisasterSubCategories'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      weatherRelatedDisasterSubCategoriesRaw:
          (json['weatherRelatedDisasterSubCategoriesRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      weatherForecastRegions: (json['weatherForecastRegions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      weatherForecastRegionsRaw:
          (json['weatherForecastRegionsRaw'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportWeatherToJson(
  QzssDcReportWeather instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'weatherWarningState': instance.weatherWarningState,
  'weatherWarningStateRaw': instance.weatherWarningStateRaw,
  'weatherRelatedDisasterSubCategories':
      instance.weatherRelatedDisasterSubCategories,
  'weatherRelatedDisasterSubCategoriesRaw':
      instance.weatherRelatedDisasterSubCategoriesRaw,
  'weatherForecastRegions': instance.weatherForecastRegions,
  'weatherForecastRegionsRaw': instance.weatherForecastRegionsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportVolcano _$QzssDcReportVolcanoFromJson(Map<String, dynamic> json) =>
    QzssDcReportVolcano(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      ambiguityOfActivityTimeNo: (json['ambiguityOfActivityTimeNo'] as num)
          .toInt(),
      activityTime: DateTime.parse(json['activityTime'] as String),
      volcanicWarningCode: json['volcanicWarningCode'] as String,
      volcanicWarningCodeRaw: (json['volcanicWarningCodeRaw'] as num).toInt(),
      volcanoName: json['volcanoName'] as String,
      volcanoNameRaw: (json['volcanoNameRaw'] as num).toInt(),
      localGovernments: (json['localGovernments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      localGovernmentsRaw: (json['localGovernmentsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportVolcanoToJson(
  QzssDcReportVolcano instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'ambiguityOfActivityTimeNo': instance.ambiguityOfActivityTimeNo,
  'activityTime': instance.activityTime.toIso8601String(),
  'volcanicWarningCode': instance.volcanicWarningCode,
  'volcanicWarningCodeRaw': instance.volcanicWarningCodeRaw,
  'volcanoName': instance.volcanoName,
  'volcanoNameRaw': instance.volcanoNameRaw,
  'localGovernments': instance.localGovernments,
  'localGovernmentsRaw': instance.localGovernmentsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportAshFall _$QzssDcReportAshFallFromJson(Map<String, dynamic> json) =>
    QzssDcReportAshFall(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      activityTime: DateTime.parse(json['activityTime'] as String),
      ashFallWarningType: json['ashFallWarningType'] as String,
      ashFallWarningTypeRaw: (json['ashFallWarningTypeRaw'] as num).toInt(),
      volcanoName: json['volcanoName'] as String,
      volcanoNameRaw: (json['volcanoNameRaw'] as num).toInt(),
      expectedAshFallTimes: (json['expectedAshFallTimes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      ashFallWarningCodes: (json['ashFallWarningCodes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ashFallWarningCodesRaw: (json['ashFallWarningCodesRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      localGovernments: (json['localGovernments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      localGovernmentsRaw: (json['localGovernmentsRaw'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportAshFallToJson(
  QzssDcReportAshFall instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'activityTime': instance.activityTime.toIso8601String(),
  'ashFallWarningType': instance.ashFallWarningType,
  'ashFallWarningTypeRaw': instance.ashFallWarningTypeRaw,
  'volcanoName': instance.volcanoName,
  'volcanoNameRaw': instance.volcanoNameRaw,
  'expectedAshFallTimes': instance.expectedAshFallTimes,
  'ashFallWarningCodes': instance.ashFallWarningCodes,
  'ashFallWarningCodesRaw': instance.ashFallWarningCodesRaw,
  'localGovernments': instance.localGovernments,
  'localGovernmentsRaw': instance.localGovernmentsRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportTyphoon _$QzssDcReportTyphoonFromJson(Map<String, dynamic> json) =>
    QzssDcReportTyphoon(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      version: (json['version'] as num).toInt(),
      reportClassification: json['reportClassification'] as String,
      reportClassificationEn: json['reportClassificationEn'] as String,
      reportClassificationNo: (json['reportClassificationNo'] as num).toInt(),
      disasterCategory: json['disasterCategory'] as String,
      disasterCategoryEn: json['disasterCategoryEn'] as String,
      disasterCategoryNo: (json['disasterCategoryNo'] as num).toInt(),
      reportTime: DateTime.parse(json['reportTime'] as String),
      informationType: json['informationType'] as String,
      informationTypeEn: json['informationTypeEn'] as String,
      informationTypeNo: (json['informationTypeNo'] as num).toInt(),
      referenceTime: DateTime.parse(json['referenceTime'] as String),
      referenceTimeType: json['referenceTimeType'] as String,
      referenceTimeTypeRaw: (json['referenceTimeTypeRaw'] as num).toInt(),
      elapsedTimeFromReferenceTime:
          (json['elapsedTimeFromReferenceTime'] as num).toInt(),
      typhoonNumber: json['typhoonNumber'] as String,
      typhoonNumberRaw: (json['typhoonNumberRaw'] as num).toInt(),
      typhoonScaleCategory: json['typhoonScaleCategory'] as String,
      typhoonScaleCategoryRaw: (json['typhoonScaleCategoryRaw'] as num).toInt(),
      typhoonIntensityCategory: json['typhoonIntensityCategory'] as String,
      typhoonIntensityCategoryRaw: (json['typhoonIntensityCategoryRaw'] as num)
          .toInt(),
      coordinatesOfTyphoon: HypocenterCoordinates.fromJson(
        json['coordinatesOfTyphoon'] as Map<String, dynamic>,
      ),
      centralPressure: json['centralPressure'] as String,
      centralPressureRaw: (json['centralPressureRaw'] as num).toInt(),
      maximumWindSpeed: json['maximumWindSpeed'] as String,
      maximumWindSpeedRaw: (json['maximumWindSpeedRaw'] as num).toInt(),
      maximumGustWindSpeed: json['maximumGustWindSpeed'] as String,
      maximumGustWindSpeedRaw: (json['maximumGustWindSpeedRaw'] as num).toInt(),
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportTyphoonToJson(
  QzssDcReportTyphoon instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'version': instance.version,
  'reportClassification': instance.reportClassification,
  'reportClassificationEn': instance.reportClassificationEn,
  'reportClassificationNo': instance.reportClassificationNo,
  'disasterCategory': instance.disasterCategory,
  'disasterCategoryEn': instance.disasterCategoryEn,
  'disasterCategoryNo': instance.disasterCategoryNo,
  'reportTime': instance.reportTime.toIso8601String(),
  'informationType': instance.informationType,
  'informationTypeEn': instance.informationTypeEn,
  'informationTypeNo': instance.informationTypeNo,
  'referenceTime': instance.referenceTime.toIso8601String(),
  'referenceTimeType': instance.referenceTimeType,
  'referenceTimeTypeRaw': instance.referenceTimeTypeRaw,
  'elapsedTimeFromReferenceTime': instance.elapsedTimeFromReferenceTime,
  'typhoonNumber': instance.typhoonNumber,
  'typhoonNumberRaw': instance.typhoonNumberRaw,
  'typhoonScaleCategory': instance.typhoonScaleCategory,
  'typhoonScaleCategoryRaw': instance.typhoonScaleCategoryRaw,
  'typhoonIntensityCategory': instance.typhoonIntensityCategory,
  'typhoonIntensityCategoryRaw': instance.typhoonIntensityCategoryRaw,
  'coordinatesOfTyphoon': instance.coordinatesOfTyphoon.toJson(),
  'centralPressure': instance.centralPressure,
  'centralPressureRaw': instance.centralPressureRaw,
  'maximumWindSpeed': instance.maximumWindSpeed,
  'maximumWindSpeedRaw': instance.maximumWindSpeedRaw,
  'maximumGustWindSpeed': instance.maximumGustWindSpeed,
  'maximumGustWindSpeedRaw': instance.maximumGustWindSpeedRaw,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxNull _$QzssDcReportDcxNullFromJson(Map<String, dynamic> json) =>
    QzssDcReportDcxNull(
      sentence: json['sentence'] as String,
      message: const Uint8ListConverter().fromJson(json['message'] as String),
      nmea: json['nmea'] as String,
      raw: const Uint8ListConverter().fromJson(json['raw'] as String),
      preamble: json['preamble'] as String,
      messageType: json['messageType'] as String,
      dcxMessageType: json['dcxMessageType'] as String,
      messageHeader: json['messageHeader'] as String?,
      satelliteId: (json['satelliteId'] as num?)?.toInt(),
      satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$QzssDcReportDcxNullToJson(
  QzssDcReportDcxNull instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxOutsideJapan _$QzssDcReportDcxOutsideJapanFromJson(
  Map<String, dynamic> json,
) => QzssDcReportDcxOutsideJapan(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  dcxMessageType: json['dcxMessageType'] as String,
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportDcxOutsideJapanToJson(
  QzssDcReportDcxOutsideJapan instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxLAlert _$QzssDcReportDcxLAlertFromJson(
  Map<String, dynamic> json,
) => QzssDcReportDcxLAlert(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  dcxMessageType: json['dcxMessageType'] as String,
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportDcxLAlertToJson(
  QzssDcReportDcxLAlert instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxJAlert _$QzssDcReportDcxJAlertFromJson(
  Map<String, dynamic> json,
) => QzssDcReportDcxJAlert(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  dcxMessageType: json['dcxMessageType'] as String,
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportDcxJAlertToJson(
  QzssDcReportDcxJAlert instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxMTInfo _$QzssDcReportDcxMTInfoFromJson(
  Map<String, dynamic> json,
) => QzssDcReportDcxMTInfo(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  dcxMessageType: json['dcxMessageType'] as String,
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportDcxMTInfoToJson(
  QzssDcReportDcxMTInfo instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};

QzssDcReportDcxUnknown _$QzssDcReportDcxUnknownFromJson(
  Map<String, dynamic> json,
) => QzssDcReportDcxUnknown(
  sentence: json['sentence'] as String,
  message: const Uint8ListConverter().fromJson(json['message'] as String),
  nmea: json['nmea'] as String,
  raw: const Uint8ListConverter().fromJson(json['raw'] as String),
  preamble: json['preamble'] as String,
  messageType: json['messageType'] as String,
  dcxMessageType: json['dcxMessageType'] as String,
  messageHeader: json['messageHeader'] as String?,
  satelliteId: (json['satelliteId'] as num?)?.toInt(),
  satellitePrn: (json['satellitePrn'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$QzssDcReportDcxUnknownToJson(
  QzssDcReportDcxUnknown instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'message': const Uint8ListConverter().toJson(instance.message),
  'nmea': instance.nmea,
  'raw': const Uint8ListConverter().toJson(instance.raw),
  'preamble': instance.preamble,
  'messageType': instance.messageType,
  'dcxMessageType': instance.dcxMessageType,
  'messageHeader': instance.messageHeader,
  'satelliteId': instance.satelliteId,
  'satellitePrn': instance.satellitePrn,
  'runtimeType': instance.$type,
};
