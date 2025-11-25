import '../../definition/eew_forecast_region.dart';
import '../../definition/seismic_intensity.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_common_decoder.dart';
import 'jma_decoder.dart';

/// Earthquake Early Warning Decoder.
class EarthquakeEarlyWarningDecoder {
  const EarthquakeEarlyWarningDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract long period ground motion lower limit (bits 47-49, 3 bits)
    final lgllCode = QzssDcrDecoder.extractField(message, 47, 3);
    final longPeriodGroundMotionLowerLimit =
        JmaLongPeriodGroundMotionLowerLimit.values
            .where((e) => e.code == lgllCode)
            .firstOrNull;
    if (longPeriodGroundMotionLowerLimit == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Long-period Ground Motion Lower Limit: $lgllCode',
        sentence: sentence,
      );
    }

    // Extract long period ground motion upper limit (bits 50-52, 3 bits)
    final lgulCode = QzssDcrDecoder.extractField(message, 50, 3);
    final longPeriodGroundMotionUpperLimit =
        JmaLongPeriodGroundMotionUpperLimit.values
            .where((e) => e.code == lgulCode)
            .firstOrNull;
    if (longPeriodGroundMotionUpperLimit == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Long-period Ground Motion Upper Limit: $lgulCode',
        sentence: sentence,
      );
    }

    // Extract notifications on disaster prevention (bits 53-79, 3x9 bits)
    final (notifications, notificationCodes) =
        JmaCommonDecoder.extractNotificationOnDisasterPrevention(message, 53);

    // Extract occurrence time of earthquake (bits 80-95, 16 bits)
    final occurrenceTime = JmaCommonDecoder.extractDayHourMin(params, 80);

    // Extract depth of hypocenter (bits 96-104, 9 bits)
    final (depth, depthRaw) = JmaCommonDecoder.extractDepth(message, 96);

    // Extract magnitude (bits 105-111, 7 bits)
    final (magnitude, magnitudeRaw) =
        JmaCommonDecoder.extractMagnitude(message, 105);

    // Extract seismic epicenter (bits 112-121, 10 bits)
    final (epicenter, epicenterRaw) =
        JmaCommonDecoder.extractSeismicEpicenter(message, 112, sentence);

    // Check if assumptive
    final assumptive = depthRaw == 10 && magnitudeRaw == 10;

    // Extract seismic intensity lower limit (bits 122-125, 4 bits)
    final llCode = QzssDcrDecoder.extractField(message, 122, 4);
    final seismicIntensityLowerLimit = JmaSeismicIntensityLowerLimit.values
        .where((e) => e.code == llCode)
        .firstOrNull;
    if (seismicIntensityLowerLimit == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Seismic Intensity Lower Limit: $llCode',
        sentence: sentence,
      );
    }

    // Extract seismic intensity upper limit (bits 126-129, 4 bits)
    final ulCode = QzssDcrDecoder.extractField(message, 126, 4);
    final seismicIntensityUpperLimit = JmaSeismicIntensityUpperLimit.values
        .where((e) => e.code == ulCode)
        .firstOrNull;
    if (seismicIntensityUpperLimit == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Seismic Intensity Upper Limit: $ulCode',
        sentence: sentence,
      );
    }

    // Extract EEW forecast regions (bits 130-209, 80 bits)
    final eewForecastRegions = <JmaEewForecastRegion>[];
    final eewForecastRegionCodes = <int>[];
    for (var i = 0; i < 80; i++) {
      if (QzssDcrDecoder.extractField(message, 130 + i, 1) == 1) {
        final region = JmaEewForecastRegion.values
            .where((e) => e.code == i + 1)
            .firstOrNull;
        if (region != null) {
          eewForecastRegions.add(region);
          eewForecastRegionCodes.add(i + 1);
        }
      }
    }

    return QzssDcReport.earthquakeEarlyWarning(
      sentence: params.sentence,
      message: params.message,
      nmea: params.nmea,
      messageHeader: params.messageHeader,
      satelliteId: params.satelliteId,
      satellitePrn: params.satellitePrn,
      raw: params.raw,
      preamble: params.preamble,
      messageType: 'DCR',
      version: params.version,
      reportClassification: params.reportClassification.nameJa,
      reportClassificationEn: params.reportClassification.nameEn,
      reportClassificationNo: params.reportClassification.code,
      disasterCategory: params.disasterCategory.nameJa,
      disasterCategoryEn: params.disasterCategory.nameEn,
      disasterCategoryNo: params.disasterCategory.code,
      reportTime: params.reportTime,
      informationType: params.informationType.nameJa,
      informationTypeEn: params.informationType.nameEn,
      informationTypeNo: params.informationType.code,
      longPeriodGroundMotionLowerLimit: longPeriodGroundMotionLowerLimit.name,
      longPeriodGroundMotionLowerLimitRaw: lgllCode,
      longPeriodGroundMotionUpperLimit: longPeriodGroundMotionUpperLimit.name,
      longPeriodGroundMotionUpperLimitRaw: lgulCode,
      notificationsOnDisasterPrevention:
          notifications.map((e) => e.message).toList(),
      notificationsOnDisasterPreventionRaw: notificationCodes,
      occurrenceTimeOfEarthquake: occurrenceTime,
      depthOfHypocenter: depth,
      depthOfHypocenterRaw: depthRaw,
      magnitude: magnitude,
      magnitudeRaw: magnitudeRaw,
      assumptive: assumptive,
      seismicEpicenter: epicenter.name,
      seismicEpicenterRaw: epicenterRaw,
      seismicIntensityLowerLimit: seismicIntensityLowerLimit.name,
      seismicIntensityLowerLimitRaw: llCode,
      seismicIntensityUpperLimit: seismicIntensityUpperLimit.name,
      seismicIntensityUpperLimitRaw: ulCode,
      eewForecastRegions: eewForecastRegions.map((e) => e.name).toList(),
      eewForecastRegionsRaw: eewForecastRegionCodes,
    );
  }
}

