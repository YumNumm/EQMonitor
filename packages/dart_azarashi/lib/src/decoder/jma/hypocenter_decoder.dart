import 'package:dart_azarashi/src/decoder/jma/jma_common_decoder.dart';
import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Hypocenter Decoder.
class HypocenterDecoder {
  const HypocenterDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract notifications on disaster prevention (bits 53-79, 3x9 bits)
    final (notifications, notificationCodes) =
        JmaCommonDecoder.extractNotificationOnDisasterPrevention(message, 53);

    // Extract occurrence time of earthquake (bits 80-95, 16 bits)
    final occurrenceTime = JmaCommonDecoder.extractDayHourMin(params, 80);

    // Extract depth of hypocenter (bits 96-104, 9 bits)
    final (depth, depthRaw) = JmaCommonDecoder.extractDepth(message, 96);

    // Extract magnitude (bits 105-111, 7 bits)
    final (magnitude, magnitudeRaw) = JmaCommonDecoder.extractMagnitude(
      message,
      105,
    );

    // Extract seismic epicenter (bits 112-121, 10 bits)
    final (epicenter, epicenterRaw) = JmaCommonDecoder.extractSeismicEpicenter(
      message,
      112,
      sentence,
    );

    // Extract coordinates of hypocenter (bits 122-162, 41 bits)
    final coordinates = JmaCommonDecoder.extractLatLon(message, 122, sentence);

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
      notificationsOnDisasterPrevention: notifications
          .map((e) => e.message)
          .toList(),
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
