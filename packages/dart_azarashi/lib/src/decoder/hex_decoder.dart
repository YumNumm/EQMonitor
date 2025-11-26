import '../model/exception.dart';
import '../model/report/qzss_dc_report.dart';
import 'qzss_dcr_decoder.dart';

/// Decoder for hexadecimal string format messages (63 characters).
class HexDecoder {
  /// Creates a new [HexDecoder].
  const HexDecoder();

  /// Decodes a hexadecimal string message.
  ///
  /// The message should be 63 characters long.
  ///
  /// Throws [QzssDcrDecoderException] if decoding fails.
  QzssDcReport decode(String sentence) {
    final trimmed = sentence.trim();

    if (trimmed.length < 63) {
      throw QzssDcrDecoderException('Too Short Sentence', sentence: sentence);
    }
    if (trimmed.length > 63) {
      throw QzssDcrDecoderException('Too Long Sentence', sentence: sentence);
    }

    // Convert hex string to bytes (pad with '0' to make 64 chars = 32 bytes)
    final List<int> bytes;
    try {
      bytes = _hexToBytes('${trimmed}0');
    } on FormatException {
      throw QzssDcrDecoderException('Invalid Message', sentence: sentence);
    }

    final message = bytes;
    final nmea = _messageToNmea(message);

    return QzssDcrDecoder.decode(
      sentence: sentence,
      message: message,
      nmea: nmea,
      messageHeader: null,
      satelliteId: null,
      satellitePrn: null,
    );
  }

  String _messageToNmea(List<int> message, {int? satelliteId}) {
    final satId = satelliteId ?? 55;
    final messageHex =
        message
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
