import 'package:flutter/material.dart';
import 'package:jma_map/gen/jma_map.pb.dart';
import 'package:jma_map/src/layers/map_layer_host.dart';

/// 地図のレイヤー設定
/// C#の`LandLayerSet`に相当
class JmaMapLayerSet {
  /// 最小ズームレベル
  final int minZoom;

  /// レイヤータイプ
  final JmaMap_JmaMapData_JmaMapType layerType;

  /// コンストラクタ
  const JmaMapLayerSet({
    required this.minZoom,
    required this.layerType,
  });

  /// デフォルトのレイヤー設定
  static const List<JmaMapLayerSet> defaultLayerSets = [
    JmaMapLayerSet(
      minZoom: 11,
      layerType: JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY,
    ),
    JmaMapLayerSet(
      minZoom: 0,
      layerType: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E,
    ),
  ];
}

/// 地図の状態を管理するクラス
/// C#の`MapController`に相当
class JmaMapController {
  /// 地図データ
  final JmaMap map;

  /// 現在のズームレベル
  double _zoom;

  /// 現在のズームレベルを取得
  double get zoom => _zoom;

  /// 現在のズームレベルを設定
  set zoom(double value) {
    if (_zoom == value) return;
    _zoom = value;
    notifyListeners();
  }

  /// 現在の位置（画面中央の地理座標）
  JmaMap_LatLng _center;

  /// 現在の位置を取得
  JmaMap_LatLng get center => _center;

  /// 現在の位置を設定
  set center(JmaMap_LatLng value) {
    if (_center.lat == value.lat && _center.lng == value.lng) return;
    _center = value;
    notifyListeners();
  }

  /// レイヤーホスト
  final MapLayerHost layerHost;

  /// レイヤー設定
  List<JmaMapLayerSet> _layerSets;

  /// レイヤー設定を取得
  List<JmaMapLayerSet> get layerSets => _layerSets;

  /// レイヤー設定を設定
  set layerSets(List<JmaMapLayerSet> value) {
    _layerSets = value;
    notifyListeners();
  }

  /// 状態変更リスナー
  final List<VoidCallback> _listeners = [];

  /// コンストラクタ
  JmaMapController({
    required this.map,
    double initialZoom = 5.0,
    JmaMap_LatLng? initialCenter,
    List<JmaMapLayerSet>? layerSets,
    MapLayerHost? layerHost,
  })  : _zoom = initialZoom,
        _center = initialCenter ?? JmaMap_LatLng(lat: 35.681236, lng: 139.767125), // 東京駅
        _layerSets = layerSets ?? JmaMapLayerSet.defaultLayerSets,
        layerHost = layerHost ?? MapLayerHost() {
    this.layerHost.onRefreshRequested = notifyListeners;
  }

  /// リスナーを追加
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// リスナーを削除
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// リスナーに通知
  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// ズームイン
  void zoomIn() {
    zoom = zoom + 1.0;
  }

  /// ズームアウト
  void zoomOut() {
    zoom = zoom - 1.0;
  }

  /// 指定した位置に移動
  void moveTo(JmaMap_LatLng position) {
    center = position;
  }

  /// 現在のズームレベルに応じたレイヤータイプを取得
  JmaMap_JmaMapData_JmaMapType getLayerType() {
    final intZoom = zoom.ceil();

    for (final layerSet in _layerSets) {
      if (intZoom >= layerSet.minZoom) {
        return layerSet.layerType;
      }
    }

    // デフォルト値
    return JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E;
  }
}
