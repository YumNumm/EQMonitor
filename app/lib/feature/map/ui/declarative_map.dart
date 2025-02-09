import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
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
  final Map<String, CachedMapLayer> _addedLayers = {};
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
      onStyleLoadedCallback: () async {
        widget.onStyleLoadedCallback?.call();
        await widget.controller.addHypocenterImages();
        await _updateLayers();
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
      talker.error('map layer update is locked');
      return;
    }
    try {
      // ロック取得
      _isUpdatingLayers = true;

      // 削除探索
      for (final layer in _addedLayers.values) {
        if (!widget.layers.any((e) => e.id == layer.layer.id)) {
          await controller.removeLayer(layer.layer.id);
          await controller.removeSource(layer.layer.sourceId);
          _addedLayers.remove(layer.layer.id);
        }
      }

      widget.layers.forEachIndexed(
        (index, layer) async {
          final belowLayerId = index > 0 ? widget.layers[index - 1].id : null;

          if (_addedLayers.containsKey(layer.id)) {
            final cachedLayer = _addedLayers[layer.id]!;
            // レイヤーの更新
            if (cachedLayer.layer != layer) {
              final isLayerPropertiesChanged =
                  cachedLayer.layerPropertiesHash != layer.layerPropertiesHash;
              final isGeoJsonSourceChanged =
                  cachedLayer.geoJsonSourceHash != layer.geoJsonSourceHash;
              final isFilterChanged = cachedLayer.layer.filter != layer.filter;

              // style check
              if (isLayerPropertiesChanged) {
                await controller.setLayerProperties(
                  layer.id,
                  layer.toLayerProperties(),
                );
                _addedLayers[layer.id] = _addedLayers[layer.id]!.copyWith(
                  layerPropertiesHash: layer.layerPropertiesHash,
                );
              }
              // geoJsonSource check
              if (isGeoJsonSourceChanged) {
                await controller.setGeoJsonSource(
                  layer.sourceId,
                  layer.toGeoJsonSource(),
                );
                _addedLayers[layer.id] = _addedLayers[layer.id]!.copyWith(
                  geoJsonSourceHash: layer.geoJsonSourceHash,
                );
              }
              // filter check
              if (isFilterChanged) {
                await controller.setFilter(
                  layer.id,
                  layer.filter,
                );
                _addedLayers[layer.id] = _addedLayers[layer.id]!.copyWith(
                  layer: layer,
                );
              }
            }
          } else {
            print('adding new layer: ${layer.id}');
            // 新規レイヤーの追加
            await _addLayer(
              layer: layer,
              belowLayerId: belowLayerId,
            );
          }
          _addedLayers[layer.id] = CachedMapLayer.fromLayer(
            layer: layer,
            belowLayerId: belowLayerId,
          );
        },
      );
    } finally {
      // ロック解放
      _isUpdatingLayers = false;
    }
  }

  Future<void> _addLayer({
    required MapLayer layer,
    String? belowLayerId,
  }) async {
    final controller = widget.controller.controller!;
    await controller.removeSource(layer.sourceId);
    await controller.removeLayer(layer.id);
    await controller.addGeoJsonSource(
      layer.sourceId,
      layer.toGeoJsonSource(),
    );
    await controller.addLayer(
      layer.sourceId,
      layer.id,
      layer.toLayerProperties(),
      belowLayerId: belowLayerId,
    );
  }

  Future<void> _updateAllLayers() async {
    final controller = widget.controller.controller!;
    for (final layer in widget.layers) {
      await controller.removeLayer(layer.id);
      await controller.removeSource(layer.sourceId);
      _addedLayers.remove(layer.id);
    }
    await _updateLayers();
  }

  @override
  void didUpdateWidget(DeclarativeMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isUpdatingLayers) {
      talker.error('map layer update is locked');
      return;
    }
    if (widget.controller.controller == null) {
      talker.error('controller is null');
      return;
    }
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

enum DeclarativeAssets {
  normalHypocenter,
  lowPreciseHypocenter,
  ;

  String get path => switch (this) {
        normalHypocenter => Assets.images.map.normalHypocenter.path,
        lowPreciseHypocenter => Assets.images.map.lowPreciseHypocenter.path,
      };
}
