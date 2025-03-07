import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:kyoshin_monitor_image_parser/src/exception/kyoshin_monitor_image_exception.dart';
import 'package:kyoshin_monitor_image_parser/src/model/kyoshin_monitor_observation_point.dart';
import 'package:kyoshin_monitor_image_parser/src/util/hsv_color.dart';
import 'package:meta/meta.dart';

class KyoshinMonitorImageParser {
  Future<List<KyoshinMonitorImageParseObservationResult>> parse({
    required Image image,
    required List<KyoshinMonitorObservationPoint> points,
  }) async {
    // 352x400
    if (image.width != 352 || image.height != 400) {
      throw const KyoshinImageParseInvalidImageSizeException();
    }

    final results = <KyoshinMonitorImageParseObservationResult>[];

    for (final point in points) {
      assert(point.x >= 0 && point.x < image.width, 'x is out of range');
      assert(point.y >= 0 && point.y < image.height, 'y is out of range');
      final pixel = image.getPixel(point.x, point.y);
      final hsv = HsvColor.fromRgb(pixel.r, pixel.g, pixel.b, pixel.a);
      final position = _hsvToPosition(hsv);
      if (position == null) {
        results.add(KyoshinMonitorImageParseObservationFailure(point));
      } else {
        results.add(
          KyoshinMonitorImageParseObservationSuccess(
            KyoshinMonitorObservationAnalyzedPoint(
              point: point,
              scale: position,
              r: pixel.r.toInt(),
              g: pixel.g.toInt(),
              b: pixel.b.toInt(),
            ),
          ),
        );
      }
    }

    return results;
  }

  Future<List<KyoshinMonitorImageParseObservationResult>> parseGif({
    required List<int> gifImage,
    required List<KyoshinMonitorObservationPoint> points,
  }) async {
    final image = img.decodeGif(Uint8List.fromList(gifImage));
    if (image == null) {
      throw const KyoshinImageParseInvalidGifException();
    }
    return parse(image: image, points: points);
  }

  Future<List<KyoshinMonitorImageParseObservationResult>> parseGifInIsolate(
    List<int> gifImage,
    List<KyoshinMonitorObservationPoint> points,
  ) async => Isolate.run(() => parseGif(gifImage: gifImage, points: points));

  @visibleForTesting
  double? hsvToPosition(HsvColor hsv) => _hsvToPosition(hsv);

  /// 任意のピクセルのHSV値からカラーバーのPositionを算出(0->1)
  /// ### hsv
  /// channel | full-scale value
  /// ---|---
  /// h | 360
  /// s | 100
  /// v | 100
  /// ref: https://qiita.com/NoneType1/items/a4d2cf932e20b56ca444
  double? _hsvToPosition(HsvColor hsv) {
    final h = hsv.hue / 360;
    final s = hsv.saturation;
    final v = hsv.value;
    if (s <= 0.5) {
      return null;
    }
    var p = 0.0;
    if (v > 0.1 && s > 0.75) {
      if (h > 0.1476) {
        p =
            280.31 * math.pow(h, 6) -
            916.05 * math.pow(h, 5) +
            1142.6 * math.pow(h, 4) -
            709.95 * math.pow(h, 3) +
            234.65 * math.pow(h, 2) -
            40.27 * h +
            3.2217;
      }
      if (h <= 0.1476 && h > 0.001) {
        p =
            151.4 * math.pow(h, 4) -
            49.32 * math.pow(h, 3) +
            6.753 * math.pow(h, 2) -
            2.481 * h +
            0.9033;
      }
      if (h <= 0.001) {
        p = -0.005171 * math.pow(v, 2) - 0.3282 * v + 1.2236;
      }
    }
    if (p < 0) {
      p = 0;
    }
    return p;
  }
}

sealed class KyoshinMonitorImageParseObservationResult {}

class KyoshinMonitorImageParseObservationSuccess
    implements KyoshinMonitorImageParseObservationResult {
  KyoshinMonitorImageParseObservationSuccess(this.point);

  final KyoshinMonitorObservationAnalyzedPoint point;
}

class KyoshinMonitorImageParseObservationFailure
    implements KyoshinMonitorImageParseObservationResult {
  KyoshinMonitorImageParseObservationFailure(this.point);

  final KyoshinMonitorObservationPoint point;
}
