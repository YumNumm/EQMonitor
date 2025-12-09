import 'package:dart_azarashi/src/decoder/jma/jma_common_decoder.dart';
import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/prefecture.dart';
import 'package:dart_azarashi/src/definition/seismic_intensity.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Seismic Intensity Decoder.
class SeismicIntensityDecoder {
  const SeismicIntensityDecoder._();

  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract occurrence time of earthquake (bits 53-68, 16 bits)
    final occurrenceTime = JmaCommonDecoder.extractDayHourMin(params, 53);

    // Extract seismic intensities and prefectures
    // Each entry: 3 bits intensity + 6 bits prefecture = 9 bits
    // Maximum 16 entries
    final seismicIntensities = <JmaSeismicIntensity>[];
    final seismicIntensityCodes = <int>[];
    final prefectures = <String>[];
    final prefectureCodes = <int>[];

    for (var i = 0; i < 16; i++) {
      final offset = 69 + i * 9;
      final intensityCode = QzssDcrDecoder.extractField(message, offset, 3);
      final prefectureCode = QzssDcrDecoder.extractField(
        message,
        offset + 3,
        6,
      );

      if (intensityCode == 0 && prefectureCode == 0) {
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

      final prefecture = JmaPrefecture.values
          .where((e) => e.code == prefectureCode)
          .firstOrNull;
      if (prefecture == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Prefecture: $prefectureCode',
          sentence: sentence,
        );
      }
      prefectures.add(prefecture.name);
      prefectureCodes.add(prefectureCode);
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
