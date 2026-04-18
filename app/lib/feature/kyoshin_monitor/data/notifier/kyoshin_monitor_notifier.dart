import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_notifier.g.dart';

@riverpod
class KyoshinMonitorNotifier extends _$KyoshinMonitorNotifier {
  @override
  Future<KyoshinMonitorState> build() async {
    // タイマーストリームを監視
    ref.listen(kyoshinMonitorTimerStreamProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        if (ref.read(kyoshinMonitorSettingsProvider).requireValue.useKmoni) {
          await _fetchAndAnalyzeImage(value);
        }
      }
    });

    // 設定変更を監視
    ref.listen(kyoshinMonitorSettingsProvider, (previous, next) {
      void onSettingsChanged() =>
          state = const AsyncData(KyoshinMonitorState());

      if (previous == null) {
        return;
      }
      if (previous.requireValue.realtimeDataType !=
              next.requireValue.realtimeDataType ||
          previous.requireValue.realtimeLayer !=
              next.requireValue.realtimeLayer ||
          previous.requireValue.useKmoni != next.requireValue.useKmoni) {
        onSettingsChanged();
      }
    });

    return const KyoshinMonitorState();
  }

  /// 画像を取得して解析する
  Future<void> _fetchAndAnalyzeImage(DateTime targetTime) async {
    // interval + 5秒遅れている場合は遅延として扱う
    final imageFetchInterval = ref
        .read(kyoshinMonitorSettingsProvider)
        .requireValue
        .api
        .imageFetchInterval;
    final delay = imageFetchInterval + const Duration(seconds: 5);
    final isDelayed = targetTime.difference(DateTime.now()) > delay;

    if (state.isLoading) {
      return;
    }
    final stopwatch = Stopwatch()..start();
    state = const AsyncLoading<KyoshinMonitorState>();
    state = await AsyncValue.guard(() async {
      final dataSource = ref.read(kyoshinMonitorWebApiDataSourceProvider);
      final analyzer = await ref.read(kyoshinMonitorAnalyzerIsolateProvider.future);
      // 画像を取得
      final realtimeDataType = ref
          .read(kyoshinMonitorSettingsProvider)
          .requireValue
          .realtimeDataType;
      final realtimeLayer = ref
          .read(kyoshinMonitorSettingsProvider)
          .requireValue
          .realtimeLayer;

      final fetchSw = Stopwatch()..start();
      final image = await Timeline.timeSync(
        'kmoni.fetchImage',
        () async => dataSource.getRealtimeImageData(
          type: realtimeDataType,
          layer: realtimeLayer,
          dateTime: targetTime,
        ),
        flow: Flow.begin(),
      );
      fetchSw.stop();

      final workerSw = Stopwatch()..start();
      final workerResult = await Timeline.timeSync(
        'kmoni.workerAnalyze',
        () async => analyzer.analyze(Uint8List.fromList(image)),
      );
      workerSw.stop();

      talker.logCustom(
        KyoshinMonitorLog(
          '[perf] fetch=${fetchSw.elapsedMilliseconds}ms '
          'workerAnalyze=${workerSw.elapsedMilliseconds}ms '
          'parseMicros=${workerResult.parseMicros} '
          'geoBuildMicros=${workerResult.geoJsonBuildMicros} '
          'total=${stopwatch.elapsedMilliseconds}ms '
          'features=${workerResult.featureCount} imageBytes=${image.length}',
        ),
      );

      return KyoshinMonitorState(
        lastUpdatedAt: DateTime.now(),
        lastImageFetchTargetTime: targetTime,
        status: isDelayed
            ? KyoshinMonitorStatus.delayed
            : KyoshinMonitorStatus.realtime,
        currentRealtimeDataType: realtimeDataType,
        currentRealtimeLayer: realtimeLayer,
        geoJson: workerResult.geoJson,
        analyzedPointsCount: workerResult.featureCount,
        lastImageFetchDuration: stopwatch.elapsed,
        currentImageRaw: image,
      );
    });
  }
}
