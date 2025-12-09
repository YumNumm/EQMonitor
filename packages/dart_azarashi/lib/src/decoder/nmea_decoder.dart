import 'package:dart_azarashi/src/decoder/qzss_dcr_decoder.dart';
import 'package:dart_azarashi/src/model/exception.dart';
import 'package:dart_azarashi/src/model/report/qzss_dc_report.dart';

/// NMEA message header for QZSS DCR messages.
const nmeaQzssDcrMessageHeader = r'$QZQSM';

/// Decoder for NMEA format messages ($QZQSM,55,...).
///
/// See IS-QZSS-DCR-015 Section 4.3.1 for format specification.
class NmeaDecoder {
  /// Creates a new [NmeaDecoder].
  const NmeaDecoder();

  /// Decodes a NMEA format message.
  ///
  /// The message should be in the format: $QZQSM,XX,<63 hex chars>*XX
  ///
  /// Throws [QzssDcrDecoderException] if decoding fails.
  QzssDcReport decode(String sentence) {
    final trimmed = sentence.split(RegExp(r'\s+'))[0];

    if (trimmed.length < 76) {
      throw QzssDcrDecoderException('Too Short Sentence', sentence: sentence);
    }
    if (trimmed.length > 76) {
      throw QzssDcrDecoderException('Too Long Sentence', sentence: sentence);
    }

    // Check checksum
    final parts = trimmed.split('*');
    if (parts.length != 2) {
      throw QzssDcrDecoderException('Checksum Not Found', sentence: sentence);
    }

    final payload = parts[0];
    final checksumStr = parts[1];

    if (checksumStr.length != 2) {
      throw QzssDcrDecoderException(
        'Invalid Checksum Length',
        sentence: sentence,
      );
    }

    final int checksum;
    try {
      checksum = int.parse(checksumStr, radix: 16);
    } on FormatException {
      throw QzssDcrDecoderException('Invalid Checksum', sentence: sentence);
    }

    var summed = 0;
    // XOR all characters after '$'
    for (var i = 1; i < payload.length; i++) {
      summed ^= payload.codeUnitAt(i);
    }

    if (summed != checksum) {
      throw QzssDcrDecoderException(
        'Checksum Mismatch, should be ${summed.toRadixString(16).padLeft(2, '0').toUpperCase()}',
        sentence: sentence,
      );
    }

    // Extract message header, satellite id, and message
    final payloadParts = payload.split(',');
    if (payloadParts.length != 3) {
      throw QzssDcrDecoderException('Invalid Sentence', sentence: sentence);
    }

    final messageHeader = payloadParts[0];
    final satelliteIdStr = payloadParts[1];
    final messageStr = payloadParts[2];

    // Check message header
    if (messageHeader != nmeaQzssDcrMessageHeader) {
      throw QzssDcrDecoderException(
        'Unknown Message Header: $messageHeader',
        sentence: sentence,
      );
    }

    // Check satellite id
    if (satelliteIdStr.length != 2) {
      throw QzssDcrDecoderException(
        'Invalid Satellite ID: $satelliteIdStr',
        sentence: sentence,
      );
    }

    final satelliteId = int.parse(satelliteIdStr);
    final satellitePrn = satelliteId | 0x80;

    // Convert hex message to bytes (pad with '0' to make 64 chars = 32 bytes)
    final List<int> message;
    try {
      message = _hexToBytes('${messageStr}0');
    } on FormatException {
      throw QzssDcrDecoderException('Invalid Message', sentence: sentence);
    }

    // Generate NMEA sentence
    final nmea = _messageToNmea(message, satelliteId: satelliteId);

    return QzssDcrDecoder.decode(
      sentence: sentence,
      message: message,
      nmea: nmea,
      messageHeader: messageHeader,
      satelliteId: satelliteId,
      satellitePrn: satellitePrn,
    );
  }

  String _messageToNmea(List<int> message, {int? satelliteId}) {
    final satId = satelliteId ?? 55;
    final messageHex = message
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join();
    // Remove the last character (padding)
    final messageHexTrimmed = messageHex.substring(0, messageHex.length - 1);

    final nmeaPartial = '\$QZQSM,$satId,$messageHexTrimmed';

    var checksum = 0;
    // XOR all characters after '$'
    for (var i = 1; i < nmeaPartial.length; i++) {
      checksum ^= nmeaPartial.codeUnitAt(i);
    }

    return '$nmeaPartial*${checksum.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }

  List<int> _hexToBytes(String hex) {
    final result = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return result;
  }
}
