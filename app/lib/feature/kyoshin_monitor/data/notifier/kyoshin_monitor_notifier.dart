import 'dart:async';

import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_parser_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_notifier.g.dart';

@Riverpod(keepAlive: true)
class KyoshinMonitorNotifier extends _$KyoshinMonitorNotifier {
  @override
  Future<KyoshinMonitorState> build() async {
    // タイマーストリームを監視
    ref.listen(kyoshinMonitorTimerStreamProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        await _fetchAndAnalyzeImage(value);
      }
    });

    //
    ref.listen(
      kyoshinMonitorSettingsProvider,
      (previous, next) {
        void onSettingsChanged() =>
            state = const AsyncData(KyoshinMonitorState());

        if (previous == null) {
          return;
        }
        if (previous.realtimeDataType != next.realtimeDataType ||
            previous.realtimeLayer != next.realtimeLayer) {
          onSettingsChanged();
        }
      },
    );

    return const KyoshinMonitorState();
  }

  /// 画像を取得して解析する
  Future<void> _fetchAndAnalyzeImage(DateTime targetTime) async {
    // interval + 5秒遅れている場合は遅延として扱う
    final imageFetchInterval =
        ref.read(kyoshinMonitorSettingsProvider).api.imageFetchInterval;
    final delay = imageFetchInterval + const Duration(seconds: 5);
    final isDelayed = targetTime.difference(DateTime.now()) > delay;
    if (isDelayed) {}

    if (state.isLoading) {
      return;
    }
    try {
      final stopwatch = Stopwatch()..start();
      state = const AsyncLoading<KyoshinMonitorState>().copyWithPrevious(state);
      final dataSource = ref.read(kyoshinMonitorWebApiDataSourceProvider);
      final imageParser = ref.read(kyoshinMonitorImageParserProvider);
      final points = ref.read(kyoshinMonitorObservationPointsProvider);

      // 画像を取得
      final realtimeDataType =
          ref.read(kyoshinMonitorSettingsProvider).realtimeDataType;
      final realtimeLayer =
          ref.read(kyoshinMonitorSettingsProvider).realtimeLayer;
      final shindoImage = await dataSource.getRealtimeImageData(
        realtimeDataType,
        realtimeLayer,
        targetTime,
      );

      // 画像を解析
      final result = await imageParser.parseGif(
        gifImage: shindoImage,
        points: points,
      );

      state = AsyncData(
        KyoshinMonitorState(
          lastUpdatedAt: DateTime.now(),
          lastImageFetchTargetTime: targetTime,
          status: KyoshinMonitorStatus.realtime,
          currentRealtimeDataType: realtimeDataType,
          currentRealtimeLayer: realtimeLayer,
          analyzedPoints: result.successPoints,
          lastImageFetchDuration: stopwatch.elapsed,
        ),
      );
    } on Exception catch (e) {
      talker.error(e);
    }
  }
}
