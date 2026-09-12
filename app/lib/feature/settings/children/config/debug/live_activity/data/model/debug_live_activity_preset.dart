/// 統合 Live Activity のローカル表示確認用プリセット。
enum DebugUnifiedPreset {
  shake('揺れ検知'),
  shakeEscalated('揺れ検知（強まり）'),
  shakeEnded('揺れ検知（終了）'),
  eew('緊急地震速報'),
  earthquake('地震情報'),
  allBlocks('全情報ブロック'),
  canceledEew('緊急地震速報（取消）'),
  canceledEarthquake('地震情報（取消）'),
  magnitudeUnknown('マグニチュード不明'),
  magnitudeOverM8('マグニチュード 8 超'),
  noLocation('現在地情報なし');

  new(this.label);

  final String label;
}
