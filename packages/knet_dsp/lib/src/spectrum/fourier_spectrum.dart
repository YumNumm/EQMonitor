import 'package:knet_dsp/src/complex.dart';
import 'package:knet_dsp/src/spectrum/fft.dart';

/// フーリエスペクトル解析結果
class FourierSpectrum {
  const FourierSpectrum({
    required this.frequencies,
    required this.amplitudes,
    required this.phases,
    required this.complex,
    required this.dt,
    required this.fftLength,
  });

  /// 周波数ビン (Hz)（片側、DC〜Nyquist）
  final List<double> frequencies;

  /// 振幅スペクトル [入力単位]（片側）
  final List<double> amplitudes;

  /// 位相スペクトル (rad)（片側）
  final List<double> phases;

  /// 複素スペクトル（全体、0〜Nyquist 以降は共役対称）
  final List<Complex> complex;

  /// サンプリング間隔 (s)
  final double dt;

  /// FFT 長（ゼロパディング済み）
  final int fftLength;
}

/// フーリエスペクトルを計算するクラス
class FourierSpectrumAnalyzer {
  const FourierSpectrumAnalyzer({this.fft = const Fft()});

  final Fft fft;

  /// 実数時系列からフーリエスペクトルを計算します。
  ///
  /// x は入力時系列、dt はサンプリング間隔 (s) です。
  FourierSpectrum compute(List<double> x, double dt) {
    final spectrum = fft.forward(x);
    final n = spectrum.length;
    final halfLen = n ~/ 2 + 1;
    final freqs = Fft.frequencies(n, dt);

    final amplitudes = List<double>.generate(halfLen, (i) => spectrum[i].abs);
    final phases = List<double>.generate(halfLen, (i) => spectrum[i].phase);

    return FourierSpectrum(
      frequencies: freqs,
      amplitudes: amplitudes,
      phases: phases,
      complex: spectrum,
      dt: dt,
      fftLength: n,
    );
  }
}
