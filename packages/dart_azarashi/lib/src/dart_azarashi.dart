import 'package:dart_azarashi/src/decoder/hex_decoder.dart';
import 'package:dart_azarashi/src/decoder/nmea_decoder.dart';
import 'package:dart_azarashi/src/decoder/ublox_decoder.dart';

/// Main entry point for the dart_azarashi library.
///
/// Provides access to various decoders for QZSS DCR messages.
class DartAzarashi {
  /// Creates a new instance of [DartAzarashi].
  const new();

  /// Decoder for NMEA format messages ($QZQSM,55,...).
  ///
  /// See IS-QZSS-DCR-015 Section 4.3.1 for format specification.
  NmeaDecoder get nmeaDecoder => const NmeaDecoder();

  /// Decoder for hexadecimal string format messages (63 characters).
  HexDecoder get hexDecoder => const HexDecoder();

  /// Decoder for u-blox binary format messages (SFRBX).
  UbloxDecoder get ubloxDecoder => const UbloxDecoder();
}
