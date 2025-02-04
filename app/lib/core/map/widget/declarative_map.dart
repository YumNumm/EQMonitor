import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/map/controller/style_controller.dart';
import 'package:eqmonitor/core/map/layer/base/map_layer.dart';
import 'package:eqmonitor/core/map/model/camera_position.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// 宣言的なMapLibreMapのラッパー
class DeclarativeMap extends ConsumerStatefulWidget {
  const DeclarativeMap({
    required this.initialCameraPosition,
    super.key,
    this.onMapCreated,
    this.onStyleLoadedCallback,
    this.onCameraIdle,
    this.layers = const [],
    this.myLocationEnabled = false,
    this.compassEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.doubleClickZoomEnabled = true,
  });

  /// 初期カメラ位置
  final MapCameraPosition initialCameraPosition;

  /// マップ作成時のコールバック
  final void Function(MapLibreMapController)? onMapCreated;

  /// スタイル読み込み完了時のコールバック
  final void Function()? onStyleLoadedCallback;

  /// カメラ移動完了時のコールバック
  final void Function(MapCameraPosition)? onCameraIdle;

  /// レイヤーのリスト
  final List<MapLayer> layers;

  /// 現在位置の表示
  final bool myLocationEnabled;

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

  @override
  ConsumerState<DeclarativeMap> createState() => _DeclarativeMapState();
}

class _DeclarativeMapState extends ConsumerState<DeclarativeMap> {
  MapLibreMapController? _controller;
  final Map<String, MapLayer> _addedLayers = {};

  @override
  Widget build(BuildContext context) {
    // スタイルの監視
    final styleState = ref.watch(mapStyleControllerProvider);
    log('styleState: $styleState');
    final styleString = styleState.value?.styleString;

    return switch (styleString) {
      String _ => MapLibreMap(
          styleString: styleString,
          initialCameraPosition: widget.initialCameraPosition.toMapLibre(),
          onMapCreated: _onMapCreated,
          onStyleLoadedCallback: widget.onStyleLoadedCallback,
          onCameraIdle: () {
            final position = _controller?.cameraPosition;
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
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }

  Future<void> _onMapCreated(MapLibreMapController controller) async {
    _controller = controller;
    widget.onMapCreated?.call(controller);
    await _updateLayers();
  }

  Future<void> _updateLayers() async {
    if (_controller == null) {
      return;
    }

    // 削除されたレイヤーを削除
    final newLayerIds = widget.layers.map((l) => l.id).toSet();
    for (final id in _addedLayers.keys.toSet()) {
      if (!newLayerIds.contains(id)) {
        await _controller!.removeLayer(id);
        await _controller!.removeSource(_addedLayers[id]!.sourceId);
        _addedLayers.remove(id);
      }
    }

    // 新しいレイヤーを追加・更新
    for (final layer in widget.layers) {
      if (_addedLayers.containsKey(layer.id)) {
        // レイヤーの更新
        if (_addedLayers[layer.id] != layer) {
          await _controller!.removeLayer(layer.id);
          await _controller!.removeSource(layer.sourceId);
          await _addLayer(layer);
        }
      } else {
        // 新規レイヤーの追加
        await _addLayer(layer);
      }
      _addedLayers[layer.id] = layer;
    }
  }

  Future<void> _addLayer(MapLayer layer) async {
    final controller = _controller!;
    await controller.addGeoJsonSource(
      layer.sourceId,
      layer.toSource(),
    );
    await controller.addLayer(
      layer.id,
      layer.sourceId,
      layer.toLayer(),
    );
  }

  @override
  void didUpdateWidget(DeclarativeMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.layers != widget.layers) {
      unawaited(
        _updateLayers(),
      );
    }
  }
}
