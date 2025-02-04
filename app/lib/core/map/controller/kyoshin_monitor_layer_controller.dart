import 'package:eqmonitor/core/map/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_layer_controller.g.dart';

/// 強震モニタの観測点レイヤーを管理するコントローラー
@riverpod
class KyoshinMonitorLayerController extends _$KyoshinMonitorLayerController {
  @override
  MapLayer? build() {
    // 強震モニタの状態を監視
    ref.listen(
      kyoshinMonitorNotifierProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          _updateLayer(value);
        }
      },
    );
    return null;
  }

  /// レイヤーを更新
  void _updateLayer(KyoshinMonitorState value) {
    final points = value.analyzedPoints;
    if (points == null || points.isEmpty) {
      state = null;
      return;
    }

    // GeoJSONのフィーチャーを生成
    final features = points.map((point) {
      return {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [
            point.point.location.longitude,
            point.point.location.latitude,
          ],
        },
        'properties': {
          'color': point.observation.color.toHex,
          'name': point.point.name,
          'code': point.point.code,
        },
      };
    }).toList();

    state = MapLayer.circle(
      id: 'kyoshin-monitor-points',
      sourceId: 'kyoshin-monitor-points',
      circles: features,
      circleRadius: 6,
      circleColor: Colors.red,
      circleOpacity: 0.8,
      circleStrokeWidth: 1,
      circleStrokeColor: Colors.white,
    );
  }
}


extension _ColorInt8Ex on ColorInt8 {
  String get toHex {
    final r = (rNormalized * 255).toInt();
    final g = (gNormalized * 255).toInt();
    final b = (bNormalized * 255).toInt();
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }
}
