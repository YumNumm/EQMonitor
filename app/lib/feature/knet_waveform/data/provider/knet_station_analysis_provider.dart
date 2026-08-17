import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_analysis.dart';
import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_result.dart';
import 'package:flutter/foundation.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_station_analysis_provider.g.dart';

/// 観測点波形の重解析を非同期（Isolate）で実行するプロバイダー
@riverpod
Future<KnetStationAnalysis> knetStationAnalysis(
  Ref ref,
  KnetStationResult result,
) async {
  return compute(KnetStationAnalysisCalculator.analyze, result);
}

/// 観測点波形から PGA・PGV・PGD・応答スペクトル等を計算する。
///
/// [compute] の Isolate 実行に渡すため static メソッドとして定義する。
class KnetStationAnalysisCalculator {
  static KnetStationAnalysis analyze(KnetStationResult result) {
    final record = result.record;
    final fs = record.samplingFrequencyHz;
    final dt = 1.0 / fs;
    final dirs = record.channelDirections;
    final nCh = dirs.length;

    // --- バイアス除去済み加速度 (per channel) ---
    final accel = List<List<double>>.generate(nCh, (ch) {
      final raw = record.dataPoints.map((p) {
        return ch < p.accelerationsGal.length ? p.accelerationsGal[ch] : 0.0;
      }).toList();
      final bias = ch < record.offsets.length && record.offsets[ch] != 0.0
          ? record.offsets[ch]
          : meanOfFirst(raw, (raw.length * 0.1).round().clamp(1, raw.length));
      return raw.map((v) => v - bias).toList();
    });

    // --- 速度・変位 ---
    final velocity = <List<double>>[];
    final displacement = <List<double>>[];
    final pga = <double>[];
    final pgv = <double>[];
    final pgd = <double>[];

    for (var ch = 0; ch < nCh; ch++) {
      final a = accel[ch];
      final (vel, disp) = KnetWaveformIntegration.computeVelDisp(a, dt);
      velocity.add(vel);
      displacement.add(disp);
      pga.add(KnetWaveformIntegration.peakAbsolute(a));
      pgv.add(KnetWaveformIntegration.peakAbsolute(vel));
      pgd.add(KnetWaveformIntegration.peakAbsolute(disp));
    }

    // --- 最大 PGA チャンネルを応答スペクトル・FFT に使用 ---
    final maxChIdx = pga.isEmpty
        ? 0
        : pga.indexOf(pga.reduce((a, b) => a > b ? a : b));
    final refAccel = maxChIdx < accel.length ? accel[maxChIdx] : <double>[];

    // --- 応答スペクトル h=5% ---
    final rs5 = KnetResponseSpectrum.compute(refAccel, dt, 0.05);

    // --- SI値用スペクトル h=20% ---
    final siPeriods = KnetResponseSpectrum.siPeriods();
    final rsSI = KnetResponseSpectrum.compute(
      refAccel,
      dt,
      0.20,
      periods: siPeriods,
    );
    final si = rsSI.siValue;

    // --- フーリエスペクトル ---
    final fft = KnetFourierSpectrum.compute(refAccel, fs);

    return KnetStationAnalysis(
      pga: pga,
      pgv: pgv,
      pgd: pgd,
      velocity: velocity,
      displacement: displacement,
      responseSpectrum5pct: rs5,
      fourierSpectrum: fft,
      siValue: si,
    );
  }

  static double meanOfFirst(List<double> data, int count) {
    if (data.isEmpty) {
      return 0;
    }
    var sum = 0.0;
    for (var i = 0; i < count && i < data.length; i++) {
      sum += data[i];
    }
    return sum / count;
  }
}
