import 'dart:typed_data';

import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:flutter/services.dart';

class AssetImageCache {
  Map<JmaIntensity, Uint8List> assets = {};
  Future<void> onInit() async {
    for (final element in JmaIntensity.values) {
      final byteData =
          await rootBundle.load('assets/intensity/${element.name}.PNG');
      final data = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      assets.addAll(<JmaIntensity, Uint8List>{element: data});
      print(element.name);
    }
  }
}
