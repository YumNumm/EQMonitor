import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/kyoshin_color_map_model.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_waveform_station.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_color_map_model.dart';

// 強震モニタの画像を解析した観測点と同じプロパティ（color・intensity・name）の GeoJSON Feature を作る。
class const ReplayWaveformFeatureBuilder({
  required final List<KyoshinColorMapModel> colorMap,
  required final Map<String, String> stationNames,
}) {
  List<Map<String, dynamic>> build({
    required List<ReplayWaveformStation> stations,
    required DateTime time,
  }) => [
    for (final station in stations)
      if (station.intensities.valueAt(time) case final intensity?)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [station.longitude, station.latitude],
          },
          'properties': {
            'color': _colorHex(intensity),
            'intensity': intensity,
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
