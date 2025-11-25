import 'dart:typed_data';

import '../model/exception.dart';
import '../model/report/qzss_dc_report.dart';
import 'qzss_dcr_decoder.dart';

/// u-blox message header bytes.
const ubloxHeader = [0xB5, 0x62];

/// u-blox message class for SFRBX.
const ubloxClass = 0x02;

/// u-blox message id for SFRBX.
const ubloxId = 0x13;

/// SVN to PRN mapping for QZSS satellites.
const ubloxSvnPrnMap = {1: 193, 2: 194, 3: 199, 4: 195, 5: 196};

/// Decoder for u-blox binary format messages (SFRBX).
class UbloxDecoder {
  /// Creates a new [UbloxDecoder].
  const UbloxDecoder();

  /// Decodes a u-blox binary format message.
  ///
  /// Throws [QzssDcrDecoderException] if decoding fails.
  QzssDcReport decode(Uint8List data) {
    // Minimum length check: header(2) + class(1) + id(1) + length(2) + payload(44) + checksum(2) = 52
    if (data.length < 52) {
      throw const QzssDcrDecoderException('Too Short Message');
    }

    // Check header
    if (data[0] != ubloxHeader[0] || data[1] != ubloxHeader[1]) {
      throw const QzssDcrDecoderException('Invalid Header');
    }

    // Check class and id
    if (data[2] != ubloxClass || data[3] != ubloxId) {
      throw const QzssDcrDecoderException('Invalid Class/ID');
    }

    // Get payload length (little endian)
    final payloadLength = data[4] | (data[5] << 8);
    if (payloadLength != 44) {
      throw QzssDcrDecoderException('Invalid Payload Length: $payloadLength');
    }

    // Verify checksum
    final expectedLength = 6 + payloadLength + 2;
    if (data.length < expectedLength) {
      throw const QzssDcrDecoderException('Message Too Short For Checksum');
    }

    var ckA = 0;
    var ckB = 0;
    for (var i = 2; i < 6 + payloadLength; i++) {
      ckA = (ckA + data[i]) & 0xFF;
      ckB = (ckB + ckA) & 0xFF;
    }

    if (ckA != data[6 + payloadLength] || ckB != data[6 + payloadLength + 1]) {
      throw const QzssDcrDecoderException('Checksum Mismatch');
    }

    // Extract payload
    final payload = data.sublist(6, 6 + payloadLength);

    // Check GNSS ID (should be 5 for QZSS)
    final gnssId = payload[0];
    if (gnssId != 5) {
      throw QzssDcrDecoderException('Not a QZSS message: GNSS ID = $gnssId');
    }

    // Get SVN ID and convert to PRN
    final svnId = payload[1];
    final prn = ubloxSvnPrnMap[svnId];
    if (prn == null) {
      throw QzssDcrDecoderException('Unknown SVN ID: $svnId');
    }

    // Check signal ID (should be 1 for L1S)
    final signalId = payload[3];
    if (signalId != 1) {
      throw QzssDcrDecoderException('Not L1S signal: Signal ID = $signalId');
    }

    // Extract 32-byte message from words (8 words x 4 bytes)
    final messageBytes = <int>[];
    for (var i = 0; i < 8; i++) {
      final wordOffset = 8 + i * 4;
      // u-blox stores words in little endian, but we need big endian
      messageBytes.add(payload[wordOffset + 3]);
      messageBytes.add(payload[wordOffset + 2]);
      messageBytes.add(payload[wordOffset + 1]);
      messageBytes.add(payload[wordOffset]);
    }

    final message = messageBytes;
    final satelliteId = prn & 0x3F;
    final satellitePrn = prn;

    // Generate NMEA sentence
    final nmea = _messageToNmea(message, satelliteId: satelliteId);

    return QzssDcrDecoder.decode(
      sentence: _bytesToHex(data),
      message: message,
      nmea: nmea,
      messageHeader: null,
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

  String _bytesToHex(Uint8List bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
