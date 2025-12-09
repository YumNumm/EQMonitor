import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/flood_forecast_region.dart';
import 'package:dart_azarashi/src/definition/flood_warning_level.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Flood Decoder.
///
/// Decodes JMA Flood information messages.
class FloodDecoder {
  const FloodDecoder._();

  /// Decodes a Flood message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract flood information items (up to 3 items)
    final floodWarningLevels = <String>[];
    final floodWarningLevelsRaw = <int>[];
    final floodForecastRegions = <String>[];
    final floodForecastRegionsRaw = <int>[];

    for (var i = 0; i < 3; i++) {
      final offset = 53 + i * 44;

      // Check if this item is empty (all bits are 0)
      if (QzssDcrDecoder.extractField(message, offset, 44) == 0) {
        break;
      }

      // Extract flood warning level (bits offset, 4 bits)
      final lvCode = QzssDcrDecoder.extractField(message, offset, 4);
      final warningLevel = JmaFloodWarningLevel.fromCode(lvCode);
      if (warningLevel == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Flood Warning Level: $lvCode',
          sentence: sentence,
        );
      }
      floodWarningLevels.add(warningLevel.nameJa);
      floodWarningLevelsRaw.add(lvCode);

      // Extract flood forecast region (bits offset+4, 40 bits)
      final plCode = QzssDcrDecoder.extractField(message, offset + 4, 40);
      final regionName = JmaFloodForecastRegion.fromCode(plCode);
      if (regionName == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Flood Forecast Region: $plCode',
          sentence: sentence,
        );
      }
      floodForecastRegions.add(regionName);
      floodForecastRegionsRaw.add(plCode);
    }

    return QzssDcReport.flood(
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
      floodWarningLevels: floodWarningLevels,
      floodWarningLevelsRaw: floodWarningLevelsRaw,
      floodForecastRegions: floodForecastRegions,
      floodForecastRegionsRaw: floodForecastRegionsRaw,
    );
  }
}
