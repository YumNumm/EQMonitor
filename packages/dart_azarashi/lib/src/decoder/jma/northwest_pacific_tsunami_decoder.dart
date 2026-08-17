import 'package:dart_azarashi/src/decoder/jma/jma_common_decoder.dart';
import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/coastal_region.dart';
import 'package:dart_azarashi/src/definition/northwest_pacific_tsunami_height.dart';
import 'package:dart_azarashi/src/definition/tsunamigenic_potential.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Northwest Pacific Tsunami Decoder.
///
/// Decodes JMA Northwest Pacific Tsunami information messages.
class NorthwestPacificTsunamiDecoder {
  const new _();

  /// Decodes a Northwest Pacific Tsunami message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract tsunamigenic potential (bits 53-55, 3 bits)
    final tpCode = QzssDcrDecoder.extractField(message, 53, 3);
    final tsunamigenicPotential = JmaTsunamigenicPotential.fromCode(tpCode);
    if (tsunamigenicPotential == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Tsunamigenic Potential: $tpCode',
        sentence: sentence,
      );
    }

    // Extract tsunami information items (up to 5 items)
    final expectedTsunamiArrivalTimes = <DateTime?>[];
    final tsunamiHeightsEn = <String>[];
    final tsunamiHeightsRaw = <int>[];
    final coastalRegionsEn = <String>[];
    final coastalRegionsRaw = <int>[];

    for (var i = 0; i < 5; i++) {
      final offset = 56 + i * 28;

      // Check if this item is empty (all bits are 0)
      if (QzssDcrDecoder.extractField(message, offset, 28) == 0) {
        break;
      }

      // Extract expected tsunami arrival time
      final arrivalTime = JmaCommonDecoder.extractExpectedTsunamiArrivalTime(
        message,
        offset,
        params.reportTime,
      );
      expectedTsunamiArrivalTimes.add(arrivalTime);

      // Extract tsunami height (bits offset+12, 9 bits)
      final thCode = QzssDcrDecoder.extractField(message, offset + 12, 9);
      final tsunamiHeight = JmaNorthwestPacificTsunamiHeight.fromCode(thCode);
      if (tsunamiHeight == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Northwest Pacific Tsunami Height: $thCode',
          sentence: sentence,
        );
      }
      tsunamiHeightsEn.add(tsunamiHeight.descriptionEn);
      tsunamiHeightsRaw.add(thCode);

      // Extract coastal region (bits offset+21, 7 bits)
      final plCode = QzssDcrDecoder.extractField(message, offset + 21, 7);
      final coastalRegion = JmaCoastalRegion.fromCode(plCode);
      if (coastalRegion == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Coastal Region: $plCode',
          sentence: sentence,
        );
      }
      coastalRegionsEn.add(coastalRegion.nameEn);
      coastalRegionsRaw.add(plCode);
    }

    return QzssDcReport.northwestPacificTsunami(
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
      tsunamigenicPotentialEn: tsunamigenicPotential.descriptionEn,
      tsunamigenicPotentialRaw: tpCode,
      expectedTsunamiArrivalTimes: expectedTsunamiArrivalTimes,
      tsunamiHeightsEn: tsunamiHeightsEn,
      tsunamiHeightsRaw: tsunamiHeightsRaw,
      coastalRegionsEn: coastalRegionsEn,
      coastalRegionsRaw: coastalRegionsRaw,
    );
  }
}
