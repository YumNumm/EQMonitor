import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';

class EewWarningOverlayIntensityFormatter {
  const new();

  String format({required JmaIntensity intensity, required bool isOver}) {
    final value = switch (intensity) {
      JmaIntensity.unknown => '不明',
      JmaIntensity.zero => '0',
      JmaIntensity.one => '1',
      JmaIntensity.two => '2',
      JmaIntensity.three => '3',
      JmaIntensity.four => '4',
      JmaIntensity.fiveUnknown => '5弱以上',
      JmaIntensity.fiveLower => '5弱',
      JmaIntensity.fiveUpper => '5強',
      JmaIntensity.sixUnknown => '6弱以上',
      JmaIntensity.sixLower => '6弱',
      JmaIntensity.sixUpper => '6強',
      JmaIntensity.seven => '7',
    };
    if (!isOver || intensity == JmaIntensity.unknown || value.endsWith('以上')) {
      return value;
    }
    return '$value以上';
  }
}
