import 'dart:math';
import 'dart:typed_data';

/// フーリエ振幅スペクトル計算結果
class FourierSpectrumResult {
  const FourierSpectrumResult({
    required this.frequencies,
    required this.amplitudes,
  });

  /// 周波数 (Hz)
  final List<double> frequencies;

  /// 振幅 (gal·s = gal/Hz の正規化前)
  final List<double> amplitudes;
}

/// 加速度波形のフーリエ振幅スペクトルを計算する (Cooley-Tukey FFT)
class KnetFourierSpectrum {
  const KnetFourierSpectrum._();

  /// フーリエ振幅スペクトルを計算する
  ///
  /// [data] 加速度波形 (gal)
  /// [samplingFreqHz] サンプリング周波数 (Hz)
  /// [smoothingWidth] 対数スムージングの幅 (0 で無効)
  static FourierSpectrumResult compute(
    List<double> data,
    double samplingFreqHz, {
    int smoothingWidth = 5,
  }) {
    if (data.isEmpty) {
      return const FourierSpectrumResult(frequencies: [], amplitudes: []);
    }

    // 2の冪乗に拡張
    final n = _nextPow2(data.length);
    final re = Float64List(n);
    final im = Float64List(n);
    for (var i = 0; i < data.length; i++) {
      re[i] = data[i];
    }

    _fftInPlace(re, im, n);

    final halfN = n ~/ 2;
    final dt = 1.0 / samplingFreqHz;
    final df = samplingFreqHz / n;

    final freqs = List<double>.generate(halfN, (k) => k * df);
    final amps = List<double>.generate(
      halfN,
      (k) => sqrt(re[k] * re[k] + im[k] * im[k]) * dt,
    );

    // 対数スムージング
    final smoothed = smoothingWidth > 1
        ? _logSmooth(amps, smoothingWidth)
        : amps;

    // f=0 を除いた 0.1Hz〜 の範囲に絞る
    final startIdx = (0.1 / df).ceil().clamp(1, halfN - 1);
    return FourierSpectrumResult(
      frequencies: freqs.sublist(startIdx),
      amplitudes: smoothed.sublist(startIdx),
    );
  }

  /// 対数スムージング（移動平均）
  static List<double> _logSmooth(List<double> data, int w) {
    final out = List<double>.filled(data.length, 0);
    for (var i = 0; i < data.length; i++) {
      var sum = 0.0;
      var count = 0;
      for (var j = (i - w).clamp(0, data.length - 1);
          j <= (i + w).clamp(0, data.length - 1);
          j++) {
        sum += data[j];
        count++;
      }
      out[i] = count > 0 ? sum / count : data[i];
    }
    return out;
  }

  /// 2の冪乗への切り上げ
  static int _nextPow2(int n) {
    var p = 1;
    while (p < n) {
      p <<= 1;
    }
    return p;
  }

  /// ビット反転 in-place Cooley-Tukey FFT
  static void _fftInPlace(Float64List re, Float64List im, int n) {
    // Bit-reversal permutation
    var j = 0;
    for (var i = 1; i < n; i++) {
      var bit = n >> 1;
      while (j >= bit) {
        j -= bit;
        bit >>= 1;
      }
      j += bit;
      if (i < j) {
        final tr = re[i]; re[i] = re[j]; re[j] = tr;
        final ti = im[i]; im[i] = im[j]; im[j] = ti;
      }
    }

    // Butterfly operations
    for (var len = 2; len <= n; len <<= 1) {
      final half = len >> 1;
      final wReal = cos(-2 * pi / len);
      final wImag = sin(-2 * pi / len);
      for (var k = 0; k < n; k += len) {
        var wr = 1.0;
        var wi = 0.0;
        for (var m = 0; m < half; m++) {
          final a = k + m;
          final b = a + half;
          final tr = wr * re[b] - wi * im[b];
          final ti = wr * im[b] + wi * re[b];
          re[b] = re[a] - tr;
          im[b] = im[a] - ti;
          re[a] += tr;
          im[a] += ti;
          final nextWr = wr * wReal - wi * wImag;
          wi = wr * wImag + wi * wReal;
          wr = nextWr;
        }
      }
    }
  }
}
