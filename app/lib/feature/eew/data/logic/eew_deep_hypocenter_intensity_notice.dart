import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_deep_hypocenter_intensity_notice.g.dart';

@Riverpod(keepAlive: true)
EewDeepHypocenterIntensityNotice eewDeepHypocenterIntensityNotice(Ref ref) =>
    const EewDeepHypocenterIntensityNotice();

class const EewDeepHypocenterIntensityNotice() {
  bool shouldShow({required EewTelegramItem eew}) {
    if (eew.isCanceled || eew.shouldHideMagnitudeAndDepth) {
      return false;
    }
    final depth = eew.hypocenter?.depth;
    if (depth == null || depth <= 150) {
      return false;
    }
    final maxIntensity = eew.forecastIntensity?.maxIntensity;
    return maxIntensity == null || maxIntensity == .unknown;
  }
}
