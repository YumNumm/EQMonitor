/// 津波警報コード表
/// （種別："警報等情報要素／津波警報・注意報・予報"）
enum TsunamiWarning {
  /// 津波なし
  none('00', '津波なし'),

  /// 警報解除（大津波警報または津波警報の解除）
  warningCancelled('50', '警報解除'),

  /// 津波警報
  warning('51', '津波警報'),

  /// 大津波警報
  majorWarning('52', '大津波警報'),

  /// 大津波警報：発表（大津波警報の新規発表または切替）
  majorWarningIssued('53', '大津波警報：発表'),

  /// 津波注意報解除
  advisoryCancelled('60', '津波注意報解除'),

  /// 津波注意報
  advisory('62', '津波注意報'),

  /// 津波予報（若干の海面変動）
  forecast('71', '津波予報（若干の海面変動）'),

  /// 津波予報（若干の海面変動）- 津波注意報解除、津波予報（若干の海面変動）への切替
  forecastFromAdvisory('72', '津波予報（若干の海面変動）'),

  /// 津波予報（若干の海面変動）- 大津波警報または津波警報の解除、津波予報（若干の海面変動）への切替
  forecastFromWarning('73', '津波予報（若干の海面変動）');

  const TsunamiWarning(this.code, this.displayName);

  /// コード
  final String code;

  /// 表示名
  final String displayName;

  /// コードから津波警報を取得
  static TsunamiWarning? fromCode(String code) {
    for (final warning in TsunamiWarning.values) {
      if (warning.code == code) {
        return warning;
      }
    }
    return null;
  }

  /// 警報レベルを取得（数値が高いほど重要度が高い）
  int get severityLevel {
    return switch (this) {
      TsunamiWarning.majorWarning || TsunamiWarning.majorWarningIssued => 4,
      TsunamiWarning.warning => 3,
      TsunamiWarning.advisory => 2,
      TsunamiWarning.forecast ||
      TsunamiWarning.forecastFromAdvisory ||
      TsunamiWarning.forecastFromWarning => 1,
      TsunamiWarning.none ||
      TsunamiWarning.warningCancelled ||
      TsunamiWarning.advisoryCancelled => 0,
    };
  }

  /// 津波警報の色を取得
  TsunamiWarningColor get color {
    return switch (this) {
      TsunamiWarning.majorWarning ||
      TsunamiWarning.majorWarningIssued => TsunamiWarningColor.purple,
      TsunamiWarning.warning => TsunamiWarningColor.red,
      TsunamiWarning.advisory => TsunamiWarningColor.yellow,
      TsunamiWarning.forecast ||
      TsunamiWarning.forecastFromAdvisory ||
      TsunamiWarning.forecastFromWarning => TsunamiWarningColor.blue,
      TsunamiWarning.none ||
      TsunamiWarning.warningCancelled ||
      TsunamiWarning.advisoryCancelled => TsunamiWarningColor.grey,
    };
  }

  /// アクティブな警報かどうか
  bool get isActive {
    return switch (this) {
      TsunamiWarning.majorWarning ||
      TsunamiWarning.majorWarningIssued ||
      TsunamiWarning.warning ||
      TsunamiWarning.advisory ||
      TsunamiWarning.forecast ||
      TsunamiWarning.forecastFromAdvisory ||
      TsunamiWarning.forecastFromWarning => true,
      TsunamiWarning.none ||
      TsunamiWarning.warningCancelled ||
      TsunamiWarning.advisoryCancelled => false,
    };
  }
}

/// 津波警報の色分類
enum TsunamiWarningColor {
  /// 紫（大津波警報）
  purple,

  /// 赤（津波警報）
  red,

  /// 黄（津波注意報）
  yellow,

  /// 青（津波予報）
  blue,

  /// グレー（警報なし・解除）
  grey,
}
