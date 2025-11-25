import '../../model/report/qzss_dc_report.dart';
import 'jma_common_decoder.dart';
import 'jma_decoder.dart';

/// Hypocenter Decoder.
class HypocenterDecoder {
  const HypocenterDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract notifications on disaster prevention (bits 43-69, 3x9 bits)
    final (notifications, notificationCodes) =
        JmaCommonDecoder.extractNotificationOnDisasterPrevention(message, 43);

    // Extract occurrence time of earthquake (bits 70-85, 16 bits)
    final occurrenceTime = JmaCommonDecoder.extractDayHourMin(params, 70);

    // Extract depth of hypocenter (bits 86-94, 9 bits)
    final (depth, depthRaw) = JmaCommonDecoder.extractDepth(message, 86);

    // Extract magnitude (bits 95-101, 7 bits)
    final (magnitude, magnitudeRaw) =
        JmaCommonDecoder.extractMagnitude(message, 95);

    // Extract seismic epicenter (bits 102-111, 10 bits)
    final (epicenter, epicenterRaw) =
        JmaCommonDecoder.extractSeismicEpicenter(message, 102, sentence);

    // Extract coordinates of hypocenter (bits 112-152, 41 bits)
    final coordinates =
        JmaCommonDecoder.extractLatLon(message, 112, sentence);

    return QzssDcReport.hypocenter(
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
      notificationsOnDisasterPrevention:
          notifications.map((e) => e.message).toList(),
      notificationsOnDisasterPreventionRaw: notificationCodes,
      occurrenceTimeOfEarthquake: occurrenceTime,
      depthOfHypocenter: depth,
      depthOfHypocenterRaw: depthRaw,
      magnitude: magnitude,
      magnitudeRaw: magnitudeRaw,
      seismicEpicenter: epicenter.name,
      seismicEpicenterRaw: epicenterRaw,
      coordinatesOfHypocenter: coordinates,
    );
  }
}

