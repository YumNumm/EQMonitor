import 'dart:typed_data';

import '../../definition/epicenter_and_hypocenter.dart';
import '../../definition/notification_on_disaster_prevention.dart';
import '../../model/exception.dart';
import '../../model/report/qzss_dc_report.dart';
import '../qzss_dcr_decoder.dart';
import 'jma_decoder.dart';

/// Common decoder utilities for JMA messages.
class JmaCommonDecoder {
  const JmaCommonDecoder._();

  /// Extracts day, hour, minute field and returns DateTime.
  static DateTime extractDayHourMin(JmaCommonParams params, int slider) {
    final message = params.message;
    final sentence = params.sentence;
    final reportTime = params.reportTime;

    final dtD = QzssDcrDecoder.extractField(message, slider, 5);
    if (dtD < 1 || dtD > 31) {
      throw QzssDcrDecoderException(
        'Invalid Time: $dtD as day',
        sentence: sentence,
      );
    }

    final dtH = QzssDcrDecoder.extractField(message, slider + 5, 5);
    if (dtH > 23) {
      throw QzssDcrDecoderException(
        'Invalid Time: $dtH as hour',
        sentence: sentence,
      );
    }

    final dtMi = QzssDcrDecoder.extractField(message, slider + 10, 6);
    if (dtMi > 59) {
      throw QzssDcrDecoderException(
        'Invalid Time: $dtMi as minute',
        sentence: sentence,
      );
    }

    var dtY = reportTime.year;
    var dtMo = reportTime.month;

    // Adjust month based on day difference
    if (dtD - reportTime.day > 15) {
      if (dtMo == 1) {
        dtMo = 12;
        dtY -= 1;
      } else {
        dtMo -= 1;
      }
    } else if (reportTime.day - dtD > 15) {
      if (dtMo == 12) {
        dtMo = 1;
        dtY += 1;
      } else {
        dtMo += 1;
      }
    }

    // Handle Feb 29
    if (dtMo == 2 && dtD == 29) {
      while (dtY % 4 != 0 || (dtY % 100 == 0 && dtY % 400 != 0)) {
        dtY += 1;
      }
    }

    return DateTime.utc(dtY, dtMo, dtD, dtH, dtMi);
  }

  /// Extracts notification on disaster prevention fields.
  static (List<JmaNotificationOnDisasterPrevention>, List<int>)
  extractNotificationOnDisasterPrevention(Uint8List message, int slider) {
    final notifications = <JmaNotificationOnDisasterPrevention>[];
    final codes = <int>[];

    for (var i = 0; i < 3; i++) {
      final code = QzssDcrDecoder.extractField(message, slider + i * 9, 9);
      if (code == 0) {
        break;
      }
      final notification = JmaNotificationOnDisasterPrevention.values
          .where((e) => e.code == code)
          .firstOrNull;
      if (notification != null) {
        notifications.add(notification);
        codes.add(code);
      }
    }

    return (notifications, codes);
  }

  /// Extracts depth field.
  static (String, int) extractDepth(Uint8List message, int slider) {
    final de = QzssDcrDecoder.extractField(message, slider, 9);
    if (de == 501) {
      return ('500kmより深い', de);
    } else if (de == 511) {
      return ('不明', de);
    } else if (de > 501 && de < 511) {
      return ('不明', de);
    } else {
      return ('${de}km', de);
    }
  }

  /// Extracts magnitude field.
  static (String, int) extractMagnitude(Uint8List message, int slider) {
    final ma = QzssDcrDecoder.extractField(message, slider, 7);
    if (ma == 101) {
      return ('10.0より大きい', ma);
    } else if (ma == 126) {
      return ('不明(8.0より大きい)', ma);
    } else if (ma == 127) {
      return ('不明', ma);
    } else {
      return ('${ma / 10}', ma);
    }
  }

  /// Extracts seismic epicenter field.
  static (JmaEpicenterAndHypocenter, int) extractSeismicEpicenter(
    Uint8List message,
    int slider,
    String sentence,
  ) {
    final ep = QzssDcrDecoder.extractField(message, slider, 10);
    final epicenter = JmaEpicenterAndHypocenter.values
        .where((e) => e.code == ep)
        .firstOrNull;
    if (epicenter == null) {
      throw QzssDcrDecoderException(
        'Undefined JMA Seismic Epicenter: $ep',
        sentence: sentence,
      );
    }
    return (epicenter, ep);
  }

  /// Extracts latitude and longitude coordinates.
  static HypocenterCoordinates extractLatLon(
    Uint8List message,
    int slider,
    String sentence,
  ) {
    final latNs = QzssDcrDecoder.extractField(message, slider, 1);
    final latD = QzssDcrDecoder.extractField(message, slider + 1, 7);
    if (latD > 89) {
      throw QzssDcrDecoderException(
        'Invalid Latitude: $latD as degree',
        sentence: sentence,
      );
    }
    final latM = QzssDcrDecoder.extractField(message, slider + 8, 6);
    if (latM > 59) {
      throw QzssDcrDecoderException(
        'Invalid Latitude: $latM as minute',
        sentence: sentence,
      );
    }
    final latS = QzssDcrDecoder.extractField(message, slider + 14, 6);
    if (latS > 59) {
      throw QzssDcrDecoderException(
        'Invalid Latitude: $latS as second',
        sentence: sentence,
      );
    }

    final lonEw = QzssDcrDecoder.extractField(message, slider + 20, 1);
    final lonD = QzssDcrDecoder.extractField(message, slider + 21, 8);
    if (lonD > 179) {
      throw QzssDcrDecoderException(
        'Invalid Longitude: $lonD as degree',
        sentence: sentence,
      );
    }
    final lonM = QzssDcrDecoder.extractField(message, slider + 29, 6);
    if (lonM > 59) {
      throw QzssDcrDecoderException(
        'Invalid Longitude: $lonM as minute',
        sentence: sentence,
      );
    }
    final lonS = QzssDcrDecoder.extractField(message, slider + 35, 6);
    if (lonS > 59) {
      throw QzssDcrDecoderException(
        'Invalid Longitude: $lonS as second',
        sentence: sentence,
      );
    }

    return HypocenterCoordinates(
      latNs: latNs,
      latD: latD,
      latM: latM,
      latS: latS,
      lonEw: lonEw,
      lonD: lonD,
      lonM: lonM,
      lonS: lonS,
    );
  }

  /// Extracts expected tsunami arrival time.
  static DateTime? extractExpectedTsunamiArrivalTime(
    Uint8List message,
    int slider,
    DateTime reportTime,
  ) {
    final taH = QzssDcrDecoder.extractField(message, slider + 1, 5);
    if (taH == 31) {
      return null;
    }

    final taM = QzssDcrDecoder.extractField(message, slider + 6, 6);
    if (taM == 63) {
      return null;
    }

    final dayOffset = QzssDcrDecoder.extractField(message, slider, 1);
    final taDate = reportTime.add(Duration(days: dayOffset));

    return DateTime.utc(taDate.year, taDate.month, taDate.day, taH, taM);
  }
}
