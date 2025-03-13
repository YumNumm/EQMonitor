import 'package:flutter/material.dart';
import 'package:map_plugin/map_plugin_ios.dart';

/// 観測点データクラス
class ObservationPoint {
  final String id;
  final double latitude;
  final double longitude;
  final double intensity; // 震度値
  final Color color; // 表示色

  const ObservationPoint({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.intensity,
    required this.color,
  });
}

/// マッププラグインの共通インターフェース
class MapPlugin extends StatelessWidget {
  const MapPlugin({
    super.key,
    this.onStyleLoaded,
    this.onCameraMoved,
    this.onMapCreated,
    required this.styleString,
    this.observationPoints = const [],
  });

  /// スタイル読み込み完了時コールバック
  final VoidCallback? onStyleLoaded;

  /// カメラ移動時コールバック
  final VoidCallback? onCameraMoved;

  /// マップ作成完了時コールバック
  final void Function(dynamic)? onMapCreated;

  /// マップスタイル
  final String styleString;

  /// 観測点データ
  final List<ObservationPoint> observationPoints;

  @override
  Widget build(BuildContext context) {
    return MapPluginIos(
      onStyleLoaded: onStyleLoaded,
      onCameraMoved: onCameraMoved,
      onMapCreated: onMapCreated,
      styleString: styleString,
      observationPoints:
          observationPoints
              .map(
                (point) => ObservationPointIos(
                  id: point.id,
                  latitude: point.latitude,
                  longitude: point.longitude,
                  intensity: point.intensity,
                  color: point.color,
                ),
              )
              .toList(),
    );
  }
}
