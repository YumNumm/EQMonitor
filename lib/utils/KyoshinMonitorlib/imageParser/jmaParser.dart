// ignore_for_file: library_prefixes

import 'package:eqmonitor/const/obspoints.dart';
import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart' show Color, Colors;
import 'package:get/get.dart';
import 'package:image/image.dart' as Image;
import 'package:logger/logger.dart';

import '../../../const/const.dart';
import '../../analyzedpoints.dart';

class JmaImageParser {
  final logger = Get.find<Logger>();
  final RxDouble zoomLevel = 1.0.obs;

  /// HTTP経由でGETしたImageを解析して、各観測点のリアルタイム震度を返します
  List<AnalyzedPoint> imageParser({
    required List<int> bodyBytes,
  }) {
    final toReturn = <AnalyzedPoint>[];
    Image.Image? image;
    try {
      image = Image.decodeGif(bodyBytes);
    } catch (_) {}
    if (image == null) {
      image = Image.Image(352, 400);
      logger.wtf(Exception('Decoded Gif was null'));
    }
    // 画像解析開始
    for (final obsPoint in OBSPoints) {
      final pixel32 = image.getPixelSafe(obsPoint.x, obsPoint.y);
      final analyzedPoint = _parsePoint(obsPoint: obsPoint, pixel32: pixel32);
      toReturn.add(analyzedPoint);
    }
    return toReturn;
  }

  /// 任意のPixelから`AnalyzedPoint`を計算
  AnalyzedPoint _parsePoint({
    required OBSPoint obsPoint,
    required int pixel32,
  }) {
    final rgb = _parsePixel32(pixel32: pixel32);
    final shindo = (rgb == null) ? null : _parsePixel(rgb: rgb);
    return AnalyzedPoint(
      code: obsPoint.code,
      name: obsPoint.name,
      pref: obsPoint.pref,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      x: obsPoint.x,
      y: obsPoint.y,
      color: (rgb == null)
          ? Colors.transparent
          : Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1),
      shindo: shindo,
      zoomLevel: zoomLevel.value,
    );
  }

  /// 任意のピクセルのARGB値からリアルタイム震度を返す
  double? _parsePixel({required List<int> rgb}) {
    double? tmp;
    colorMap.forEach((key, value) {
      if (key[0] == rgb[0] && key[1] == rgb[1] && key[2] == rgb[2]) {
        tmp = value;
      }
    });
    return tmp;
  }

  /// pixel32の値からARGBを算出する データがない場合は`null`
  List<int>? _parsePixel32({required int pixel32}) {
    // 16進数のカラーコード
    final hex = _abgrToArgb(pixel32).toRadixString(16);
    // hex[0,1] = a, [2,3] = r, [4,5] = g, [6.7] =b
    if (hex == '0') {
      return null;
    } else {
      final r = int.parse(hex[2] + hex[3], radix: 16);
      final g = int.parse(hex[4] + hex[5], radix: 16);
      final b = int.parse(hex[6] + hex[7], radix: 16);
      return [r, g, b];
    }
  }
}

/// ## abgrColor -> argbColorにする
int _abgrToArgb(int argbColor) {
  final r = (argbColor >> 16) & 0xFF;
  final b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
