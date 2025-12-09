import 'package:dart_azarashi/src/decoder/jma/jma_common_decoder.dart';
import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/ash_fall_warning_code.dart';
import 'package:dart_azarashi/src/definition/local_government.dart';
import 'package:dart_azarashi/src/definition/volcano_name.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Ash Fall Decoder.
///
/// Decodes JMA Ash Fall information messages.
class AshFallDecoder {
  const AshFallDecoder._();

  /// Decodes an Ash Fall message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract activity time (bits 53-68, 16 bits: day 5 + hour 5 + minute 6)
    final activityTime = JmaCommonDecoder.extractDayHourMin(params, 53);

    // Extract ash fall warning type (bits 69-70, 2 bits)
    final dw1Code = QzssDcrDecoder.extractField(message, 69, 2);
    String ashFallWarningType;
    if (dw1Code == 1) {
      ashFallWarningType = '速報';
    } else if (dw1Code == 2) {
      ashFallWarningType = '詳細';
    } else {
      throw QzssDcrDecoderException(
        'Undefined JMA Ash Fall Warning Type: $dw1Code',
        sentence: sentence,
      );
    }

    // Extract volcano name (bits 71-82, 12 bits)
    final voCode = QzssDcrDecoder.extractField(message, 71, 12);
    final volcanoName = JmaVolcanoName.fromCode(voCode);
    if (volcanoName == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Volcano Name: $voCode',
        sentence: sentence,
      );
    }

    // Extract ash fall information items (up to 4 items)
    final expectedAshFallTimes = <int>[];
    final ashFallWarningCodes = <String>[];
    final ashFallWarningCodesRaw = <int>[];
    final localGovernments = <String>[];
    final localGovernmentsRaw = <int>[];

    for (var i = 0; i < 4; i++) {
      final offset = 83 + i * 29;

      // Check if this item is empty (all bits are 0)
      if (QzssDcrDecoder.extractField(message, offset, 29) == 0) {
        break;
      }

      // Extract expected ash fall time (bits offset, 3 bits)
      final hoCode = QzssDcrDecoder.extractField(message, offset, 3);
      if (hoCode < 1 || hoCode > 6) {
        throw QzssDcrDecoderException(
          'Invalid JMA Expected Ash Fall Time: $hoCode',
          sentence: sentence,
        );
      }
      expectedAshFallTimes.add(hoCode);

      // Extract ash fall warning code (bits offset+3, 3 bits)
      final dw2Code = QzssDcrDecoder.extractField(message, offset + 3, 3);
      final warningCode = JmaAshFallWarningCode.fromCode(dw2Code);
      if (warningCode == null) {
        throw QzssDcrDecoderException(
          'Undefined JMA Ash Fall Warning Code: $dw2Code',
          sentence: sentence,
        );
      }
      ashFallWarningCodes.add(warningCode.nameJa);
      ashFallWarningCodesRaw.add(dw2Code);

      // Extract local government (bits offset+6, 23 bits)
      final lgCode = QzssDcrDecoder.extractField(message, offset + 6, 23);
      final localGovernment =
          JmaLocalGovernment.fromCode(lgCode) ??
          JmaLocalGovernment.undefinedDescription(lgCode);
      localGovernments.add(localGovernment);
      localGovernmentsRaw.add(lgCode);
    }

    return QzssDcReport.ashFall(
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
      activityTime: activityTime,
      ashFallWarningType: ashFallWarningType,
      ashFallWarningTypeRaw: dw1Code,
      volcanoName: volcanoName,
      volcanoNameRaw: voCode,
      expectedAshFallTimes: expectedAshFallTimes,
      ashFallWarningCodes: ashFallWarningCodes,
      ashFallWarningCodesRaw: ashFallWarningCodesRaw,
      localGovernments: localGovernments,
      localGovernmentsRaw: localGovernmentsRaw,
    );
  }
}
