import '../../definition/tsunami_forecast_region.dart';
import '../../definition/tsunami_height.dart';
import '../../definition/tsunami_warning_code.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_common_decoder.dart';
import 'jma_decoder.dart';

/// Tsunami Decoder.
class TsunamiDecoder {
  const TsunamiDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract notifications on disaster prevention (bits 43-69, 3x9 bits)
    final (notifications, notificationCodes) =
        JmaCommonDecoder.extractNotificationOnDisasterPrevention(message, 43);

    // Extract tsunami warning code (bits 70-73, 4 bits)
    final warningCode = QzssDcrDecoder.extractField(message, 70, 4);
    final tsunamiWarningCode = JmaTsunamiWarningCode.values
        .where((e) => e.code == warningCode)
        .firstOrNull;
    if (tsunamiWarningCode == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Tsunami Warning Code: $warningCode',
        sentence: sentence,
      );
    }

    // Extract tsunami forecast data (up to 5 entries)
    // Each entry: 12 bits arrival time + 4 bits height + 10 bits region = 26 bits
    final expectedArrivalTimes = <DateTime?>[];
    final tsunamiHeights = <JmaTsunamiHeight>[];
    final tsunamiHeightCodes = <int>[];
    final tsunamiForecastRegions = <JmaTsunamiForecastRegion>[];
    final tsunamiForecastRegionCodes = <int>[];

    var slider = 74;
    for (var entry = 0; entry < 5; entry++) {
      // Extract arrival time (12 bits)
      final arrivalTime = JmaCommonDecoder.extractExpectedTsunamiArrivalTime(
        message,
        slider,
        params.reportTime,
      );

      // Extract height (4 bits)
      final heightCode = QzssDcrDecoder.extractField(message, slider + 12, 4);
      if (heightCode == 0) {
        break; // End of entries
      }
      final height = JmaTsunamiHeight.values
          .where((e) => e.code == heightCode)
          .firstOrNull;
      if (height == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Tsunami Height: $heightCode',
          sentence: sentence,
        );
      }

      // Extract region (10 bits)
      final regionCode = QzssDcrDecoder.extractField(message, slider + 16, 10);
      final region = JmaTsunamiForecastRegion.values
          .where((e) => e.code == regionCode)
          .firstOrNull;
      if (region == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Tsunami Forecast Region: $regionCode',
          sentence: sentence,
        );
      }

      expectedArrivalTimes.add(arrivalTime);
      tsunamiHeights.add(height);
      tsunamiHeightCodes.add(heightCode);
      tsunamiForecastRegions.add(region);
      tsunamiForecastRegionCodes.add(regionCode);

      slider += 26;
    }

    return QzssDcReport.tsunami(
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
      tsunamiWarningCode: tsunamiWarningCode.name,
      tsunamiWarningCodeRaw: warningCode,
      expectedTsunamiArrivalTimes: expectedArrivalTimes,
      tsunamiHeights: tsunamiHeights.map((e) => e.name).toList(),
      tsunamiHeightsRaw: tsunamiHeightCodes,
      tsunamiForecastRegions:
          tsunamiForecastRegions.map((e) => e.name).toList(),
      tsunamiForecastRegionsRaw: tsunamiForecastRegionCodes,
    );
  }
}

