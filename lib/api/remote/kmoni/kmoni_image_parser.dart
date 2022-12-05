import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as image_lib;
import 'package:talker_flutter/talker_flutter.dart';

import '../../../model/analyzed_kyoshin_kansokuten.dart';
import '../../../schema/local/kyoshin_kansokuten.dart';
import '../../../ui/theme/jma_intensity.dart';
import 'real_time_data_type.dart';

enum ImageType { png, gif }

class KyoshinImageParser {
  KyoshinImageParser(this.talker);

  final Talker talker;

  List<AnalyzedKoshinKansokuten> imageParse({
    required List<int> picture,
    required List<KyoshinKansokuten> obsPoints,
    required RealtimeDataType type,
    required ImageType imageType,
  }) {
    final analyzedPoints = <AnalyzedKoshinKansokuten>[];
    image_lib.Image? image;
    if (imageType == ImageType.png) {
      image = image_lib.decodePng(picture);
    } else {
      image = image_lib.decodeGif(picture);
    }
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
    analyzedPoints.sort(
      (a, b) => (a.shindo ?? -10).compareTo(b.shindo ?? -10),
    );
    return analyzedPoints;
  }

  /// 任意のPixelからAnalyzedPointを生成する
  /// [obsPoint] 観測点の位置データ
  /// [type] リアルタイム画像の種別(RealtimeDataType)
  /// [pixel32] 観測点のピクセル
  AnalyzedKoshinKansokuten _parsePixelToAnalyzedPoint({
    required KyoshinKansokuten obsPoint,
    required RealtimeDataType type,
    required int pixel32,
  }) {
    final rgb = _parsePixel32(pixel32: pixel32);
    // 色がない場合(対象の観測点が画像内にない場合)
    if (rgb == null) {
      return AnalyzedKoshinKansokuten(
        code: obsPoint.code,
        name: obsPoint.name,
        lat: obsPoint.lat,
        lon: obsPoint.lon,
        arv: obsPoint.arv,
        pref: obsPoint.pref,
        y: obsPoint.y,
        x: obsPoint.x,
      );
    }
    final hsv = HSVColor.fromColor(rgb);
    final position = _hsvToPosition(hsv);
    return AnalyzedKoshinKansokuten(
      code: obsPoint.code,
      name: obsPoint.name,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      shindo: (type == RealtimeDataType.Shindo && position != null)
          ? (position * 10) - 3
          : null,
      shindoColor: (type == RealtimeDataType.Shindo) ? rgb : null,
      pga: (type == RealtimeDataType.Pga && position != null)
          ? pow(10, (5 * position) - 2).toDouble()
          : null,
      pgaColor: (type == RealtimeDataType.Pga) ? rgb : null,
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
  /// ref: https://qiita.com/NoneType1/items/a4d2cf932e20b56ca444
  double? _hsvToPosition(HSVColor hsv) {
    final h = hsv.hue / 360;
    final s = hsv.saturation;
    final v = hsv.value;
    if (s <= 0.5) {
      return null;
    }
    var p = 0.0;
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
  Color? _parsePixel32({required int pixel32}) {
    // 16進数のカラーコード
    final hex = _abgrToArgb(pixel32).toRadixString(16);
    // hex[0,1] = a, [2,3] = r, [4,5] = g, [6.7] =b
    if (hex == '0') {
      return null;
    } else {
      final r = int.parse(hex[2] + hex[3], radix: 16);
      final g = int.parse(hex[4] + hex[5], radix: 16);
      final b = int.parse(hex[6] + hex[7], radix: 16);
      return Color.fromARGB(255, r, g, b);
    }
  }

  /// ## abgrColor -> argbColorにする
  int _abgrToArgb(int argbColor) {
    final r = (argbColor >> 16) & 0xFF;
    final b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }
}
