import 'dart:typed_data';

import '../../definition/disaster_category.dart';
import '../../definition/information_type.dart';
import '../../definition/report_classification.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'ash_fall_decoder.dart';
import 'earthquake_early_warning_decoder.dart';
import 'flood_decoder.dart';
import 'hypocenter_decoder.dart';
import 'marine_decoder.dart';
import 'nankai_trough_earthquake_decoder.dart';
import 'northwest_pacific_tsunami_decoder.dart';
import 'seismic_intensity_decoder.dart';
import 'tsunami_decoder.dart';
import 'typhoon_decoder.dart';
import 'volcano_decoder.dart';
import 'weather_decoder.dart';

/// JMA (Japan Meteorological Agency) Decoder.
///
/// Decodes JMA disaster prevention information messages.
class JmaDecoder {
  const JmaDecoder._();

  /// Decodes a JMA DCR message.
  static QzssDcReport decode({
    required String sentence,
    required Uint8List message,
    required String nmea,
    required String? messageHeader,
    required int? satelliteId,
    required int? satellitePrn,
    required Uint8List raw,
    required String preamble,
  }) {
    // Extract version (bits 214-219, 6 bits)
    final version = QzssDcrDecoder.extractField(message, 214, 6);
    if (version != 1) {
      throw QzssDcrDecoderException(
        'Unsupported JMA-DC Report Version: $version',
        sentence: sentence,
      );
    }

    // Extract report classification (bits 14-16, 3 bits)
    final rcCode = QzssDcrDecoder.extractField(message, 14, 3);
    final reportClassification = JmaReportClassification.values
        .where((e) => e.code == rcCode)
        .firstOrNull;
    if (reportClassification == null) {
      throw QzssDcrDecoderException(
        'Undefined Report Classification: $rcCode',
        sentence: sentence,
      );
    }

    // Extract disaster category (bits 17-20, 4 bits)
    final dcCode = QzssDcrDecoder.extractField(message, 17, 4);
    final disasterCategory = JmaDisasterCategory.values
        .where((e) => e.code == dcCode)
        .firstOrNull;
    if (disasterCategory == null) {
      throw QzssDcrDecoderException(
        'Undefined Disaster Category: $dcCode',
        sentence: sentence,
      );
    }

    // Extract report time
    final reportTime = _extractReportTime(message, sentence);

    // Extract information type (bits 41-42, 2 bits)
    final itCode = QzssDcrDecoder.extractField(message, 41, 2);
    final informationType = JmaInformationType.values
        .where((e) => e.code == itCode)
        .firstOrNull;
    if (informationType == null) {
      throw QzssDcrDecoderException(
        'Undefined Information Type: $itCode',
        sentence: sentence,
      );
    }

    // Create common parameters
    final commonParams = JmaCommonParams(
      sentence: sentence,
      message: message,
      nmea: nmea,
      messageHeader: messageHeader,
      satelliteId: satelliteId,
      satellitePrn: satellitePrn,
      raw: raw,
      preamble: preamble,
      version: version,
      reportClassification: reportClassification,
      disasterCategory: disasterCategory,
      reportTime: reportTime,
      informationType: informationType,
    );

    // Dispatch to specific decoder based on disaster category
    switch (disasterCategory) {
      case JmaDisasterCategory.earthquakeEarlyWarning:
        return EarthquakeEarlyWarningDecoder.decode(commonParams);
      case JmaDisasterCategory.hypocenter:
        return HypocenterDecoder.decode(commonParams);
      case JmaDisasterCategory.seismicIntensity:
        return SeismicIntensityDecoder.decode(commonParams);
      case JmaDisasterCategory.nankaiTroughEarthquake:
        return NankaiTroughEarthquakeDecoder.decode(commonParams);
      case JmaDisasterCategory.tsunami:
        return TsunamiDecoder.decode(commonParams);
      case JmaDisasterCategory.northwestPacificTsunami:
        return NorthwestPacificTsunamiDecoder.decode(commonParams);
      case JmaDisasterCategory.volcano:
        return VolcanoDecoder.decode(commonParams);
      case JmaDisasterCategory.ashFall:
        return AshFallDecoder.decode(commonParams);
      case JmaDisasterCategory.weather:
        return WeatherDecoder.decode(commonParams);
      case JmaDisasterCategory.flood:
        return FloodDecoder.decode(commonParams);
      case JmaDisasterCategory.typhoon:
        return TyphoonDecoder.decode(commonParams);
      case JmaDisasterCategory.marine:
        return MarineDecoder.decode(commonParams);
    }
  }

  static DateTime _extractReportTime(Uint8List message, String sentence) {
    final atMo = QzssDcrDecoder.extractField(message, 21, 4);
    if (atMo < 1 || atMo > 12) {
      throw QzssDcrDecoderException(
        'Invalid Report Time: $atMo as month',
        sentence: sentence,
      );
    }

    final atD = QzssDcrDecoder.extractField(message, 25, 5);
    if (atD < 1 || atD > 31) {
      throw QzssDcrDecoderException(
        'Invalid Report Time: $atD as day',
        sentence: sentence,
      );
    }

    final atH = QzssDcrDecoder.extractField(message, 30, 5);
    if (atH > 23) {
      throw QzssDcrDecoderException(
        'Invalid Report Time: $atH as hour',
        sentence: sentence,
      );
    }

    final atMi = QzssDcrDecoder.extractField(message, 35, 6);
    if (atMi > 59) {
      throw QzssDcrDecoderException(
        'Invalid Report Time: $atMi as minute',
        sentence: sentence,
      );
    }

    final now = DateTime.now().toUtc();
    var atY = now.year;

    // Adjust year based on month difference
    if (atMo - now.month > 6) {
      atY -= 1;
    } else if (now.month - atMo > 6) {
      atY += 1;
    }

    // Handle Feb 29
    if (atMo == 2 && atD == 29) {
      while (atY % 4 != 0 || (atY % 100 == 0 && atY % 400 != 0)) {
        atY += 1;
      }
    }

    return DateTime.utc(atY, atMo, atD, atH, atMi);
  }
}

/// Common parameters for JMA decoders.
class JmaCommonParams {
  const JmaCommonParams({
    required this.sentence,
    required this.message,
    required this.nmea,
    required this.messageHeader,
    required this.satelliteId,
    required this.satellitePrn,
    required this.raw,
    required this.preamble,
    required this.version,
    required this.reportClassification,
    required this.disasterCategory,
    required this.reportTime,
    required this.informationType,
  });

  final String sentence;
  final Uint8List message;
  final String nmea;
  final String? messageHeader;
  final int? satelliteId;
  final int? satellitePrn;
  final Uint8List raw;
  final String preamble;
  final int version;
  final JmaReportClassification reportClassification;
  final JmaDisasterCategory disasterCategory;
  final DateTime reportTime;
  final JmaInformationType informationType;
}
