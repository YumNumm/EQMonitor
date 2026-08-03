import 'dart:ui';

import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';

abstract interface class MapSceneRendererAdapter {
  void attach({required Size logicalSize, required double devicePixelRatio});

  void updateMesh({required SpikeMeshFrame frame});

  void setForeground({required bool isForeground});

  void requestAppResourceRebuild({required int appResourceGeneration});

  void completeAppResourceRebuild({required int appResourceGeneration});

  void detach();

  void dispose();
}
