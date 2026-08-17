/// デバッグ用 Live Activity の種別。
///
/// ネイティブ (`net.yumnumm.eqmonitor/live_activity_debug` MethodChannel) へ渡す
/// `kind` 文字列は Widget Extension 側の `attributes-type` と対応する。
enum DebugLiveActivityKind {
  eew('eew', 'EEW（緊急地震速報）'),
  shakeDetection('shake_detection', '揺れ検知');

  const DebugLiveActivityKind(this.wireName, this.label);

  /// MethodChannel / ContentState `type` フィールドで使用する識別子。
  final String wireName;

  /// UI 表示用ラベル。
  final String label;
}
