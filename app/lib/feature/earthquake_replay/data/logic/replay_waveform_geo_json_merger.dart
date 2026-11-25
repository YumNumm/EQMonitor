import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_geo_json_merger.g.dart';

@riverpod
ReplayWaveformGeoJsonMerger replayWaveformGeoJsonMerger(Ref ref) =>
    const ReplayWaveformGeoJsonMerger();

// 波形から値が求まった観測点は、同じ名前の画像由来の点より優先する。
// 波形の値が無い時刻（lost）は、画像由来の点が無い観測点だけ枠線で描く。
class const ReplayWaveformGeoJsonMerger() {
  List<Object?> merge({
    required List<Object?> imageFeatures,
    required List<Map<String, dynamic>> waveformFeatures,
  }) {
    if (waveformFeatures.isEmpty) {
      return imageFeatures;
    }
    final measuredNames = {
      for (final feature in waveformFeatures)
        if (!_isLost(feature)) ?_nameOf(feature),
    };
    final imageNames = {
      for (final feature in imageFeatures) ?_nameOf(feature),
    };
    return [
      for (final feature in imageFeatures)
        if (_nameOf(feature) case final name
            when name == null || !measuredNames.contains(name))
          feature,
      for (final feature in waveformFeatures)
        if (!_isLost(feature) || !imageNames.contains(_nameOf(feature)))
          feature,
    ];
  }

  bool _isLost(Object? feature) => switch (feature) {
    {'properties': {'lost': true}} => true,
    _ => false,
  };

  String? _nameOf(Object? feature) => switch (feature) {
    {'properties': {'name': final String name}} => name,
    _ => null,
  };
}
