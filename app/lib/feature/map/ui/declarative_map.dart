import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Map<String, MapLayer> _addedLayers = {};
  final Map<String, String> _addedSources = {};
  // レイヤー操作のロック
  bool _isUpdatingLayers = true;

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString: widget.styleString,
      initialCameraPosition: widget.initialCameraPosition.toMapLibre(),
      onMapCreated: (controller) {
        widget.controller.setController(controller);
      },
      onStyleLoadedCallback: () async {
        try {
          widget.onStyleLoadedCallback?.call();
          await widget.controller.addHypocenterImages();
          _isUpdatingLayers = false;
          await _updateLayers();
        } finally {
          _isUpdatingLayers = false;
        }
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
      final layersToRemove = _addedLayers.entries
          .where((entry) => !widget.layers.any((e) => e.id == entry.key))
          .toList();

      for (final entry in layersToRemove) {
        await controller.removeLayer(entry.key);
        final sourceId = entry.value.sourceId;
        if (sourceId != null) {
          await controller.removeSource(sourceId);
        }
        _addedLayers.remove(entry.key);
        _addedSources.remove(entry.value.sourceId);
      }

      for (var i = 0; i < widget.layers.length; i++) {
        final layer = widget.layers[i];
        final belowLayerId = i > 0
            ? widget.layers[i - 1].id
            : BaseLayer.areaForecastLocalELine.name;

        if (_addedLayers.containsKey(layer.id)) {
          final cachedLayer = _addedLayers[layer.id]!;
          // レイヤーの更新
          if (cachedLayer != layer) {
            final sourceId = layer.sourceId;

            final isLayerPropertiesChanged =
                cachedLayer.layerPropertiesHash != layer.layerPropertiesHash;
            final isGeoJsonSourceChanged =
                cachedLayer.geoJsonSourceHash != layer.geoJsonSourceHash &&
                    sourceId != null;
            final isFilterChanged = cachedLayer.filter != layer.filter;

            // style check
            if (isLayerPropertiesChanged) {
              final layerProperties = layer.toLayerProperties();
              if (layerProperties != null) {
                try {
                  await controller.setLayerProperties(
                    layer.id,
                    layerProperties,
                  );
                  _addedLayers[layer.id] = layer;
                } catch (e) {
                  if (e is PlatformException &&
                      e.code == 'LAYER_NOT_FOUND_ERROR') {
                    // レイヤーが見つからない場合は、レイヤーを再追加する
                    await controller.removeLayer(layer.id);
                    await _addLayer(
                      layer: layer,
                      belowLayerId: belowLayerId,
                    );
                  } else {
                    rethrow;
                  }
                }
              }
            }
            // geoJsonSource check
            if (isGeoJsonSourceChanged) {
              final geoJsonSource = layer.toGeoJsonSource();
              if (geoJsonSource != null) {
                await controller.setGeoJsonSource(
                  sourceId,
                  geoJsonSource,
                );
                _addedLayers[layer.id] = layer;
              }
            }
            // filter check
            if (isFilterChanged) {
              await controller.setFilter(
                layer.id,
                layer.filter,
              );
              _addedLayers[layer.id] = layer;
            }
          }
        } else {
          print('add layer: ${layer.id}');
          // 新規レイヤーの追加
          if (!_addedSources.containsKey(layer.sourceId)) {
            print('add source: ${layer.sourceId}');
            final sourceId = layer.sourceId;
            if (sourceId != null) {
              await _addLayer(
                layer: layer,
                belowLayerId: belowLayerId,
              );
              _addedSources[sourceId] = layer.id;
            }
          } else {
            // ソースは既に存在するので、レイヤーのみを追加
            final layerProperties = layer.toLayerProperties();
            final sourceId = layer.sourceId;
            if (layerProperties != null && sourceId != null) {
              print(
                '[ADD] layer only: ${layer.id} (source: $sourceId)',
              );
              await controller.addLayer(
                sourceId,
                layer.id,
                layerProperties,
                belowLayerId: belowLayerId,
              );
            }
          }
          _addedLayers[layer.id] = layer;
        }
      }
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
    await controller.removeLayer(layer.id);
    final sourceId = layer.sourceId;
    if (sourceId == null) {
      return;
    }
    await controller.removeSource(sourceId);
    final geoJsonSource = layer.toGeoJsonSource();
    if (geoJsonSource != null) {
      print('[ADD] geoJsonSource: $sourceId (layer: ${layer.id})');
      await controller.addGeoJsonSource(
        sourceId,
        geoJsonSource,
      );
    } else {
      print('no geoJsonSource: $sourceId');
    }
    final layerProperties = layer.toLayerProperties();
    if (layerProperties != null) {
      print('[ADD] layer: ${layer.id} (source: $sourceId)');
      await controller.removeLayer(layer.id);
      await controller.addLayer(
        sourceId,
        layer.id,
        layerProperties,
        belowLayerId: belowLayerId,
      );
    } else {
      print('no layerProperties: ${layer.id}');
    }
  }

  Future<void> _updateAllLayers() async {
    final controller = widget.controller.controller!;
    for (final layer in widget.layers) {
      await controller.removeLayer(layer.id);
      final sourceId = layer.sourceId;
      if (sourceId != null) {
        await controller.removeSource(sourceId);
      }
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
