import 'dart:typed_data';

import 'package:dart_azarashi/src/decoder/jma/jma_decoder.dart';
import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/definition/information_serial_code.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// Nankai Trough Earthquake Decoder.
///
/// Decodes JMA Nankai Trough Earthquake information messages.
class NankaiTroughEarthquakeDecoder {
  const new _();

  /// Decodes a Nankai Trough Earthquake message.
  static QzssDcReport decode(JmaCommonParams params) {
    final message = params.message;
    final sentence = params.sentence;

    // Extract information serial code (bits 53-56, 4 bits)
    final ieCode = QzssDcrDecoder.extractField(message, 53, 4);
    final informationSerialCode = JmaInformationSerialCode.fromCode(ieCode);
    final informationSerialCodeName =
        informationSerialCode?.name ??
        JmaInformationSerialCode.undefinedDescription(ieCode);

    // Extract text information (18 bytes, starting at bit 57)
    final textBytes = <int>[];
    for (var i = 0; i < 18; i++) {
      textBytes.add(QzssDcrDecoder.extractField(message, 57 + i * 8, 8));
    }
    final textInformation = Uint8List.fromList(textBytes);

    // Extract page number (bits 201-206, 6 bits)
    final pageNumber = QzssDcrDecoder.extractField(message, 201, 6);
    if (pageNumber < 1) {
      throw QzssDcrDecoderException(
        'Invalid Page Number: $pageNumber',
        sentence: sentence,
      );
    }

    // Extract total page (bits 207-212, 6 bits)
    final totalPage = QzssDcrDecoder.extractField(message, 207, 6);
    if (totalPage < 1 || pageNumber > totalPage) {
      throw QzssDcrDecoderException(
        'Invalid Total Page: $totalPage (page: $pageNumber)',
        sentence: sentence,
      );
    }

    return QzssDcReport.nankaiTroughEarthquake(
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
      informationSerialCode: informationSerialCodeName,
      informationSerialCodeRaw: ieCode,
      textInformation: textInformation,
      pageNumber: pageNumber,
      totalPage: totalPage,
    );
  }
}
