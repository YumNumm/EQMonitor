import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_parser_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_notifier.g.dart';

@Riverpod(keepAlive: true)
class KyoshinMonitorNotifier
    extends _$KyoshinMonitorNotifier {
  @override
  Future<KyoshinMonitorState> build() async {
    // タイマーストリームを監視
    ref.listen(kyoshinMonitorTimerStreamProvider, (
      _,
      next,
    ) async {
      if (next case AsyncData(:final value)) {
        await _fetchAndAnalyzeImage(value);
      }
    });

    // 設定変更を監視
    ref.listen(kyoshinMonitorSettingsProvider, (
      previous,
      next,
    ) {
      void onSettingsChanged() =>
          state = const AsyncData(KyoshinMonitorState());

      if (previous == null) {
        return;
      }
      if (previous.realtimeDataType !=
              next.realtimeDataType ||
          previous.realtimeLayer != next.realtimeLayer) {
        onSettingsChanged();
      }
    });

    return const KyoshinMonitorState();
  }

  /// 画像を取得して解析する
  Future<void> _fetchAndAnalyzeImage(
    DateTime targetTime,
  ) async {
    // interval + 5秒遅れている場合は遅延として扱う
    final imageFetchInterval =
        ref
            .read(kyoshinMonitorSettingsProvider)
            .api
            .imageFetchInterval;
    final delay =
        imageFetchInterval + const Duration(seconds: 5);
    final isDelayed =
        targetTime.difference(DateTime.now()) > delay;

    if (state.isLoading) {
      return;
    }
    final stopwatch = Stopwatch()..start();
    state = const AsyncLoading<KyoshinMonitorState>()
        .copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final dataSource = ref.read(
        kyoshinMonitorWebApiDataSourceProvider,
      );
      final imageParser = ref.read(
        kyoshinMonitorImageParserProvider,
      );
      final points = ref.read(
        kyoshinMonitorObservationPointsProvider,
      );
      final observationPoints = ref.read(
        kyoshinObservationPointsProvider,
      );
      // 画像を取得
      final realtimeDataType =
          ref
              .read(kyoshinMonitorSettingsProvider)
              .realtimeDataType;
      final realtimeLayer =
          ref
              .read(kyoshinMonitorSettingsProvider)
              .realtimeLayer;
      final image = await dataSource.getRealtimeImageData(
        type: realtimeDataType,
        layer: realtimeLayer,
        dateTime: targetTime,
      );

      // 画像を解析
      final result = await imageParser.parseGif(
        gifImage: image,
        points: points,
      );

      final results =
          result
              .mapIndexed((index, element) {
                final point =
                    observationPoints.points[index];
                return switch (element) {
                  KyoshinMonitorImageParseObservationSuccess() =>
                    KyoshinMonitorImageParseObservationPoint(
                      point: point,
                      observation: element.point,
                    ),
                  KyoshinMonitorImageParseObservationFailure() =>
                    null,
                };
              })
              .nonNulls
              .toList();
      return KyoshinMonitorState(
        lastUpdatedAt: DateTime.now(),
        lastImageFetchTargetTime: targetTime,
        status:
            isDelayed
                ? KyoshinMonitorStatus.delayed
                : KyoshinMonitorStatus.realtime,
        currentRealtimeDataType: realtimeDataType,
        currentRealtimeLayer: realtimeLayer,
        analyzedPoints: results,
        lastImageFetchDuration: stopwatch.elapsed,
        currentImageRaw: image,
      );
    });
  }
}
