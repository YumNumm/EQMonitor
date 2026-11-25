import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';

part 'replay_waveform_station.freezed.dart';

@freezed
abstract class ReplayWaveformStation with _$ReplayWaveformStation {
  const factory({
    required String stationCode,
    required double latitude,
    required double longitude,
    required RealtimeIntensitySeries intensities,
  }) = _ReplayWaveformStation;
}
