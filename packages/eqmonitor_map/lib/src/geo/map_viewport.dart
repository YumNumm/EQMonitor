import 'dart:ui';

import 'package:flutter/foundation.dart';

/// 描画先のviewport。frame毎に読まれるimmutable snapshotだが、`logicalSize`
/// と`devicePixelRatio`は生成時に検証が要る値であり、Freezedのfactory
/// constructorでは呼び出し前に検証を挟めない。spikeのprojection/projector
/// と同じ「factory + private const constructor」の流儀に揃え、Freezedは
/// 使わない。
@immutable
class MapViewport {
  factory MapViewport({
    required Size logicalSize,
    required double devicePixelRatio,
  }) {
    if (!logicalSize.width.isFinite ||
        !logicalSize.height.isFinite ||
        logicalSize.width <= 0 ||
        logicalSize.height <= 0) {
      throw ArgumentError.value(
        logicalSize,
        'logicalSize',
        'dimensions must be finite and positive',
      );
    }
    if (!devicePixelRatio.isFinite || devicePixelRatio <= 0) {
      throw ArgumentError.value(
        devicePixelRatio,
        'devicePixelRatio',
        'must be finite and positive',
      );
    }
    return MapViewport._(
      logicalSize: logicalSize,
      devicePixelRatio: devicePixelRatio,
    );
  }

  const MapViewport._({
    required this.logicalSize,
    required this.devicePixelRatio,
  });

  final Size logicalSize;
  final double devicePixelRatio;

  /// `width / height`。正射影行列のaspectRatio引数にそのまま渡せる。
  double get aspectRatio => logicalSize.width / logicalSize.height;

  @override
  bool operator ==(Object other) =>
      other is MapViewport &&
      other.logicalSize == logicalSize &&
      other.devicePixelRatio == devicePixelRatio;

  @override
  int get hashCode => Object.hash(logicalSize, devicePixelRatio);

  @override
  String toString() =>
      'MapViewport(logicalSize: $logicalSize, '
      'devicePixelRatio: $devicePixelRatio)';
}
