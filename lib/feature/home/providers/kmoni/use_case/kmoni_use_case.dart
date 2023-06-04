import 'dart:math';
import 'dart:typed_data';

import 'package:eqmonitor/feature/home/providers/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/data/kmoni_data_source.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/model/kmoni_maintenance_message_model.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/util/kmoni_web_api_url_generator.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/util/realtime_data_type.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as Image;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_use_case.g.dart';

@Riverpod(dependencies: [kmoniDataSource], keepAlive: true)
KmoniUseCase kmoniUseCase(KmoniUseCaseRef ref) => KmoniUseCase(
      ref.watch(kmoniDataSourceProvider),
    );

class KmoniUseCase {
  KmoniUseCase(this.dataSource);

  final KmoniDataSource dataSource;

  Future<List<AnalyzedKmoniObservationPoint>> fetchRealtimeShindo(
    DateTime dateTime, {
    required List<KmoniObservationPoint> obsPoints,
  }) async {
    final imageResponse = await dataSource.fetchRealtimeImage(
      dateTime: dateTime,
      dataType: RealtimeDataType.shindo,
      groundType: GroundType.aboveGround,
    );
    if (imageResponse.data == null) {
      throw Exception('画像取得失敗');
    }
    return _imageParse(
      picture: imageResponse.data!,
      obsPoints: obsPoints,
      type: RealtimeDataType.shindo,
    );
  }

  Future<DateTime> getLatestDataTime() async {
    return dataSource.getLatestDataTime();
  }

  Future<KmoniMaintenanceMessageModel> getMaintenanceMessage() async {
    return dataSource.getMaintenanceMessage();
  }

  List<AnalyzedKmoniObservationPoint> _imageParse({
    required List<int> picture,
    required List<KmoniObservationPoint> obsPoints,
    required RealtimeDataType type,
  }) {
    final analyzedPoints = <AnalyzedKmoniObservationPoint>[];
    final image = Image.decodeGif(
      Uint8List.fromList(picture),
    );
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
  /// [obsPoint] 観測点の位置データ
  /// [type] リアルタイム画像の種別(RealtimeDataType)
  /// [pixel32] 観測点のピクセル
  AnalyzedKmoniObservationPoint _parsePixelToAnalyzedPoint({
    required KmoniObservationPoint obsPoint,
    required RealtimeDataType type,
    required Image.Pixel pixel32,
  }) {
    // 色がない場合(対象の観測点が画像内にない場合)

    final hsv = HSVColor.fromColor(
      Color.fromARGB(
        pixel32.a.toInt(),
        pixel32.r.toInt(),
        pixel32.g.toInt(),
        pixel32.b.toInt(),
      ),
    );
    final position = _hsvToPosition(hsv);
    return AnalyzedKmoniObservationPoint(
      code: obsPoint.code,
      name: obsPoint.name,
      lat: obsPoint.lat,
      lon: obsPoint.lon,
      intensityColor: (type == RealtimeDataType.shindo && position != null)
          ? hsv.toColor()
          : null,
      intensityValue: (type == RealtimeDataType.shindo && position != null)
          ? (position * 10) - 3
          : null,
      pga: (type == RealtimeDataType.pga && position != null)
          ? pow(10, (5 * position) - 2).toDouble()
          : null,
      arv: obsPoint.arv,
      prefecture: obsPoint.prefecture,
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
}
