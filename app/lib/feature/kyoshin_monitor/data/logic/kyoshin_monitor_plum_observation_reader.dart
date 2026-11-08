import 'dart:convert';

import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_plum_observation.dart';

/// 強震モニタ解析 worker が生成した観測点 GeoJSON から、
/// リアルタイム震度を持つ観測点を取り出す。
///
/// 震度以外のデータ種別では `intensity` プロパティが無いため、空になる。
final class const KyoshinMonitorPlumObservationReader() {
  List<KyoshinMonitorPlumObservation> read(String geoJson) {
    try {
      if (jsonDecode(geoJson) case {'features': final List<dynamic> features}) {
        return [
          for (final feature in features)
            if (feature case {
              'geometry': {
                'coordinates': [final num longitude, final num latitude],
              },
              'properties': {
                'intensity': final num intensity,
                'name': final String name,
              },
            })
              KyoshinMonitorPlumObservation(
                name: name,
                latitude: latitude.toDouble(),
                longitude: longitude.toDouble(),
                intensity: intensity.toDouble(),
              ),
        ];
      }
    } on FormatException {
      return const [];
    }
    return const [];
  }
}
