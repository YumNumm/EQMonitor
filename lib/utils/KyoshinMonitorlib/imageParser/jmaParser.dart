// ignore_for_file: library_prefixes

import 'dart:math';

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
    required List<int> shindoPic,
    required List<int> pgaPic,
  }) {
    final toReturn = <AnalyzedPoint>[];
    Image.Image? shindo;
    Image.Image? pga;
    try {
      shindo = Image.decodeGif(shindoPic);
      pga = Image.decodeGif(pgaPic);
    } catch (_) {}
    if (shindo == null || pga == null) {
      shindo = Image.Image(352, 400);
      pga = Image.Image(352, 400);
      logger.wtf(Exception('Decoded Gif was null'));
    }
    // 画像解析開始
    for (final obsPoint in OBSPoints) {
      final shindoPixel32 = shindo.getPixelSafe(obsPoint.x, obsPoint.y);
      final pgaPixel32 = pga.getPixelSafe(obsPoint.x, obsPoint.y);

      final analyzedPoint = _parsePoint(
        obsPoint: obsPoint,
        shindoPixel32: shindoPixel32,
        pgaPixel32: pgaPixel32,
      );
      toReturn.add(analyzedPoint);
    }
    return toReturn;
  }

  /// 任意のPixelから`AnalyzedPoint`を計算
  AnalyzedPoint _parsePoint({
    required OBSPoint obsPoint,
    required int shindoPixel32,
    required int pgaPixel32,
  }) {
    final shindoRgb = _parsePixel32(pixel32: shindoPixel32);
    final pgaRgb = _parsePixel32(pixel32: pgaPixel32);
    final pgaHsv = _rgbToHsv(pgaRgb);
    final shindo = (shindoRgb == null) ? null : _parsePixel(rgb: shindoRgb);
    final pgaPosition = _hsvToPosition(pgaHsv);
    return AnalyzedPoint(
      code: obsPoint.code,
      name: obsPoint.name,
      pref: obsPoint.pref,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      x: obsPoint.x,
      y: obsPoint.y,
      shindoColor: (shindoRgb == null)
          ? Colors.transparent
          : Color.fromRGBO(shindoRgb[0], shindoRgb[1], shindoRgb[2], 1),
      pgaColor: (pgaRgb == null)
          ? Colors.transparent
          : Color.fromRGBO(pgaRgb[0], pgaRgb[1], pgaRgb[2], 1),
      shindo: shindo,
      zoomLevel: zoomLevel.value,
      pga: (pgaPosition == null)
          ? null
          : pow(10, (5 * pgaPosition) - 2).toDouble(),
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

  /// 任意のピクセルのHSV値からカラーバーのPositionを算出(0->1)
  double? _hsvToPosition(List<double>? hsv) {
    if (hsv == null) return null;
    final h = hsv[0] / 255;
    final s = hsv[1] / 255;
    final v = hsv[2] / 255;
    final double p;
    if (v > 0.1 && s > 0.75) {
      if (h > 0.1476) {
        return 280.31 * pow(h, 6) -
            916.05 * pow(h, 5) +
            1142.6 * pow(h, 4) -
            709.95 * pow(h, 3) +
            234.65 * pow(h, 2) -
            40.27 * h +
            3.2217;
      } else if (h <= 0.1476 && h > 0.001) {
        return 151.4 * pow(h, 4) -
            49.32 * pow(h, 3) +
            6.753 * pow(h, 2) -
            2.481 * h +
            0.9033;
      } else if (h <= 0.001) {
        return -0.005171 * pow(v, 2) - 0.3282 * v + 1.2236;
      }
    }
    return 0;
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

  /// RGB値からHSV値に変換する
  /// https://www.peko-step.com/tool/hsvrgb.html の変換式を参照
  List<double>? _rgbToHsv(List<int>? rgb) {
    // hex[0,1] = a, [2,3] = r, [4,5] = g, [6.7] =b
    if (rgb == null) {
      return null;
    }
    final r = rgb[0];
    final g = rgb[1];
    final b = rgb[2];

    // 最大と最小を出す
    final maxValue = rgb.reduce(max);
    final minValue = rgb.reduce(min);

    //? 色相 H
    // 全部同じだったら色相 H =0
    final double h;
    if (r == g && g == b) {
      h = 0;
    } else if (r == maxValue) {
      // Rが最大値の場合
      h = 60 * ((g - b) / (maxValue - minValue));
    } else if (g == max) {
      // Gが最大値の場合
      h = 60 * ((b - r) / (maxValue - minValue)) + 120;
    } else {
      // Bが最大値の場合
      h = 60 * ((r - g) / (maxValue - minValue)) + 240;
    }

    //? 彩度 S
    final s = (maxValue - minValue) / maxValue;
    //? 明度 V
    final v = maxValue.toDouble();
    return [h, s, v];
  }
}

/// ## abgrColor -> argbColorにする
int _abgrToArgb(int argbColor) {
  final r = (argbColor >> 16) & 0xFF;
  final b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
