import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/map/layer/base/i_map_layer.dart';
import 'package:eqmonitor/core/map/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
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
  final List<IMapLayer> layers;

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
  final Map<String, CachedIMapLayer> _addedLayers = {};
  // レイヤー操作のロック
  bool _isUpdatingLayers = false;

  @override
  Widget build(BuildContext context) {
    // スタイルの監視
    final configurationState = ref.watch(mapConfigurationNotifierProvider);
    final configuration = configurationState.valueOrNull;

    if (configuration == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    final styleString = configuration.styleString;
    if (styleString == null) {
      throw ArgumentError('styleString is null');
    }

    return MapLibreMap(
      styleString: styleString,
      initialCameraPosition: widget.initialCameraPosition.toMapLibre(),
      onMapCreated: (controller) {
        _controller = controller;
        widget.onMapCreated?.call(controller);
      },
      onStyleLoadedCallback: () {
        widget.onStyleLoadedCallback?.call();
        unawaited(
          _updateLayers(),
        );
      },
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
    );
  }

  Future<void> _updateLayers() async {
    if (_controller == null) {
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
          await _controller!.removeLayer(id);
          await _controller!.removeSource(_addedLayers[id]!.layer.sourceId);
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
            final cachedLayerProperties = cachedLayer.layerPropertiesHash;
            final layerProperties = layer.layerPropertiesHash;
            if (cachedLayerProperties != layerProperties) {
              log('layer properties changed');
              await _controller!.removeLayer(layer.id);
              await _controller!.removeSource(layer.sourceId);
              await _addLayer(layer);
              _addedLayers[layer.id] = CachedIMapLayer.fromLayer(layer);

              continue;
            }
            // geoJsonSource check
            final cachedGeoJsonSource = cachedLayer.geoJsonSourceHash;
            final geoJsonSource = layer.geoJsonSourceHash;
            if (cachedGeoJsonSource != geoJsonSource) {
              log('geoJsonSource changed');
              // update geojson
              await _controller!.setGeoJsonSource(
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

  Future<void> _addLayer(IMapLayer layer) async {
    final controller = _controller!;
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
