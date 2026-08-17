import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';

const JmaIntensity currentLocationEewMinIntensity = JmaIntensity.four;
const JmaIntensity currentLocationEarthquakeMinIntensity = JmaIntensity.one;

/// 最小の震度0。配信判定は `最小震度 <= イベント震度` のため常に条件を満たす。
const JmaIntensity allMinIntensity = JmaIntensity.zero;

extension NotificationMinIntensityLabel on JmaIntensity {
  String get minIntensityLabel => this == allMinIntensity ? 'すべて' : '震度$label';

  String get minIntensityThresholdLabel =>
      this == allMinIntensity ? 'すべて' : '震度$label以上';
}
