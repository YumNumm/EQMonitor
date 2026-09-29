import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_delay_status.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_notifier.g.dart';

@riverpod
class KyoshinMonitorNotifier extends _$KyoshinMonitorNotifier {
  /// 画像解析 worker の応答を待つ上限。
  static const _workerTimeout = Duration(seconds: 6);

  @override
  Future<KyoshinMonitorState> build() async {
    // タイマーストリームを監視
    ref.listen(kyoshinMonitorTimerStreamProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        // リプレイ再生中はライブ取得を停止し、リプレイ由来のデータを表示する
        if (ref.read(appClockProvider) is ReplayTimeMode) {
          return;
        }
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
          ref.invalidate(kyoshinMonitorProvider, asReload: true);
        }
      },
    );

    // 設定変更を監視
    ref.listen(kyoshinMonitorSettingsProvider, (previous, next) {
      void onSettingsChanged() =>
          state = const AsyncData(KyoshinMonitorState());

      // 読み込み中・エラー時は requireValue が StateError になるため、
      // 前後とも値がある場合だけ比較する。
      final previousValue = previous?.value;
      final nextValue = next.value;
      if (previousValue == null || nextValue == null) {
        return;
      }
      if (previousValue.realtimeDataType != nextValue.realtimeDataType ||
          previousValue.realtimeLayer != nextValue.realtimeLayer ||
          previousValue.useKmoni != nextValue.useKmoni ||
          previousValue.monitorSource != nextValue.monitorSource) {
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
    final now = ref.read(appClockProvider.notifier).now();
    final isDelayed = ref
        .read(kyoshinMonitorImageDelayStatusProvider)
        .isDelayed(now: now, targetTime: targetTime, delay: delay);

    if (state.isLoading) {
      return;
    }
    final stopwatch = Stopwatch()..start();
    final previous = state.value;
    state = const AsyncLoading<KyoshinMonitorState>();
    final result = await AsyncValue.guard(() async {
      final settings = ref.read(kyoshinMonitorSettingsProvider).requireValue;
      final request = ref.read(kyoshinMonitorImageRequestProvider);
      final realtimeDataType = settings.realtimeDataType;
      final realtimeLayer = request.layer;
      final monitorSource = request.source;

      final analyzer = await ref.read(
        kyoshinMonitorAnalyzerIsolateProvider.future,
      );

      final fetchSw = Stopwatch()..start();
      final image = await Timeline.timeSync(
        'kmoni.fetchImage',
        () async => ref
            .read(kyoshinMonitorRepositoryProvider)
            .fetchRealtimeImage(
              source: monitorSource,
              type: realtimeDataType,
              layer: realtimeLayer,
              dateTime: targetTime,
            ),
      );
      fetchSw.stop();

      final workerSw = Stopwatch()..start();
      final workerResult = await Timeline.timeSync(
        'kmoni.workerAnalyze',
        () async {
          try {
            return await analyzer
                .analyze(
                  Uint8List.fromList(image),
                  isShindo: realtimeDataType == RealtimeDataType.shindo,
                )
                .timeout(_workerTimeout);
          } on Object catch (error) {
            // 応答しない・終了した worker は以後も応答しないため、
            // 次回の取得で起動し直す。
            if (error is TimeoutException ||
                error is KyoshinMonitorWorkerExitedException) {
              ref.invalidate(kyoshinMonitorAnalyzerIsolateProvider);
            }
            rethrow;
          }
        },
      );
      workerSw.stop();

      // 取得できたので、オフセットを詰められないか試す。
      ref
          .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
          .onFetchSucceeded(
            profile: request.delayProfile,
            targetTime: targetTime,
          );

      return KyoshinMonitorState(
        // 表示時刻は取得完了時の端末時計ではなく、画像の観測時刻とする。
        lastUpdatedAt: targetTime,
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

    switch (result) {
      // 404 は「その時刻の画像がまだ公開されていない」というだけなので、
      // エラー表示に落とさずオフセットを調整して直前の表示を維持する。
      case AsyncError(:final error)
          when error is DioException && error.response?.statusCode == 404:
        final delayProfile = ref
            .read(kyoshinMonitorImageRequestProvider)
            .delayProfile;
        ref
            .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
            .onFetchFailed(delayProfile);
        state = AsyncData(
          (previous ?? const KyoshinMonitorState()).copyWith(
            status: KyoshinMonitorStatus.delayed,
          ),
        );
      // それ以外の取得失敗でも直前の表示は AsyncError の value として残るため、
      // 「リアルタイム」のまま古い観測点を表示しないよう遅延扱いにしてから
      // エラーを反映する。
      case AsyncError() when previous != null:
        state = AsyncData(
          previous.copyWith(status: KyoshinMonitorStatus.delayed),
        );
        state = result;
      case _:
        state = result;
    }
  }

  /// リプレイ再生で解析済みの観測点 GeoJSON を表示状態へ反映する。
  void setReplay({
    required String geoJson,
    required DateTime targetTime,
    int? analyzedPointsCount,
  }) {
    state = AsyncData(
      KyoshinMonitorState(
        status: KyoshinMonitorStatus.playback,
        lastUpdatedAt: targetTime,
        lastImageFetchTargetTime: targetTime,
        geoJson: geoJson,
        analyzedPointsCount: analyzedPointsCount,
      ),
    );
  }
}
