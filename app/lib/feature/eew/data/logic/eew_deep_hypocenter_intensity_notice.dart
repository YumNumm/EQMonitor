import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eewDeepHypocenterIntensityNoticeProvider = Provider(
  (ref) => const EewDeepHypocenterIntensityNotice(),
);

class EewDeepHypocenterIntensityNotice {
  const new();

  bool shouldShow({required EewTelegramItem eew}) {
    if (eew.isCanceled || eew.shouldHideMagnitudeAndDepth) {
      return false;
    }
    final depth = eew.hypocenter?.depth;
    if (depth == null || depth < 150) {
      return false;
    }
    final maxIntensity = eew.forecastIntensity?.maxIntensity;
    return maxIntensity == null || maxIntensity == .unknown;
  }
}
