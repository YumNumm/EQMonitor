import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/kyoshin_color_map_model.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_waveform_station.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_color_map_model.dart';

// 強震モニタの画像を解析した観測点と同じプロパティ（color・intensity・name）の GeoJSON Feature を作る。
// 記録の前後で値が無い時刻は、欠測と同じく lost にして枠線だけで描かせる。
class const ReplayWaveformFeatureBuilder({
  required final List<KyoshinColorMapModel> colorMap,
  required final Map<String, String> stationNames,
}) {
  List<Map<String, dynamic>> build({
    required List<ReplayWaveformStation> stations,
    required DateTime time,
  }) => [
    for (final station in stations)
      {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [station.longitude, station.latitude],
        },
        'properties': {
          ...switch (station.intensities.valueAt(time)) {
            final intensity? => {
              'color': _colorHex(intensity),
              'intensity': intensity,
            },
            null => {'lost': true},
          },
          'name': stationNames[station.stationCode] ?? station.stationCode,
        },
      },
  ];

  String _colorHex(double intensity) {
    final entry = minBy(
      colorMap,
      (entry) => (entry.intensity - intensity).abs(),
    );
    final rgb = (entry?.color.toARGB32() ?? 0xFF808080) & 0xFFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
