import 'dart:math' as math;

import 'package:knet_dsp/knet_dsp.dart';
import 'package:test/test.dart';

void main() {
  const fft = Fft();

  group('FFT', () {
    test('既知の正弦波でピーク周波数を確認', () {
      // 1024 サンプル, サンプリングレート 100 Hz, 10 Hz 正弦波
      const n = 1024;
      const fs = 100.0;
      const freq = 10.0;
      final x = List<double>.generate(
        n,
        (i) => math.cos(2 * math.pi * freq * i / fs),
      );

      final spectrum = fft.forward(x);

      // 10 Hz に対応するビン: k = freq * N / fs = 10 * 1024 / 100 = 102.4 → 102
      final expectedBin = (freq * n / fs).round();
      var maxBin = 0;
      var maxAmp = 0.0;
      for (var i = 1; i <= spectrum.length ~/ 2; i++) {
        final amp = spectrum[i].abs;
        if (amp > maxAmp) {
          maxAmp = amp;
          maxBin = i;
        }
      }
      expect(maxBin, equals(expectedBin));
    });

    test('IFFT(FFT(x)) ≈ x', () {
      final x = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
      final spectrum = fft.forward(x);
      final recovered = fft.inverseReal(spectrum).sublist(0, x.length);

      for (var i = 0; i < x.length; i++) {
        expect(recovered[i], closeTo(x[i], 1e-10));
      }
    });

    test('周波数軸が正しく計算される', () {
      const n = 8;
      const dt = 0.01;
      final freqs = Fft.frequencies(n, dt);

      expect(freqs.length, equals(n ~/ 2 + 1));
      expect(freqs[0], closeTo(0.0, 1e-10));
      // df = 1/(N*dt) = 1/(8*0.01) = 12.5 Hz
      expect(freqs[1], closeTo(12.5, 1e-10));
      // Nyquist = fs/2 = 50 Hz
      expect(freqs.last, closeTo(50.0, 1e-10));
    });

    test('DC 入力のスペクトルが正しい', () {
      final x = List<double>.filled(8, 1);
      final spectrum = fft.forward(x);

      // DC ビンの振幅は N（= 8）
      expect(spectrum[0].abs, closeTo(8.0, 1e-10));
      // 他のビンはほぼ 0
      for (var i = 1; i < spectrum.length; i++) {
        expect(spectrum[i].abs, closeTo(0.0, 1e-10));
      }
    });
  });

  group('amplitudeSpectrum', () {
    test('正弦波の振幅スペクトルが非負', () {
      final x = List<double>.generate(
        512,
        (i) => math.sin(2 * math.pi * 5.0 * i / 100),
      );
      final amps = fft.amplitudeSpectrum(x);
      for (final a in amps) {
        expect(a, greaterThanOrEqualTo(0.0));
      }
    });
  });
}
