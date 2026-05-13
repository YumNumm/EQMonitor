/// K-NET 信号処理フィルタの抽象インターフェース
abstract interface class KnetFilter {
  /// フィルタを適用します。
  ///
  /// x は入力時系列、dt はサンプリング間隔 (s) です。
  /// 返り値はフィルタ適用後の時系列（入力と同じ長さ）。
  List<double> apply(List<double> x, double dt);
}
