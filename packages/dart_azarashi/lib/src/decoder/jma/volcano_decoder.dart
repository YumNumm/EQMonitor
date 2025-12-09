import 'package:dart_azarashi/src/decoder/jma/jma_common_decoder.dart';
import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/local_government.dart';
import 'package:dart_azarashi/src/definition/volcanic_warning_code.dart';
import 'package:dart_azarashi/src/definition/volcano_name.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Volcano Decoder.
///
/// Decodes JMA Volcano information messages.
class VolcanoDecoder {
  const VolcanoDecoder._();

  /// Decodes a Volcano message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract ambiguity of activity time (bits 50-52, 3 bits)
    final ambiguityOfActivityTimeNo = QzssDcrDecoder.extractField(
      message,
      50,
      3,
    );

    // Extract activity time (bits 53-68, 16 bits: day 5 + hour 5 + minute 6)
    final activityTime = JmaCommonDecoder.extractDayHourMin(params, 53);

    // Extract volcanic warning code (bits 69-75, 7 bits)
    final dwCode = QzssDcrDecoder.extractField(message, 69, 7);
    final volcanicWarningCode = JmaVolcanicWarningCode.fromCode(dwCode);
    if (volcanicWarningCode == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Volcanic Warning Code: $dwCode',
        sentence: sentence,
      );
    }

    // Extract volcano name (bits 76-87, 12 bits)
    final voCode = QzssDcrDecoder.extractField(message, 76, 12);
    final volcanoName = JmaVolcanoName.fromCode(voCode);
    if (volcanoName == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Volcano Name: $voCode',
        sentence: sentence,
      );
    }

    // Extract local governments (up to 5 items)
    final localGovernments = <String>[];
    final localGovernmentsRaw = <int>[];

    for (var i = 0; i < 5; i++) {
      final offset = 88 + i * 23;

      // Check if this item is empty (all bits are 0)
      if (QzssDcrDecoder.extractField(message, offset, 23) == 0) {
        break;
      }

      final lgCode = QzssDcrDecoder.extractField(message, offset, 23);
      final localGovernment =
          JmaLocalGovernment.fromCode(lgCode) ??
          JmaLocalGovernment.undefinedDescription(lgCode);
      localGovernments.add(localGovernment);
      localGovernmentsRaw.add(lgCode);
    }

    return QzssDcReport.volcano(
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
      ambiguityOfActivityTimeNo: ambiguityOfActivityTimeNo,
      activityTime: activityTime,
      volcanicWarningCode: volcanicWarningCode.nameJa,
      volcanicWarningCodeRaw: dwCode,
      volcanoName: volcanoName,
      volcanoNameRaw: voCode,
      localGovernments: localGovernments,
      localGovernmentsRaw: localGovernmentsRaw,
    );
  }
}
