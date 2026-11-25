import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_geo_json_merger.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_features_provider.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_points_provider.g.dart';

@riverpod
String kyoshinMonitorObservationGeoJson(Ref ref) {
  final imageGeoJson = ref.watch(
    kyoshinMonitorProvider.select((v) => v.value?.geoJson),
  );
  return ref
          .watch(replayWaveformGeoJsonMergerProvider)
          .merge(
            imageGeoJson: imageGeoJson,
            waveformFeatures: ref.watch(replayWaveformFeaturesProvider),
          ) ??
      jsonEncode({
        'type': 'FeatureCollection',
        'features': <Map<String, dynamic>>[],
      });
}

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON
@riverpod
String homeKyoshinMonitorObservationGeoJson(Ref ref) {
  final raw = ref.watch(kyoshinMonitorObservationGeoJsonProvider);
  final min = ref.watch(
    homeConfigurationProvider.select(
      (a) => a.value?.kyoshinMonitor.minRealtimeShindo,
    ),
  );
  if (min == null) {
    return raw;
  }
  try {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final features = decoded['features'];
    if (features is! List<dynamic>) {
      return raw;
    }
    final filtered = <dynamic>[];
    for (final f in features) {
      if (f is! Map<String, dynamic>) {
        continue;
      }
      final props = f['properties'];
      if (props is! Map<String, dynamic>) {
        filtered.add(f);
        continue;
      }
      final intensity = props['intensity'];
      if (intensity is! num) {
        filtered.add(f);
        continue;
      }
      if (intensity.toDouble() > min) {
        filtered.add(f);
      }
    }
    return jsonEncode(<String, dynamic>{
      'type': 'FeatureCollection',
      'features': filtered,
    });
  } on Exception {
    return raw;
  }
}

/// 観測点名ラベル用の GeoJSON
///
/// 観測値を含めず、表示中の観測点の集合が変わらない限り同じ文字列を返す。
/// 毎秒の観測値更新でラベルが再配置されるのを避ける。
@riverpod
String homeKyoshinMonitorStationLabelGeoJson(Ref ref) {
  final raw = ref.watch(homeKyoshinMonitorObservationGeoJsonProvider);
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  final features = <Map<String, dynamic>>[];
  for (final feature in decoded['features'] as List<dynamic>) {
    if (feature case {
      'geometry': final Object geometry,
      'properties': {'name': final String name},
    }) {
      features.add({
        'type': 'Feature',
        'geometry': geometry,
        'properties': {'name': name},
      });
    }
  }
  return jsonEncode({'type': 'FeatureCollection', 'features': features});
}
