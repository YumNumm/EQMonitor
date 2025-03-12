// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

// ignore: must_be_immutable
class MapPluginIos extends StatefulWidget {
  const MapPluginIos({
    super.key,
    this.onStyleLoaded,
    this.onCameraMoved,
    this.onMapCreated,
    required this.styleString,
  });

  final VoidCallback? onStyleLoaded;
  final VoidCallback? onCameraMoved;
  final void Function(MLNMapView)? onMapCreated;
  final String styleString;


  @override
  State<MapPluginIos> createState() => _MapPluginIosState();
}

class _MapPluginIosState extends State<MapPluginIos> {
  MLNMapView? _cachedMapView;
  late final int _mapViewId;
  MethodChannel? _methodChannel;
  final Completer<void> _styleLoadedCompleter = Completer<void>();

  MLNMapView get mapView =>
      _cachedMapView ??= MLNMapView.castFrom(
        MapLibreRegistry.getMapWithViewId_(_mapViewId) ??
            (throw Exception('Map not found for id $_mapViewId')),
      );

  @override
  void dispose() {
    _methodChannel?.setMethodCallHandler(null);
    // Completerが完了していない場合はエラーで完了させる
    if (!_styleLoadedCompleter.isCompleted) {
      _styleLoadedCompleter.completeError('Disposed before style loaded');
    }
    super.dispose();
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onStyleLoaded':
        print('Received onStyleLoaded event from native');
        if (!_styleLoadedCompleter.isCompleted) {
          _styleLoadedCompleter.complete();
        }
        widget.onStyleLoaded?.call();
        break;
      case 'onCameraMoved':
        print('Received onCameraMoved event from native');
        widget.onCameraMoved?.call();
        break;
      default:
        print('Unknown method ${call.method}');
    }
  }

  // マップのスタイル設定
  void _setupMapStyle() {
    // デバッグマスクの設定

    // 指定された範囲を表示するよう設定
    _setVisibleCoordinateBounds();

    // スタイルURLの設定
    final nsUrl = NSURL.URLWithString_(
      ("file://${widget.styleString}").toNSString(),
    );
    mapView.styleURL = nsUrl!;
    mapView.triggerRepaint();
  }

  // 座標範囲を設定するメソッド
  void _setVisibleCoordinateBounds() {
    MapHelper.setVisibleCoordinateBoundsWithMapView_bounds_padding_animated_(
      mapView,
      CoordinateBoundsStruct.

    );
  }

  // マップの初期化処理
  Future<void> _initializeMap(int id) async {
    _mapViewId = id;
    _cachedMapView = MLNMapView.castFrom(
      MapLibreRegistry.getMapWithViewId_(id) ??
          (throw Exception('Map not found for id $id')),
    );

    // MethodChannelの設定
    _methodChannel = MethodChannel('plugins.net.yumnumm.map_plugin/map_$id');
    _methodChannel!.setMethodCallHandler(_handleMethodCall);

    // スタイルの設定
    _setupMapStyle();

    // スタイルが読み込まれるまで待機
    try {
      await _styleLoadedCompleter.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Style loading timed out after 10 seconds');
        },
      );
      print('Style loaded successfully');

      // スタイルが読み込まれた後にonMapCreatedを呼び出す
      widget.onMapCreated?.call(mapView);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Style loaded successfully')),
      );
    } catch (e) {
      print('Error waiting for style to load: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: "plugins.net.yumnumm.map_plugin",
      layoutDirection: TextDirection.ltr,
      onPlatformViewCreated: _initializeMap,
    );
  }
}
