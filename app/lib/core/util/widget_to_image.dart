import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maplibre/maplibre.dart' show StyleController;

/// ウィジェットを PNG バイト列にレンダリングする。
///
/// maplibre の [StyleController.addImageFromWidget] と同じレンダリング
/// パイプラインを使用しており、[logicalSize] の論理サイズで描画した後、
/// [pixelRatio]（省略時は [ui.PlatformDispatcher] から取得）でスケールした
/// 物理サイズの PNG を返す。
///
/// 失敗時は `null` を返す。
Future<Uint8List?> renderWidgetToImageBytes({
  required Widget widget,
  required Size logicalSize,
  double? pixelRatio,
}) async {
  final view = ui.PlatformDispatcher.instance.views.first;
  final ratio = pixelRatio ?? view.devicePixelRatio;
  final imageSize = Size(
    logicalSize.width * ratio,
    logicalSize.height * ratio,
  );

  final rb = RepaintBoundary(
    child: MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(textDirection: TextDirection.ltr, child: widget),
    ),
  );

  final repaintBoundary = RenderRepaintBoundary();
  final renderView = RenderView(
    view: view,
    child: RenderPositionedBox(child: repaintBoundary),
    configuration: ViewConfiguration(
      physicalConstraints:
          BoxConstraints.tight(logicalSize) * view.devicePixelRatio,
      logicalConstraints: BoxConstraints.tight(logicalSize),
      devicePixelRatio: view.devicePixelRatio,
    ),
  );

  final pipelineOwner = PipelineOwner();
  final buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: rb,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final image = await repaintBoundary.toImage(
    pixelRatio: imageSize.width / logicalSize.width,
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  buildOwner.finalizeTree();

  return bytes?.buffer.asUint8List();
}
