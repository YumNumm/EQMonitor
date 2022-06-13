// ignore_for_file: library_prefixes

import 'dart:math';

import 'package:eqmonitor/const/obspoints.dart';
import 'package:eqmonitor/model/analyzedpoints.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart' show Color, Colors;
import 'package:get/get.dart';
import 'package:image/image.dart' as Image;
import 'package:logger/logger.dart';

import '../../../../const/const.dart';

class JmaImageParser {
  final logger = Get.find<Logger>();
  final RxDouble zoomLevel = 1.0.obs;

  /// HTTP経由でGETしたImageを解析して、各観測点のリアルタイム震度を返します
  List<AnalyzedPoint> imageParser({
    required List<int> shindoPic,
    required List<int> pgaPic,
    required bool isPng,
  }) {
    final toReturn = <AnalyzedPoint>[];
    Image.Image? shindo;
    Image.Image? pga;
    try {
      if (isPng) {
        shindo = Image.decodePng(shindoPic);
        pga = Image.decodeGif(pgaPic);
      } else {
        shindo = Image.decodeGif(shindoPic);
        pga = Image.decodeGif(pgaPic);
      }
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
    final shindoHsv = (shindoRgb == null) ? null : _rgbToHsv(shindoRgb);
    final pgaHsv = (pgaRgb == null) ? null : _rgbToHsv(pgaRgb);
    final shindoPosition =
        (shindoHsv == null) ? null : _hsvToPosition(shindoHsv);
    final pgaPosition = (pgaHsv == null) ? null : _hsvToPosition(pgaHsv);
    final shindo = (shindoPosition == null) ? null : (shindoPosition * 10) - 3;
    // https://qiita.com/NoneType1/items/a4d2cf932e20b56ca444
    // ### 震度
    // I = 10p-3
    // ### 最大加速度
    // PGA = 10^{5p-2}
    // ### 最大速度
    // PGV = 10^{5p-3}
    // ### 最大変位
    // PGD = 10^{5p-4}
    //
    return AnalyzedPoint(
      code: obsPoint.code,
      name: obsPoint.name,
      pref: obsPoint.pref,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      x: obsPoint.x,
      y: obsPoint.y,
      pointType: PointType.Observer,
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
      intensity: JmaIntensityExtensions.toJmaIntensity(intensity: shindo),
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
  /// ### hsv
  /// channel | full-scale value
  /// ---|---
  /// h | 360
  /// s | 100
  /// v | 100

  double? _hsvToPosition(List<double> hsv) {
    final h = hsv[0] / 360;
    final s = hsv[1] / 100;
    final v = hsv[2] / 100;
    if (s <= 0.5) return null;
    var p = 0.toDouble();
    if (v > 0.1 && s > 0.75) {
      if (h > 0.1476) {
        p = 280.31 * pow(h, 6) -
            916.05 * pow(h, 5) +
            1142.6 * pow(h, 4) -
            709.95 * pow(h, 3) +
            234.65 * pow(h, 2) -
            40.27 * h +
            3.2217;
      }

      if (h <= 0.1476 && h > 0.001) {
        p = 151.4 * pow(h, 4) -
            49.32 * pow(h, 3) +
            6.753 * pow(h, 2) -
            2.481 * h +
            0.9033;
      }

      if (h <= 0.001) {
        p = -0.005171 * pow(v, 2) - 0.3282 * v + 1.2236;
      }
    }

    if (p < 0) {
      p = 0;
    }
    return p;
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
  List<double> _rgbToHsv(List<num> rgb) {
    final r = rgb[0] / 255;
    final g = rgb[1] / 255;
    final b = rgb[2] / 255;

    final min_ = min(min(r, g), b);
    final max_ = max(max(r, g), b);
    final delta = max_ - min_;
    double? h;

    if (max_ == min_) {
      h = 0;
    } else if (r == max_) {
      h = (g - b) / delta;
    } else if (g == max_) {
      h = 2 + (b - r) / delta;
    } else if (b == max_) {
      h = 4 + (r - g) / delta;
    }

    h = min(h! * 60, 360);

    if (h < 0) {
      h += 360;
    }

    final l = (min_ + max_) / 2;
    double s;
    if (max_ == min_) {
      s = 0;
    } else if (l <= 0.5) {
      s = delta / (max_ + min_);
    } else {
      s = delta / (2 - max_ - min_);
    }

    return [h, s * 100, l * 100];
  }
}

/// ## abgrColor -> argbColorにする
int _abgrToArgb(int argbColor) {
  final r = (argbColor >> 16) & 0xFF;
  final b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
