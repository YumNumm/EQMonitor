import 'dart:math' as math;

/// 2次 IIR フィルタ係数
class IirCoefficients {
  const IirCoefficients({
    required this.b0,
    required this.b1,
    required this.b2,
    required this.a1,
    required this.a2,
  });

  final double b0;
  final double b1;
  final double b2;

  /// フィードバック係数（a0 = 1 に正規化済み）
  final double a1;
  final double a2;
}

/// Butterworth フィルタ係数の設計ユーティリティ
class ButterworthDesigner {
  const ButterworthDesigner._();

  /// 2次ローパス Butterworth フィルタ係数を計算します（双線形変換）。
  ///
  /// cutoffHz はカットオフ周波数 (Hz)、sampleRate はサンプリングレート (Hz) です。
  static IirCoefficients lpf(double cutoffHz, double sampleRate) {
    // 双線形変換プリウォーピング: k = tan(π·fc/fs)
    final k = math.tan(math.pi * cutoffHz / sampleRate);
    final k2 = k * k;
    final sqrt2 = math.sqrt(2.0);
    final denom = 1.0 + sqrt2 * k + k2;

    return IirCoefficients(
      b0: k2 / denom,
      b1: 2.0 * k2 / denom,
      b2: k2 / denom,
      a1: 2.0 * (k2 - 1.0) / denom,
      a2: (1.0 - sqrt2 * k + k2) / denom,
    );
  }

  /// 2次ハイパス Butterworth フィルタ係数を計算します（双線形変換）。
  static IirCoefficients hpf(double cutoffHz, double sampleRate) {
    // 双線形変換プリウォーピング: k = tan(π·fc/fs)
    final k = math.tan(math.pi * cutoffHz / sampleRate);
    final k2 = k * k;
    final sqrt2 = math.sqrt(2.0);
    final denom = 1.0 + sqrt2 * k + k2;

    return IirCoefficients(
      b0: 1.0 / denom,
      b1: -2.0 / denom,
      b2: 1.0 / denom,
      a1: 2.0 * (k2 - 1.0) / denom,
      a2: (1.0 - sqrt2 * k + k2) / denom,
    );
  }
}

/// ゼロ位相 IIR フィルタリング（filtfilt 相当）
///
/// 前向き・後向きの 2 回適用でゼロ位相フィルタリングを実現します。
/// 端点のトランジェントを軽減するためミラーパディングを使用します。
class ZeroPhaseIirFilter {
  const ZeroPhaseIirFilter();

  /// ゼロ位相フィルタリングを適用します。
  List<double> apply(List<double> x, IirCoefficients c) {
    if (x.length < 3) {
      return List<double>.from(x);
    }

    // パディング長（フィルタの次数 × 3）
    const padLen = 6;
    final padded = _mirrorPad(x, padLen);

    // 前向きフィルタリング
    final forward = _iir(padded, c);

    // 後向きフィルタリング（反転して適用し、再反転）
    final reversed = forward.reversed.toList();
    final backward = _iir(reversed, c);
    final result = backward.reversed.toList();

    // パディングを除去して返す
    return result.sublist(padLen, padLen + x.length);
  }

  static List<double> _mirrorPad(List<double> x, int padLen) {
    final n = x.length;
    final result = List<double>.filled(n + 2 * padLen, 0);
    // 先頭のミラーパディング
    for (var i = 0; i < padLen; i++) {
      result[i] = x[math.min(padLen - i, n - 1)];
    }
    // 本体
    for (var i = 0; i < n; i++) {
      result[padLen + i] = x[i];
    }
    // 末尾のミラーパディング
    for (var i = 0; i < padLen; i++) {
      result[padLen + n + i] = x[math.max(n - 2 - i, 0)];
    }
    return result;
  }

  static List<double> _iir(List<double> x, IirCoefficients c) {
    final n = x.length;
    final y = List<double>.filled(n, 0);
    for (var i = 0; i < n; i++) {
      final x0 = x[i];
      final x1 = i >= 1 ? x[i - 1] : 0.0;
      final x2 = i >= 2 ? x[i - 2] : 0.0;
      final y1 = i >= 1 ? y[i - 1] : 0.0;
      final y2 = i >= 2 ? y[i - 2] : 0.0;
      y[i] = c.b0 * x0 + c.b1 * x1 + c.b2 * x2 - c.a1 * y1 - c.a2 * y2;
    }
    return y;
  }
}
