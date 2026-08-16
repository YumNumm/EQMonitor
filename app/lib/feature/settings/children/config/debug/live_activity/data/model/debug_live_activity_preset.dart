/// EEW Live Activity のデバッグプリセット。
///
/// Widget Extension の `EewContentState` プレビューデータ
/// (`app/ios/Widget/LiveActivity/Eew/EewLiveActivityAttributes.swift`) と
/// 対応するケースを網羅し、表示検証を容易にする。
enum DebugEewPreset {
  warning('警報（第32報・北陸）'),
  finalReport('最終報'),
  forecast('予報（茨城県沖）'),
  plum('PLUM法による検知'),
  levelMethod('レベル法による検知'),
  onePoint('1点検知（低精度）'),
  canceled('取消報');

  const DebugEewPreset(this.label);

  final String label;
}

/// 揺れ検知 Live Activity のデバッグプリセット。
enum DebugShakePreset {
  weaker('微弱な揺れ (Weaker)'),
  weak('弱い揺れ (Weak)'),
  medium('揺れ (Medium)'),
  strong('強い揺れ (Strong)'),
  stronger('非常に強い揺れ (Stronger)');

  const DebugShakePreset(this.label);

  final String label;
}
