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

  new(this.label);

  final String label;
}
