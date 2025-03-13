// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

// iOS用の観測点データクラス
class ObservationPointIos {
  final String id;
  final double latitude;
  final double longitude;
  final double intensity; // 震度値
  final Color color; // 表示色

  const ObservationPointIos({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.intensity,
    required this.color,
  });

  // GeoJSONのFeatureに変換
  Map<String, dynamic> toGeoJsonFeature() {
    return {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
      'properties': {
        'id': id,
        'intensity': intensity,
        'color': '#${color.value.toRadixString(16).padLeft(8, '0')}',
      },
    };
  }
}

// ignore: must_be_immutable
class MapPluginIos extends StatefulWidget {
  const MapPluginIos({
    super.key,
    this.onStyleLoaded,
    this.onCameraMoved,
    this.onMapCreated,
    required this.styleString,
    this.observationPoints = const [],
  });

  final VoidCallback? onStyleLoaded;
  final VoidCallback? onCameraMoved;
  final void Function(MLNMapView)? onMapCreated;
  final String styleString;
  final List<ObservationPointIos> observationPoints; // 観測点データ

  @override
  State<MapPluginIos> createState() => _MapPluginIosState();
}

class _MapPluginIosState extends State<MapPluginIos> {
  MLNMapView? _cachedMapView;
  late final int _mapViewId;
  MethodChannel? _methodChannel;
  final Completer<void> _styleLoadedCompleter = Completer<void>();
  String? _observationPointsSourceId;
  String? _observationPointsLayerId;

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

  @override
  void didUpdateWidget(MapPluginIos oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 観測点データが変更された場合、マーカーを更新
    if (widget.observationPoints != oldWidget.observationPoints) {
      _updateObservationPoints();
    }
  }

  // 観測点データをマップに反映
  void _updateObservationPoints() {
    if (!_styleLoadedCompleter.isCompleted) {
      // スタイルがロードされるまで待機
      _styleLoadedCompleter.future.then((_) => _updateObservationPoints());
      return;
    }

    try {
      // MethodChannelを使用してNativeに処理を委譲
      final features =
          widget.observationPoints.map((p) => p.toGeoJsonFeature()).toList();
      final featureCollection = {
        'type': 'FeatureCollection',
        'features': features,
      };

      final jsonString = jsonEncode(featureCollection);

      // MethodChannelを通してNativeコードに観測点データを送信
      

      // IDを保存
      _observationPointsSourceId ??= 'observation_points_source';
      _observationPointsLayerId ??= 'observation_points_layer';
    } catch (e) {
      print('Error updating observation points: $e');
    }
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onStyleLoaded':
        print('Received onStyleLoaded event from native');
        if (!_styleLoadedCompleter.isCompleted) {
          _styleLoadedCompleter.complete();
          // スタイルロード完了後、観測点データを更新
          _updateObservationPoints();
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
      CoordinateBoundsStruct.new1()
        ..maxLatitude = 46.0
        ..maxLongitude = 146.0
        ..minLatitude = 24.0
        ..minLongitude = 122.0,
      PaddingStruct.new1()
        ..top = 0.0
        ..left = 0.0
        ..bottom = 0.0
        ..right = 0.0,
      false,
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Style loaded successfully')),
        );
      }
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
