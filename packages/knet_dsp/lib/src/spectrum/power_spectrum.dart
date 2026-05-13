import 'package:knet_dsp/src/spectrum/fourier_spectrum.dart';

/// パワースペクトル解析結果
class PowerSpectrum {
  const PowerSpectrum({
    required this.frequencies,
    required this.power,
    required this.dt,
    required this.fftLength,
  });

  /// 周波数ビン (Hz)（片側）
  final List<double> frequencies;

  /// パワースペクトル密度 [入力単位²/Hz]（片側）
  final List<double> power;

  /// サンプリング間隔 (s)
  final double dt;

  /// FFT 長
  final int fftLength;
}

/// パワースペクトルを計算するクラス
class PowerSpectrumAnalyzer {
  PowerSpectrumAnalyzer({FourierSpectrumAnalyzer? analyzer})
      : _analyzer = analyzer ?? const FourierSpectrumAnalyzer();

  final FourierSpectrumAnalyzer _analyzer;

  /// 実数時系列からパワースペクトル密度（PSD）を計算します。
  ///
  /// x は入力時系列、dt はサンプリング間隔 (s) です。
  /// PSD の定義: P(f) = |X(f)|² / (fs * N)
  /// 片側スペクトルでは DC と Nyquist 以外のビンを 2 倍して両側分を合算します。
  PowerSpectrum compute(List<double> x, double dt) {
    final fs = _analyzer.compute(x, dt);
    final n = fs.fftLength;
    final sampleRate = 1.0 / dt;
    final halfLen = n ~/ 2 + 1;

    // 片側 PSD: DC と Nyquist は 1 倍、それ以外は 2 倍（エネルギー保存）
    // P(f) = |X(f)|² / (fs * N)
    final power = List<double>.generate(halfLen, (i) {
      final ampSq = fs.amplitudes[i] * fs.amplitudes[i];
      final factor = (i == 0 || i == n ~/ 2) ? 1.0 : 2.0;
      return factor * ampSq / (sampleRate * n);
    });

    return PowerSpectrum(
      frequencies: fs.frequencies,
      power: power,
      dt: dt,
      fftLength: n,
    );
  }
}
