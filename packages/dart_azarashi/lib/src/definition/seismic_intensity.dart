/// JMA Seismic Intensity Lower Limit definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-8.
enum JmaSeismicIntensityLowerLimit {
  intensity0(1, '震度0'),
  intensity1(2, '震度1'),
  intensity2(3, '震度2'),
  intensity3(4, '震度3'),
  intensity4(5, '震度4'),
  intensity5Lower(6, '震度5弱'),
  intensity5Upper(7, '震度5強'),
  intensity6Lower(8, '震度6弱'),
  intensity6Upper(9, '震度6強'),
  intensity7(10, '震度7'),
  none(14, 'なし'),
  unknown(15, '不明');

  new(this.code, this.name);

  final int code;
  final String name;

  static JmaSeismicIntensityLowerLimit fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}

/// JMA Seismic Intensity Upper Limit definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-9.
enum JmaSeismicIntensityUpperLimit {
  intensity0(1, '震度0'),
  intensity1(2, '震度1'),
  intensity2(3, '震度2'),
  intensity3(4, '震度3'),
  intensity4(5, '震度4'),
  intensity5Lower(6, '震度5弱'),
  intensity5Upper(7, '震度5強'),
  intensity6Lower(8, '震度6弱'),
  intensity6Upper(9, '震度6強'),
  intensity7(10, '震度7'),
  orAbove(11, '〜程度以上'),
  none(14, 'なし'),
  unknown(15, '不明');

  new(this.code, this.name);

  final int code;
  final String name;

  static JmaSeismicIntensityUpperLimit fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}

/// JMA Long Period Ground Motion Lower Limit definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-10.
enum JmaLongPeriodGroundMotionLowerLimit {
  none(0, null),
  class0(1, '長周期地震動階級1未満'),
  class1(2, '長周期地震動階級1'),
  class2(3, '長周期地震動階級2'),
  class3(4, '長周期地震動階級3'),
  class4(5, '長周期地震動階級4'),
  unknown(7, '不明');

  new(this.code, this.name);

  final int code;
  final String? name;

  static JmaLongPeriodGroundMotionLowerLimit fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}

/// JMA Long Period Ground Motion Upper Limit definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-11.
enum JmaLongPeriodGroundMotionUpperLimit {
  none(0, null),
  class0(1, '長周期地震動階級1未満'),
  class1(2, '長周期地震動階級1'),
  class2(3, '長周期地震動階級2'),
  class3(4, '長周期地震動階級3'),
  class4(5, '長周期地震動階級4'),
  orAbove(6, '〜程度以上'),
  unknown(7, '不明');

  new(this.code, this.name);

  final int code;
  final String? name;

  static JmaLongPeriodGroundMotionUpperLimit fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}

/// JMA Seismic Intensity (for Seismic Intensity Report) definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-16.
enum JmaSeismicIntensity {
  below4(1, '4未満'),
  intensity4(2, '4'),
  intensity5Lower(3, '5弱'),
  intensity5Upper(4, '5強'),
  intensity6Lower(5, '6弱'),
  intensity6Upper(6, '6強'),
  intensity7(7, '7');

  new(this.code, this.name);

  final int code;
  final String name;

  static JmaSeismicIntensity fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
