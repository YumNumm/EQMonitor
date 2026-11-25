enum JmaEewTelegramKind(final String title, final String headType) {
  warning('緊急地震速報（警報）', 'VXSE43'),
  forecast('緊急地震速報（予報）', 'VXSE44'),
  seismicMotionForecast('緊急地震速報（地震動予報）', 'VXSE45');

  static JmaEewTelegramKind? fromTitle(String title) => switch (title) {
    '緊急地震速報（警報）' => warning,
    '緊急地震速報（予報）' => forecast,
    '緊急地震速報（地震動予報）' => seismicMotionForecast,
    _ => null,
  };
}

enum JmaTelegramStatus(final String label) {
  normal('通常'),
  training('訓練'),
  test('試験');

  static JmaTelegramStatus? fromLabel(String label) => switch (label) {
    '通常' => normal,
    '訓練' => training,
    '試験' => test,
    _ => null,
  };
}

enum JmaInfoType(final String label) {
  publication('発表'),
  correction('訂正'),
  delay('遅延'),
  cancellation('取消');

  static JmaInfoType? fromLabel(String label) => switch (label) {
    '発表' => publication,
    '訂正' => correction,
    '遅延' => delay,
    '取消' => cancellation,
    _ => null,
  };
}

enum JmaEewIntensity(final String code) {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),
  unknown('不明');

  static JmaEewIntensity? fromCode(String code) => switch (code) {
    '0' => zero,
    '1' => one,
    '2' => two,
    '3' => three,
    '4' => four,
    '5-' => fiveLower,
    '5+' => fiveUpper,
    '6-' => sixLower,
    '6+' => sixUpper,
    '7' => seven,
    '不明' => unknown,
    _ => null,
  };
}

enum JmaEewLgIntensity(final String code) {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  unknown('不明');

  static JmaEewLgIntensity? fromCode(String code) => switch (code) {
    '0' => zero,
    '1' => one,
    '2' => two,
    '3' => three,
    '4' => four,
    '不明' => unknown,
    _ => null,
  };
}

enum JmaEewWarningAreaLevel {
  region,
  prefecture,
  area;

  // 解説資料では半角括弧、実電文では全角括弧で書かれるため、括弧の中身で判定する。
  static JmaEewWarningAreaLevel? fromInformationType(String type) {
    if (type.contains('地方予報区')) {
      return region;
    }
    if (type.contains('府県予報区')) {
      return prefecture;
    }
    if (type.contains('細分区域')) {
      return area;
    }
    return null;
  }
}
