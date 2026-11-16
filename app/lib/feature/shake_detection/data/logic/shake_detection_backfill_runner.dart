import 'dart:typed_data';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart' hide Result;
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

part 'shake_detection_backfill_runner.g.dart';

@riverpod
ShakeDetectionBackfillRunner shakeDetectionBackfillRunner(Ref ref) =>
    ShakeDetectionBackfillRunner(
      repository: ref.watch(kyoshinMonitorRepositoryProvider),
    );

class const ShakeDetectionBackfillRunner({
  required final KyoshinMonitorRepository repository,
}) {
  /// [coldStartAt] の直前 [seconds] 秒ぶんの画像を取得し、検知の履歴を作り直す。
  ///
  /// 取得できたフレームだけを使う。1 枚も取得できない場合や、作り直す前に
  /// 次のコールドスタートが起きた場合は `null` を返す。
  Future<List<ShakeEventSnapshot>?> run({
    required KyoshinMonitorAnalyzerIsolate analyzer,
    required KyoshinMonitorSource source,
    required RealtimeLayer layer,
    required DateTime coldStartAt,
    required int seconds,
  }) async {
    final results = await Future.wait([
      for (var second = 1; second <= seconds; second++)
        Result.capture<ShakeBackfillFrame, Exception>(() async {
          final observedAt = coldStartAt.subtract(Duration(seconds: second));
          return ShakeBackfillFrame(
            observedAt: observedAt,
            gif: Uint8List.fromList(
              await repository.fetchRealtimeImage(
                source: source,
                type: RealtimeDataType.shindo,
                layer: layer,
                dateTime: observedAt,
              ),
            ),
          );
        }),
    ]);
    final frames = [
      for (final result in results)
        if (result case Success(:final value)) value,
    ];
    if (frames.isEmpty) {
      return null;
    }
    return analyzer.backfillShakeDetection(
      ShakeBackfillRequest(coldStartAt: coldStartAt, frames: frames),
    );
  }
}
