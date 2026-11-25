import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_geo_json_merger.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_features_provider.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_points_provider.g.dart';

/// 強震モニタ画像を解析した観測点の Feature。画像が変わったときだけ JSON を読み直す。
@riverpod
List<Object?> kyoshinMonitorImageFeatures(Ref ref) {
  final geoJson = ref.watch(
    kyoshinMonitorProvider.select((v) => v.value?.geoJson),
  );
  if (geoJson == null) {
    return const [];
  }
  try {
    return switch (jsonDecode(geoJson)) {
      {'features': final List<Object?> features} => features,
      _ => const [],
    };
  } on FormatException {
    return const [];
  }
}

/// 画像の観測点に、リプレイ中は波形から求めた観測点を重ねた Feature
@riverpod
List<Object?> kyoshinMonitorObservationFeatures(Ref ref) => ref
    .watch(replayWaveformGeoJsonMergerProvider)
    .merge(
      imageFeatures: ref.watch(kyoshinMonitorImageFeaturesProvider),
      waveformFeatures: ref.watch(replayWaveformFeaturesProvider),
    );

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の Feature
@riverpod
List<Object?> homeKyoshinMonitorObservationFeatures(Ref ref) {
  final features = ref.watch(kyoshinMonitorObservationFeaturesProvider);
  final min = ref.watch(
    homeConfigurationProvider.select(
      (a) => a.value?.kyoshinMonitor.minRealtimeShindo,
    ),
  );
  if (min == null) {
    return features;
  }
  return features
      .where(
        (feature) => switch (feature) {
          {'properties': {'intensity': final num intensity}} =>
            intensity.toDouble() > min,
          _ => true,
        },
      )
      .toList();
}

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON
@riverpod
String homeKyoshinMonitorObservationGeoJson(Ref ref) => jsonEncode({
  'type': 'FeatureCollection',
  'features': ref.watch(homeKyoshinMonitorObservationFeaturesProvider),
});

/// 観測点名ラベル用の GeoJSON
///
/// 観測値を含めず、表示中の観測点の集合が変わらない限り同じ文字列を返す。
/// 毎秒の観測値更新でラベルが再配置されるのを避ける。
@riverpod
String homeKyoshinMonitorStationLabelGeoJson(Ref ref) {
  final features = <Map<String, dynamic>>[];
  for (final feature in ref.watch(
    homeKyoshinMonitorObservationFeaturesProvider,
  )) {
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
