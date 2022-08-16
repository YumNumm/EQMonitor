import 'dart:math';

import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/const/kmoni/real_time_data_type.dart';
import 'package:eqmonitor/model/analyzed_kyoshin_kansokuten.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as image_lib;
import 'package:logger/logger.dart';

import '../../const/obspoint.dart';

class KyoshinImageParser {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

  List<AnalyzedKoshinKansokuten> imageParse({
    required List<int> picture,
    required List<KyoshinKansokuten> obsPoints,
    required RealtimeDataType type,
  }) {
    final analyzedPoints = <AnalyzedKoshinKansokuten>[];
    image_lib.Image? image;
    image = image_lib.decodeGif(picture);
    if (image == null) {
      throw Exception('Image was null');
    }

    // 画像解析開始
    for (final obsPoint in obsPoints) {
      final pixel32 = image.getPixelSafe(obsPoint.x, obsPoint.y);
      final analyzedPoint = _parsePixelToAnalyzedPoint(
        obsPoint: obsPoint,
        pixel32: pixel32,
        type: type,
      );
      analyzedPoints.add(analyzedPoint);
    }
    return analyzedPoints;
  }

  /// 任意のPixelからAnalyzedPointを生成する
  AnalyzedKoshinKansokuten _parsePixelToAnalyzedPoint({
    required KyoshinKansokuten obsPoint,
    required RealtimeDataType type,
    required int pixel32,
  }) {
    final rgb = _parsePixel32(pixel32: pixel32);
    final hsv = (rgb == null) ? null : _rgbToHsv(rgb);
    final position = (hsv == null) ? null : _hsvToPosition(hsv);
    return AnalyzedKoshinKansokuten(
      code: obsPoint.code,
      name: obsPoint.name,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      shindo: (type == RealtimeDataType.Shindo && position != null)
          ? (position * 10) - 3
          : null,
      shindoColor: (type == RealtimeDataType.Shindo && rgb != null)
          ? Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1)
          : null,
      pga: (type == RealtimeDataType.Pga && position != null)
          ? pow(10, (5 * position) - 2).toDouble()
          : null,
      pgaColor: (type == RealtimeDataType.Pga && rgb != null)
          ? Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1)
          : null,
      hadValue: position != null,
      intensity: (type == RealtimeDataType.Shindo && position != null)
          ? JmaIntensity.toJmaIntensity(
              intensity: (position * 10) - 3,
            )
          : null,
      arv: obsPoint.arv,
      pref: obsPoint.pref,
      y: obsPoint.y,
      x: obsPoint.x,
    );
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
    if (s <= 0.5) {
      return null;
    }
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

  /// ## abgrColor -> argbColorにする
  int _abgrToArgb(int argbColor) {
    final r = (argbColor >> 16) & 0xFF;
    final b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }
}
