import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_geo_json_merger.g.dart';

@riverpod
ReplayWaveformGeoJsonMerger replayWaveformGeoJsonMerger(Ref ref) =>
    const ReplayWaveformGeoJsonMerger();

// 波形から求めた観測点を画像の観測点より優先し、同じ観測点の画像由来の点は除く。
class const ReplayWaveformGeoJsonMerger() {
  String? merge({
    required String? imageGeoJson,
    required List<Map<String, dynamic>> waveformFeatures,
  }) {
    if (waveformFeatures.isEmpty) {
      return imageGeoJson;
    }
    final waveformNames = {
      for (final feature in waveformFeatures)
        if (feature case {'properties': {'name': final String name}}) name,
    };
    final imageFeatures = switch (imageGeoJson) {
      final json? => switch (jsonDecode(json)) {
        {'features': final List<dynamic> features} => features,
        _ => const <dynamic>[],
      },
      null => const <dynamic>[],
    };
    return jsonEncode({
      'type': 'FeatureCollection',
      'features': [
        ...imageFeatures.where(
          (feature) => switch (feature) {
            {'properties': {'name': final String name}} =>
              !waveformNames.contains(name),
            _ => true,
          },
        ),
        ...waveformFeatures,
      ],
    });
  }
}
