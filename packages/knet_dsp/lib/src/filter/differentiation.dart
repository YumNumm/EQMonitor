import 'package:knet_dsp/src/filter/knet_filter.dart';

/// 有限差分による数値微分フィルタ
///
/// 中央差分を基本とし、端点は前進/後退差分を使用します。
///
/// - 中央差分: `dy[n] = (x[n+1] - x[n-1]) / (2*dt)`
/// - 前進差分（先頭）: `dy[0] = (x[1] - x[0]) / dt`
/// - 後退差分（末尾）: `dy[N-1] = (x[N-1] - x[N-2]) / dt`
class DifferentiationFilter implements KnetFilter {
  const DifferentiationFilter();

  @override
  List<double> apply(List<double> x, double dt) {
    if (x.isEmpty) {
      return [];
    }
    if (x.length == 1) {
      return [0.0];
    }

    final n = x.length;
    final result = List<double>.filled(n, 0);

    // 先頭: 前進差分
    result[0] = (x[1] - x[0]) / dt;

    // 中間: 中央差分
    for (var i = 1; i < n - 1; i++) {
      result[i] = (x[i + 1] - x[i - 1]) / (2 * dt);
    }

    // 末尾: 後退差分
    result[n - 1] = (x[n - 1] - x[n - 2]) / dt;

    return result;
  }
}
