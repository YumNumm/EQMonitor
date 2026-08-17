import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';

enum EarthquakeActivityIntensityCategory {
  zero,
  one,
  two,
  three,
  four,
  fiveUnknown,
  fiveLower,
  fiveUpper,
  sixUnknown,
  sixLower,
  sixUpper,
  seven,
  noInformation;

  factory fromIntensity(
    JmaIntensity? intensity,
  ) => switch (intensity) {
    JmaIntensity.zero => .zero,
    JmaIntensity.one => .one,
    JmaIntensity.two => .two,
    JmaIntensity.three => .three,
    JmaIntensity.four => .four,
    JmaIntensity.fiveUnknown => .fiveUnknown,
    JmaIntensity.fiveLower => .fiveLower,
    JmaIntensity.fiveUpper => .fiveUpper,
    JmaIntensity.sixUnknown => .sixUnknown,
    JmaIntensity.sixLower => .sixLower,
    JmaIntensity.sixUpper => .sixUpper,
    JmaIntensity.seven => .seven,
    JmaIntensity.unknown || null => .noInformation,
  };

  String get label => switch (this) {
    .zero => '震度0',
    .one => '震度1',
    .two => '震度2',
    .three => '震度3',
    .four => '震度4',
    .fiveUnknown => '震度5（強弱不明）',
    .fiveLower => '震度5弱',
    .fiveUpper => '震度5強',
    .sixUnknown => '震度6（強弱不明）',
    .sixLower => '震度6弱',
    .sixUpper => '震度6強',
    .seven => '震度7',
    .noInformation => '震度情報なし',
  };
}
