import 'dart:typed_data';

import '../definition/preamble.dart';
import '../model/exception.dart';
import '../model/report/qzss_dc_report.dart';
import 'jma/jma_decoder.dart';

/// Main decoder for QZSS DCR messages.
///
/// This class determines the message type (DCR/DCX) based on the preamble
/// and delegates to the appropriate decoder.
class QzssDcrDecoder {
  const QzssDcrDecoder._();

  /// Decodes a QZSS DCR message.
  static QzssDcReport decode({
    required String sentence,
    required List<int> message,
    required String nmea,
    required String? messageHeader,
    required int? satelliteId,
    required int? satellitePrn,
  }) {
    final messageBytes = Uint8List.fromList(message);

    // Extract preamble (first 6 bits)
    final preambleCode = extractField(messageBytes, 0, 6);
    final preamble = qzssDcrPreamble[preambleCode];

    if (preamble == null) {
      throw QzssDcrDecoderException(
        'Unknown Preamble: $preambleCode',
        sentence: sentence,
      );
    }

    // Extract message type (bits 6-12)
    final messageTypeCode = extractField(messageBytes, 6, 6);

    // Generate raw bytes
    final Uint8List raw;
    if (messageTypeCode == 44) {
      // DCX: starts from camf, discards pab, mt and sd fields.
      raw = Uint8List.fromList([
        ...messageBytes.sublist(3, 27),
        messageBytes[27] & 0xF0,
      ]);
    } else {
      raw = Uint8List.fromList([
        ...messageBytes.sublist(1, 27),
        messageBytes[27] & 0xF0,
      ]);
    }

    // Determine message type
    if (messageTypeCode == 43) {
      // DCR - JMA Disaster Prevention Information
      return JmaDecoder.decode(
        sentence: sentence,
        message: messageBytes,
        nmea: nmea,
        messageHeader: messageHeader,
        satelliteId: satelliteId,
        satellitePrn: satellitePrn,
        raw: raw,
        preamble: preamble,
      );
    } else if (messageTypeCode == 44) {
      // DCX - DC Extended Message
      return _decodeDcx(
        sentence: sentence,
        message: messageBytes,
        nmea: nmea,
        messageHeader: messageHeader,
        satelliteId: satelliteId,
        satellitePrn: satellitePrn,
        raw: raw,
        preamble: preamble,
      );
    } else {
      throw QzssDcrDecoderException(
        'Unknown Message Type: $messageTypeCode',
        sentence: sentence,
      );
    }
  }

  static QzssDcReport _decodeDcx({
    required String sentence,
    required Uint8List message,
    required String nmea,
    required String? messageHeader,
    required int? satelliteId,
    required int? satellitePrn,
    required Uint8List raw,
    required String preamble,
  }) {
    // Extract provider identifier (A3)
    final a3 = extractField(message, 30, 5);

    // Determine DCX message type based on provider
    String dcxMessageType;
    if (a3 == 0) {
      dcxMessageType = 'Null Message';
      return QzssDcReport.dcxNull(
        sentence: sentence,
        message: message,
        nmea: nmea,
        messageHeader: messageHeader,
        satelliteId: satelliteId,
        satellitePrn: satellitePrn,
        raw: raw,
        preamble: preamble,
        messageType: 'DCX',
        dcxMessageType: dcxMessageType,
      );
    }

    // Check A2 (country code)
    final a2 = extractField(message, 21, 9);
    if (a2 != 111) {
      // Not Japan
      dcxMessageType = 'Information from Organizations outside Japan';
      return QzssDcReport.dcxOutsideJapan(
        sentence: sentence,
        message: message,
        nmea: nmea,
        messageHeader: messageHeader,
        satelliteId: satelliteId,
        satellitePrn: satellitePrn,
        raw: raw,
        preamble: preamble,
        messageType: 'DCX',
        dcxMessageType: dcxMessageType,
      );
    }

    // Japan providers
    switch (a3) {
      case 1:
        dcxMessageType = 'L-Alert';
        return QzssDcReport.dcxLAlert(
          sentence: sentence,
          message: message,
          nmea: nmea,
          messageHeader: messageHeader,
          satelliteId: satelliteId,
          satellitePrn: satellitePrn,
          raw: raw,
          preamble: preamble,
          messageType: 'DCX',
          dcxMessageType: dcxMessageType,
        );
      case 2:
        dcxMessageType = 'J-Alert';
        return QzssDcReport.dcxJAlert(
          sentence: sentence,
          message: message,
          nmea: nmea,
          messageHeader: messageHeader,
          satelliteId: satelliteId,
          satellitePrn: satellitePrn,
          raw: raw,
          preamble: preamble,
          messageType: 'DCX',
          dcxMessageType: dcxMessageType,
        );
      case 3:
        dcxMessageType = 'Municipality-Transmitted Information';
        return QzssDcReport.dcxMTInfo(
          sentence: sentence,
          message: message,
          nmea: nmea,
          messageHeader: messageHeader,
          satelliteId: satelliteId,
          satellitePrn: satellitePrn,
          raw: raw,
          preamble: preamble,
          messageType: 'DCX',
          dcxMessageType: dcxMessageType,
        );
      default:
        dcxMessageType = 'Unknown';
        return QzssDcReport.dcxUnknown(
          sentence: sentence,
          message: message,
          nmea: nmea,
          messageHeader: messageHeader,
          satelliteId: satelliteId,
          satellitePrn: satellitePrn,
          raw: raw,
          preamble: preamble,
          messageType: 'DCX',
          dcxMessageType: dcxMessageType,
        );
    }
  }

  /// Extracts a field from message bytes.
  ///
  /// [message] - The message bytes
  /// [slider] - The starting bit position
  /// [size] - The number of bits to extract
  static int extractField(Uint8List message, int slider, int size) {
    // Calculate byte range
    final startByte = slider >> 3;
    final endByte = (slider + size) >> 3;

    // Extract relevant bytes
    final field = List<int>.from(message.sublist(startByte, endByte + 1));

    // Mask the first byte to clear bits before the start position
    field[0] = field[0] & ((1 << (8 - (slider & 7))) - 1);

    // Convert to integer (big endian)
    var result = 0;
    for (final byte in field) {
      result = (result << 8) | byte;
    }

    // Shift right to remove bits after the end position
    result = result >> (8 - ((slider + size) & 7));

    return result;
  }
}
