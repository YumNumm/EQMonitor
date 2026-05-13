import 'package:knet_dsp/src/spectrum/fourier_spectrum.dart';

/// エネルギースペクトル解析結果
class EnergySpectrum {
  const EnergySpectrum({
    required this.frequencies,
    required this.energy,
    required this.dt,
    required this.fftLength,
  });

  /// 周波数ビン (Hz)（片側）
  final List<double> frequencies;

  /// エネルギースペクトル [入力単位²・s]（片側）
  final List<double> energy;

  /// サンプリング間隔 (s)
  final double dt;

  /// FFT 長
  final int fftLength;
}

/// エネルギースペクトルを計算するクラス
///
/// Parseval の定理に基づき、E(f) = |X(f)|² * dt として定義します。
/// 片側スペクトルでは DC と Nyquist 以外のビンを 2 倍して両側分を合算します。
class EnergySpectrumAnalyzer {
  EnergySpectrumAnalyzer({FourierSpectrumAnalyzer? analyzer})
      : _analyzer = analyzer ?? const FourierSpectrumAnalyzer();

  final FourierSpectrumAnalyzer _analyzer;

  /// 実数時系列からエネルギースペクトルを計算します。
  ///
  /// x は入力時系列、dt はサンプリング間隔 (s) です。
  EnergySpectrum compute(List<double> x, double dt) {
    final fs = _analyzer.compute(x, dt);
    final n = fs.fftLength;
    final halfLen = n ~/ 2 + 1;

    // 片側エネルギースペクトル: DC と Nyquist は 1 倍、それ以外は 2 倍
    final energy = List<double>.generate(halfLen, (i) {
      final ampSq = fs.amplitudes[i] * fs.amplitudes[i];
      final factor = (i == 0 || i == n ~/ 2) ? 1.0 : 2.0;
      return factor * ampSq * dt;
    });

    return EnergySpectrum(
      frequencies: fs.frequencies,
      energy: energy,
      dt: dt,
      fftLength: n,
    );
  }
}
