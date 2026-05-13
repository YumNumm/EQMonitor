import 'package:knet_dsp/src/filter/knet_filter.dart';

/// 台形則による数値積分フィルタ
///
/// 加速度→速度、速度→変位などの積分に使用します。
///
/// アルゴリズム: `y[n] = y[n-1] + (x[n] + x[n-1]) / 2 * dt`
///
/// 初期値は 0 とします。
class IntegrationFilter implements KnetFilter {
  const IntegrationFilter();

  @override
  List<double> apply(List<double> x, double dt) {
    if (x.isEmpty) {
      return [];
    }
    final result = List<double>.filled(x.length, 0);
    for (var i = 1; i < x.length; i++) {
      result[i] = result[i - 1] + (x[i] + x[i - 1]) * 0.5 * dt;
    }
    return result;
  }
}
