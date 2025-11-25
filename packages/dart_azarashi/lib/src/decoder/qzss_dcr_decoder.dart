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

    // Extract preamble (8 bits)
    final preambleCode = extractField(messageBytes, 0, 8);
    final preambleEnum = QzssDcrPreamble.values
        .where((e) => e.code == preambleCode)
        .firstOrNull;

    if (preambleEnum == null) {
      throw QzssDcrDecoderException(
        'Unknown Preamble: $preambleCode',
        sentence: sentence,
      );
    }
    final preamble = preambleEnum.symbol;

    // Check CRC
    if (!_verifyCrc(messageBytes, sentence)) {
      throw QzssDcrDecoderException(
        'CRC Mismatch',
        sentence: sentence,
      );
    }

    // Extract message type (bits 8-13, 6 bits)
    final messageTypeCode = extractField(messageBytes, 8, 6);

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
    // Extract CAMF fields
    // a1: bits 24-25 (2 bits)
    final a1 = extractField(message, 24, 2);
    // a2: bits 26-34 (9 bits) - country code
    final a2 = extractField(message, 26, 9);
    // a3: bits 35-39 (5 bits) - provider identifier
    final a3 = extractField(message, 35, 5);
    // vn: bits 214-219 (6 bits)
    final vn = extractField(message, 214, 6);

    // Determine DCX message type based on CAMF fields
    // Check if it's a null message (all fields zero)
    final a4 = extractField(message, 40, 7);
    final a5 = extractField(message, 47, 2);
    final a6 = extractField(message, 49, 1);
    final a7 = extractField(message, 50, 14);
    final a8 = extractField(message, 64, 2);
    final a9 = extractField(message, 66, 1);
    final a10 = extractField(message, 67, 3);
    final a11 = extractField(message, 70, 10);

    String dcxMessageType;
    if (a1 == 0 &&
        a3 == 0 &&
        a4 == 0 &&
        a5 == 0 &&
        a6 == 0 &&
        a7 == 0 &&
        a8 == 0 &&
        a9 == 0 &&
        a10 == 0 &&
        a11 == 0 &&
        vn == 0) {
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

    // Check if it's outside Japan
    if (a2 != 111) {
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
      case 1: // FMMC
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
      case 2: // FDMA
      case 3: // Related ministries
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
      case 4: // Information from local government
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

  /// Verifies the CRC of the message.
  ///
  /// Returns true if CRC is valid, false otherwise.
  static bool _verifyCrc(Uint8List message, String sentence) {
    var crc = 0;
    var crcRemainingLen = 226;

    // Create data: first 28 bytes + byte 29 with last 6 bits cleared
    final data = <int>[...message.sublist(0, 28), message[28] & 0xC0];

    for (final byte in data) {
      crc ^= (byte << 16);
      for (var i = 0; i < 8; i++) {
        crc <<= 1;
        if ((crc & 0x1000000) != 0) {
          crc ^= 0x1864cfb; // CRC-24Q polynomial
        }
        crcRemainingLen -= 1;
        if (crcRemainingLen == 0) {
          break;
        }
      }
    }
    crc &= 0xffffff;

    // Extract CRC from message (bits 226-249, 24 bits)
    final messageCrc = extractField(message, 226, 24);

    return crc == messageCrc;
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
