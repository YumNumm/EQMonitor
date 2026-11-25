import 'package:jma_eew_xml/src/model/jma_eew_earthquake.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';
import 'package:jma_eew_xml/src/model/jma_eew_intensity_forecast.dart';
import 'package:jma_eew_xml/src/model/jma_eew_warning.dart';

final class const JmaEewTelegram({
  required final JmaEewTelegramKind kind,
  required final JmaTelegramStatus status,
  required final String editorialOffice,
  required final DateTime dateTime,
  required final DateTime reportDateTime,
  required final DateTime? targetDateTime,
  required final String eventId,
  required final JmaInfoType infoType,
  required final int serial,
  required final String? headlineText,
  required final List<JmaEewWarningItem> warningItems,
  required final JmaEewEarthquake? earthquake,
  required final JmaEewIntensityForecast? intensityForecast,
  required final String? text,
  required final JmaEewWarningComment? warningComment,
  required final String? nextAdvisory,
}) {
  bool get isCanceled => infoType == JmaInfoType.cancellation;

  bool get isLastInfo => nextAdvisory != null;

  bool get hasWarning =>
      !isCanceled &&
      (kind == JmaEewTelegramKind.warning ||
          warningItems.isNotEmpty ||
          (warningComment?.codes.contains(
                JmaEewWarningComment.strongShakingCode,
              ) ??
              false) ||
          (intensityForecast?.areas.any((area) => area.isWarning) ?? false));
}
