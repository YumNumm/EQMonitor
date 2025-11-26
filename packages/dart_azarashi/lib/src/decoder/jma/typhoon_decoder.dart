import '../../definition/typhoon_intensity_category.dart';
import '../../definition/typhoon_reference_time_type.dart';
import '../../definition/typhoon_scale_category.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_common_decoder.dart';
import 'jma_decoder.dart';

/// Typhoon Decoder.
///
/// Decodes JMA Typhoon information messages.
class TyphoonDecoder {
  const TyphoonDecoder._();

  /// Decodes a Typhoon message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract reference time (bits 53-68, 16 bits: day 5 + hour 5 + minute 6)
    final referenceTime = JmaCommonDecoder.extractDayHourMin(params, 53);

    // Extract reference time type (bits 69-71, 3 bits)
    final dtCode = QzssDcrDecoder.extractField(message, 69, 3);
    final referenceTimeType = JmaTyphoonReferenceTimeType.fromCode(dtCode);
    if (referenceTimeType == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Type of Reference Time: $dtCode',
        sentence: sentence,
      );
    }

    // Extract elapsed time from reference time (bits 80-86, 7 bits)
    final elapsedTime = QzssDcrDecoder.extractField(message, 80, 7);

    // Extract typhoon number (bits 87-93, 7 bits)
    final tnCode = QzssDcrDecoder.extractField(message, 87, 7);
    if (tnCode < 1 || tnCode > 99) {
      throw QzssDcrDecoderException(
        'Invalid JMA Typhoon Number: $tnCode',
        sentence: sentence,
      );
    }
    final typhoonNumber = '$tnCode号';

    // Extract typhoon scale category (bits 94-97, 4 bits)
    final srCode = QzssDcrDecoder.extractField(message, 94, 4);
    final scaleCategory = JmaTyphoonScaleCategory.fromCode(srCode);
    if (scaleCategory == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Typhoon Scale Category: $srCode',
        sentence: sentence,
      );
    }

    // Extract typhoon intensity category (bits 98-101, 4 bits)
    final lcCode = QzssDcrDecoder.extractField(message, 98, 4);
    final intensityCategory = JmaTyphoonIntensityCategory.fromCode(lcCode);
    if (intensityCategory == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Typhoon Intensity Category: $lcCode',
        sentence: sentence,
      );
    }

    // Extract coordinates of typhoon (bits 102-142, 41 bits)
    final coordinates = JmaCommonDecoder.extractLatLon(message, 102, sentence);

    // Extract central pressure (bits 143-153, 11 bits)
    final prCode = QzssDcrDecoder.extractField(message, 143, 11);
    if (prCode > 1100) {
      throw QzssDcrDecoderException(
        'Invalid JMA Central Pressure: $prCode',
        sentence: sentence,
      );
    }
    final centralPressure = '${prCode}hPa';

    // Extract maximum wind speed (bits 154-160, 7 bits)
    final w1Code = QzssDcrDecoder.extractField(message, 154, 7);
    String maximumWindSpeed;
    if (w1Code == 0) {
      maximumWindSpeed = '不明';
    } else if (w1Code < 15 || w1Code > 105) {
      throw QzssDcrDecoderException(
        'Invalid JMA Maximum Wind Speed: $w1Code',
        sentence: sentence,
      );
    } else {
      maximumWindSpeed = '${w1Code}m/s';
    }

    // Extract maximum gust wind speed (bits 161-167, 7 bits)
    final w2Code = QzssDcrDecoder.extractField(message, 161, 7);
    String maximumGustWindSpeed;
    if (w2Code == 0) {
      maximumGustWindSpeed = '不明';
    } else if (w2Code < 15 || w2Code > 105) {
      throw QzssDcrDecoderException(
        'Invalid JMA Maximum Gust Wind Speed: $w2Code',
        sentence: sentence,
      );
    } else {
      maximumGustWindSpeed = '${w2Code}m/s';
    }

    return QzssDcReport.typhoon(
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
      referenceTime: referenceTime,
      referenceTimeType: referenceTimeType.nameJa,
      referenceTimeTypeRaw: dtCode,
      elapsedTimeFromReferenceTime: elapsedTime,
      typhoonNumber: typhoonNumber,
      typhoonNumberRaw: tnCode,
      typhoonScaleCategory: scaleCategory.nameJa,
      typhoonScaleCategoryRaw: srCode,
      typhoonIntensityCategory: intensityCategory.nameJa,
      typhoonIntensityCategoryRaw: lcCode,
      coordinatesOfTyphoon: coordinates,
      centralPressure: centralPressure,
      centralPressureRaw: prCode,
      maximumWindSpeed: maximumWindSpeed,
      maximumWindSpeedRaw: w1Code,
      maximumGustWindSpeed: maximumGustWindSpeed,
      maximumGustWindSpeedRaw: w2Code,
    );
  }
}
