import 'dart:math' as math;
import 'dart:typed_data';

import 'package:knet_dsp/src/complex.dart';

/// Cooley-Tukey FFT アルゴリズムの実装
///
/// 入力長が 2 の冪乗でない場合は自動的にゼロパディングを行います。
class Fft {
  const Fft();

  /// 実数入力に対する FFT を計算します。
  ///
  /// x は実数入力列、返り値は複素スペクトル（長さは次の 2 の冪乗）です。
  List<Complex> forward(List<double> x) {
    final n = _nextPowerOf2(x.length);
    final data = List<Complex>.generate(n, (i) {
      final val = i < x.length ? x[i] : 0.0;
      return Complex(val, 0);
    });
    return _fft(data, inverse: false);
  }

  /// 複素入力に対する IFFT を計算します。
  ///
  /// X は複素スペクトル、返り値は時間領域複素列（正規化済み）です。
  List<Complex> inverse(List<Complex> X) {
    final n = X.length;
    if (n <= 0 || (n & (n - 1)) != 0) {
      throw ArgumentError('IFFT length must be a positive power of 2, got $n');
    }
    final result = _fft(X, inverse: true);
    return result.map((c) => c / n.toDouble()).toList();
  }

  /// IFFT 後の実部のみを返します（実信号の復元）。
  List<double> inverseReal(List<Complex> X) {
    return inverse(X).map((c) => c.re).toList();
  }

  /// 振幅スペクトルを計算します（片側: DC〜Nyquist）。
  ///
  /// 返り値の長さは n/2 + 1（n は FFT 長）です。
  List<double> amplitudeSpectrum(List<double> x) {
    final spectrum = forward(x);
    final halfLen = spectrum.length ~/ 2 + 1;
    return List<double>.generate(halfLen, (i) => spectrum[i].abs);
  }

  /// 対応する周波数ビンを返します。
  ///
  /// n は FFT 長（forward で返った複素列の長さ）、dt はサンプリング間隔 (s) です。
  static List<double> frequencies(int n, double dt) {
    final halfLen = n ~/ 2 + 1;
    final df = 1.0 / (n * dt);
    return List<double>.generate(halfLen, (i) => i * df);
  }

  // --- internal ---

  List<Complex> _fft(List<Complex> data, {required bool inverse}) {
    final n = data.length;
    if (n == 1) {
      return List<Complex>.from(data);
    }

    final buffer = Float64List(2 * n); // interleaved re/im
    for (var i = 0; i < n; i++) {
      buffer[2 * i] = data[i].re;
      buffer[2 * i + 1] = data[i].im;
    }
    _fftInPlace(buffer, n, inverse: inverse);
    return List<Complex>.generate(n, (i) => Complex(buffer[2 * i], buffer[2 * i + 1]));
  }

  /// インプレース Cooley-Tukey FFT（ビット反転 + バタフライ演算）
  void _fftInPlace(Float64List data, int n, {required bool inverse}) {
    // ビット反転置換
    var j = 0;
    for (var i = 1; i < n; i++) {
      var bit = n >> 1;
      while ((j & bit) != 0) {
        j ^= bit;
        bit >>= 1;
      }
      j ^= bit;
      if (i < j) {
        final re = data[2 * i];
        final im = data[2 * i + 1];
        data[2 * i] = data[2 * j];
        data[2 * i + 1] = data[2 * j + 1];
        data[2 * j] = re;
        data[2 * j + 1] = im;
      }
    }

    // バタフライ演算
    final sign = inverse ? 1.0 : -1.0;
    for (var len = 2; len <= n; len <<= 1) {
      final ang = sign * 2.0 * math.pi / len;
      final wRe = math.cos(ang);
      final wIm = math.sin(ang);
      for (var i = 0; i < n; i += len) {
        var curRe = 1.0;
        var curIm = 0.0;
        for (var k = 0; k < len ~/ 2; k++) {
          final uRe = data[2 * (i + k)];
          final uIm = data[2 * (i + k) + 1];
          final half = i + k + len ~/ 2;
          final vRe = data[2 * half] * curRe - data[2 * half + 1] * curIm;
          final vIm = data[2 * half] * curIm + data[2 * half + 1] * curRe;
          data[2 * (i + k)] = uRe + vRe;
          data[2 * (i + k) + 1] = uIm + vIm;
          data[2 * half] = uRe - vRe;
          data[2 * half + 1] = uIm - vIm;
          final nextRe = curRe * wRe - curIm * wIm;
          final nextIm = curRe * wIm + curIm * wRe;
          curRe = nextRe;
          curIm = nextIm;
        }
      }
    }
  }

  static int _nextPowerOf2(int n) {
    if (n <= 1) {
      return 1;
    }
    var p = 1;
    while (p < n) {
      p <<= 1;
    }
    return p;
  }
}
