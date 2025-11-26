import '../../definition/weather_forecast_region.dart';
import '../../definition/weather_related_disaster_sub_category.dart';
import '../../definition/weather_warning_state.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_decoder.dart';

/// Weather Decoder.
///
/// Decodes JMA Weather information messages.
class WeatherDecoder {
  const WeatherDecoder._();

  /// Decodes a Weather message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract weather warning state (bits 53-55, 3 bits)
    final arCode = QzssDcrDecoder.extractField(message, 53, 3);
    final warningState = JmaWeatherWarningState.fromCode(arCode);
    if (warningState == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Warning State: $arCode',
        sentence: sentence,
      );
    }

    // Extract weather information items (up to 6 items)
    final weatherRelatedDisasterSubCategories = <String>[];
    final weatherRelatedDisasterSubCategoriesRaw = <int>[];
    final weatherForecastRegions = <String>[];
    final weatherForecastRegionsRaw = <int>[];

    for (var i = 0; i < 6; i++) {
      final offset = 56 + i * 24;

      // Check if this item is empty (all bits are 0)
      if (QzssDcrDecoder.extractField(message, offset, 24) == 0) {
        break;
      }

      // Extract weather related disaster sub category (bits offset, 5 bits)
      final wwCode = QzssDcrDecoder.extractField(message, offset, 5);
      final subCategory = JmaWeatherRelatedDisasterSubCategory.fromCode(wwCode);
      if (subCategory == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Disaster Sub-Category: $wwCode',
          sentence: sentence,
        );
      }
      weatherRelatedDisasterSubCategories.add(subCategory.nameJa);
      weatherRelatedDisasterSubCategoriesRaw.add(wwCode);

      // Extract weather forecast region (bits offset+5, 19 bits)
      final plCode = QzssDcrDecoder.extractField(message, offset + 5, 19);
      final regionName = JmaWeatherForecastRegion.fromCode(plCode);
      if (regionName == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Prefectural Forecast Region: $plCode',
          sentence: sentence,
        );
      }
      weatherForecastRegions.add(regionName);
      weatherForecastRegionsRaw.add(plCode);
    }

    return QzssDcReport.weather(
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
      weatherWarningState: warningState.nameJa,
      weatherWarningStateRaw: arCode,
      weatherRelatedDisasterSubCategories: weatherRelatedDisasterSubCategories,
      weatherRelatedDisasterSubCategoriesRaw:
          weatherRelatedDisasterSubCategoriesRaw,
      weatherForecastRegions: weatherForecastRegions,
      weatherForecastRegionsRaw: weatherForecastRegionsRaw,
    );
  }
}
