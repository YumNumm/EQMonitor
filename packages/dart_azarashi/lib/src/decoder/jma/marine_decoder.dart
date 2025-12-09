import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/marine_forecast_region.dart';
import 'package:dart_azarashi/src/definition/marine_warning_code.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Marine Decoder.
///
/// Decodes JMA Marine information messages.
class MarineDecoder {
  const MarineDecoder._();

  /// Decodes a Marine message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract marine information items (up to 8 items)
    final marineWarningCodes = <String>[];
    final marineWarningCodesRaw = <int>[];
    final marineForecastRegions = <String>[];
    final marineForecastRegionsRaw = <int>[];

    for (var i = 0; i < 8; i++) {
      final offset = 53 + i * 19;
      final dwCode = QzssDcrDecoder.extractField(message, offset, 5);
      final plCode = QzssDcrDecoder.extractField(message, offset + 5, 14);

      // Check if this item is empty
      if (dwCode == 0 && plCode == 0) {
        break;
      }

      // Extract marine warning code (bits offset, 5 bits)
      final warningCode = JmaMarineWarningCode.fromCode(dwCode);
      if (warningCode == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Marine Warning Code: $dwCode',
          sentence: sentence,
        );
      }
      marineWarningCodes.add(warningCode.nameJa);
      marineWarningCodesRaw.add(dwCode);

      // Extract marine forecast region (bits offset+5, 14 bits)
      final forecastRegion = JmaMarineForecastRegion.fromCode(plCode);
      if (forecastRegion == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Marine Forecast Region: $plCode',
          sentence: sentence,
        );
      }
      marineForecastRegions.add(forecastRegion.nameJa);
      marineForecastRegionsRaw.add(plCode);
    }

    return QzssDcReport.marine(
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
      marineWarningCodes: marineWarningCodes,
      marineWarningCodesRaw: marineWarningCodesRaw,
      marineForecastRegions: marineForecastRegions,
      marineForecastRegionsRaw: marineForecastRegionsRaw,
    );
  }
}
