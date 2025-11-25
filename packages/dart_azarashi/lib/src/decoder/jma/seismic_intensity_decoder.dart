import '../../definition/prefecture.dart';
import '../../definition/seismic_intensity.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_common_decoder.dart';
import 'jma_decoder.dart';

/// Seismic Intensity Decoder.
class SeismicIntensityDecoder {
  const SeismicIntensityDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract occurrence time of earthquake (bits 43-58, 16 bits)
    final occurrenceTime = JmaCommonDecoder.extractDayHourMin(params, 43);

    // Extract seismic intensities and prefectures
    // Each entry: 3 bits intensity + 47 bits prefecture bitmap = 50 bits
    // Maximum 3 entries
    final seismicIntensities = <JmaSeismicIntensity>[];
    final seismicIntensityCodes = <int>[];
    final prefectures = <String>[];
    final prefectureCodes = <int>[];

    var slider = 59;
    for (var entry = 0; entry < 3; entry++) {
      final intensityCode = QzssDcrDecoder.extractField(message, slider, 3);
      if (intensityCode == 0) {
        break;
      }

      final intensity = JmaSeismicIntensity.values
          .where((e) => e.code == intensityCode)
          .firstOrNull;
      if (intensity == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Seismic Intensity: $intensityCode',
          sentence: sentence,
        );
      }
      seismicIntensities.add(intensity);
      seismicIntensityCodes.add(intensityCode);

      // Extract prefecture bitmap (47 bits)
      final prefectureNames = <String>[];
      final codes = <int>[];
      for (var i = 0; i < 47; i++) {
        if (QzssDcrDecoder.extractField(message, slider + 3 + i, 1) == 1) {
          final prefecture =
              JmaPrefecture.values.where((e) => e.code == i + 1).firstOrNull;
          if (prefecture != null) {
            prefectureNames.add(prefecture.name);
            codes.add(i + 1);
          }
        }
      }
      prefectures.add(prefectureNames.join('、'));
      prefectureCodes.addAll(codes);

      slider += 50;
    }

    return QzssDcReport.seismicIntensity(
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
      occurrenceTimeOfEarthquake: occurrenceTime,
      seismicIntensities: seismicIntensities.map((e) => e.name).toList(),
      seismicIntensitiesRaw: seismicIntensityCodes,
      prefectures: prefectures,
      prefecturesRaw: prefectureCodes,
    );
  }
}

