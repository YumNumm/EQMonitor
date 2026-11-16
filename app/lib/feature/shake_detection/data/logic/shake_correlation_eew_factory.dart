import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_correlation_eew_factory.g.dart';

@riverpod
ShakeCorrelationEewFactory shakeCorrelationEewFactory(Ref ref) =>
    const ShakeCorrelationEewFactory();

class const ShakeCorrelationEewFactory() {
  /// 発生時刻・震源・マグニチュードが揃った EEW だけを結合判定の対象にする。
  List<CorrelationEew> create(List<EewTelegramItem> eews) => [
    for (final eew in eews)
      if ((
            eew.originTime,
            eew.hypocenter?.latitude,
            eew.hypocenter?.longitude,
            eew.hypocenter?.depth,
            eew.hypocenter?.magnitude,
          )
          case (
            final originTime?,
            final latitude?,
            final longitude?,
            final depth?,
            final magnitude?,
          ))
        CorrelationEew(
          eventId: eew.eventId,
          serialNo: eew.serialNo,
          originTime: originTime,
          reportTime: eew.reportTime,
          latitude: latitude,
          longitude: longitude,
          depth: depth.toDouble(),
          magnitude: magnitude,
          isCancel: eew.isCanceled,
        ),
  ];
}
