import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// 宣言的なMapLibreMapのラッパー
class DeclarativeMap extends StatefulHookConsumerWidget {
  const DeclarativeMap({
    required this.initialCameraPosition,
    required this.controller,
    required this.styleString,
    super.key,
    this.onStyleLoadedCallback,
    this.onCameraIdle,
    this.layers = const [],
    this.myLocationEnabled = false,
    this.myLocationRenderMode = MyLocationRenderMode.normal,
    this.myLocationTrackingMode = MyLocationTrackingMode.none,
    this.compassEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.doubleClickZoomEnabled = true,
  });

  /// 初期カメラ位置
  final MapCameraPosition initialCameraPosition;

  /// マップコントローラー
  final DeclarativeMapController controller;

  /// スタイル読み込み完了時のコールバック
  final void Function()? onStyleLoadedCallback;

  /// カメラ移動完了時のコールバック
  final void Function(MapCameraPosition)? onCameraIdle;

  /// レイヤーのリスト
  final List<MapLayer> layers;

  /// 現在位置の表示
  final bool myLocationEnabled;

  /// 現在位置の表示モード
  final MyLocationRenderMode myLocationRenderMode;

  /// 現在位置の追跡モード
  final MyLocationTrackingMode myLocationTrackingMode;

  /// コンパスの表示
  final bool compassEnabled;

  /// 回転ジェスチャーの有効化
  final bool rotateGesturesEnabled;

  /// スクロールジェスチャーの有効化
  final bool scrollGesturesEnabled;

  /// ズームジェスチャーの有効化
  final bool zoomGesturesEnabled;

  /// ダブルタップズームの有効化
  final bool doubleClickZoomEnabled;

  /// スタイル文字列
  final String styleString;

  @override
  ConsumerState<DeclarativeMap> createState() => _DeclarativeMapState();
}

class _DeclarativeMapState extends ConsumerState<DeclarativeMap> {
  final Map<String, CachedIMapLayer> _addedLayers = {};
  // レイヤー操作のロック
  bool _isUpdatingLayers = false;

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString: widget.styleString,
      initialCameraPosition: widget.initialCameraPosition.toMapLibre(),
      onMapCreated: (controller) {
        widget.controller.setController(controller);
      },
      onStyleLoadedCallback: () {
        widget.onStyleLoadedCallback?.call();
        unawaited(
          _updateLayers(),
        );
      },
      onCameraIdle: () {
        final position = widget.controller.controller?.cameraPosition;
        if (position != null) {
          widget.onCameraIdle?.call(
            MapCameraPosition.fromMapLibre(position),
          );
        }
      },
      myLocationEnabled: widget.myLocationEnabled,
      compassEnabled: widget.compassEnabled,
      rotateGesturesEnabled: widget.rotateGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      doubleClickZoomEnabled: widget.doubleClickZoomEnabled,
      myLocationRenderMode: widget.myLocationRenderMode,
      myLocationTrackingMode: widget.myLocationTrackingMode,
    );
  }

  Future<void> _updateLayers() async {
    final controller = widget.controller.controller;
    if (controller == null) {
      log('controller is null');
      return;
    }
    // ロックチェック
    if (_isUpdatingLayers) {
      return;
    }
    try {
      // ロック取得
      _isUpdatingLayers = true;

      // 削除されたレイヤーを削除
      final newLayerIds = widget.layers.map((l) => l.id).toSet();
      for (final id in _addedLayers.keys.toSet()) {
        if (!newLayerIds.contains(id)) {
          await controller.removeLayer(id);
          await controller.removeSource(_addedLayers[id]!.layer.sourceId);
          _addedLayers.remove(id);
        }
      }

      for (final layer in widget.layers) {
        if (_addedLayers.containsKey(layer.id)) {
          final cachedLayer = _addedLayers[layer.id]!;
          // レイヤーの更新
          if (cachedLayer.layer != layer) {
            // キャッシュ済みレイヤーと同じかどうか
            // style check
            final cachedLayerPropertiesHash = cachedLayer.layerPropertiesHash;
            final layerPropertiesHash = layer.layerPropertiesHash;
            log('cached $cachedLayerPropertiesHash -> $layerPropertiesHash');
            if (cachedLayerPropertiesHash != layerPropertiesHash) {
              log('layer properties changed');
              await controller.removeLayer(layer.id);
              await controller.removeSource(layer.sourceId);
              await _addLayer(layer);
              _addedLayers[layer.id] = CachedIMapLayer.fromLayer(layer);
              log('layer properties changed: ${layer.toLayerProperties().toJson()}');

              continue;
            }
            // geoJsonSource check
            final cachedGeoJsonSource = cachedLayer.geoJsonSourceHash;
            final geoJsonSource = layer.geoJsonSourceHash;
            if (cachedGeoJsonSource != geoJsonSource) {
              // update geojson
              await controller.setGeoJsonSource(
                layer.sourceId,
                layer.toGeoJsonSource(),
              );
            }
          }
        } else {
          // 新規レイヤーの追加
          await _addLayer(layer);
        }
        _addedLayers[layer.id] = CachedIMapLayer.fromLayer(layer);
      }
    } finally {
      // ロック解放
      _isUpdatingLayers = false;
    }
  }

  Future<void> _addLayer(MapLayer layer) async {
    final controller = widget.controller.controller!;
    await controller.addGeoJsonSource(
      layer.sourceId,
      layer.toGeoJsonSource(),
    );
    await controller.addLayer(
      layer.id,
      layer.sourceId,
      layer.toLayerProperties(),
    );
  }

  Future<void> _updateAllLayers() async {
    final controller = widget.controller.controller!;
    for (final layer in widget.layers) {
      await controller.removeLayer(layer.id);
      await controller.removeSource(layer.sourceId);
      await _addLayer(layer);
    }
  }

  @override
  void didUpdateWidget(DeclarativeMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.styleString != widget.styleString) {
      unawaited(
        _updateAllLayers(),
      );
    }
    if (oldWidget.layers != widget.layers) {
      unawaited(
        _updateLayers(),
      );
    }
  }
}
