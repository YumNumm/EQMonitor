import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:flutter/widgets.dart';
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

    ref.listen(
      appLifecycleProvider,
      (previous, next) {
        if (next == AppLifecycleState.resumed &&
            previous != null &&
            previous != AppLifecycleState.resumed) {
          ref.invalidate(kyoshinMonitorProvider);
        }
      },
    );

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
          previous.requireValue.useKmoni != next.requireValue.useKmoni ||
          previous.requireValue.monitorSource !=
              next.requireValue.monitorSource) {
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
      final settings = ref.read(kyoshinMonitorSettingsProvider).requireValue;
      final realtimeDataType = settings.realtimeDataType;
      final realtimeLayer = settings.realtimeLayer;
      final monitorSource = settings.monitorSource;

      final analyzer = await ref.read(
        kyoshinMonitorAnalyzerIsolateProvider.future,
      );

      final fetchSw = Stopwatch()..start();
      final List<int> image;

      // LMoniデータソースを使うケース:
      // 1. ソースがlmoniに設定されている
      // 2. LPGMデータ種別が選択されている (LMoni専用)
      if (monitorSource == KyoshinMonitorSource.lmoni ||
          realtimeDataType.isLpgm) {
        final lpgmDataSource = ref.read(
          lpgmKyoshinMonitorWebApiDataSourceProvider,
        );
        image = await Timeline.timeSync(
          'lmoni.fetchImage',
          () async => lpgmDataSource.getRealtimeImageData(
            realtimeDataType,
            realtimeLayer,
            targetTime,
          ),
        );
      } else {
        final dataSource = ref.read(kyoshinMonitorWebApiDataSourceProvider);
        image = await Timeline.timeSync(
          'kmoni.fetchImage',
          () async => dataSource.getRealtimeImageData(
            type: realtimeDataType,
            layer: realtimeLayer,
            dateTime: targetTime,
          ),
        );
      }
      fetchSw.stop();

      final workerSw = Stopwatch()..start();
      final workerResult = await Timeline.timeSync(
        'kmoni.workerAnalyze',
        () async => analyzer.analyze(Uint8List.fromList(image)),
      );
      workerSw.stop();

      return KyoshinMonitorState(
        lastUpdatedAt: DateTime.now(),
        lastImageFetchTargetTime: targetTime,
        status: isDelayed ? .delayed : .realtime,
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
