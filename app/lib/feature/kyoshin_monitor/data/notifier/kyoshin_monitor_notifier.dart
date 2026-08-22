import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
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
    final now = ref.read(appClockProvider.notifier).now();
    final isDelayed = isImageDelayed(
      now: now,
      targetTime: targetTime,
      delay: delay,
    );

    if (state.isLoading) {
      return;
    }
    final stopwatch = Stopwatch()..start();
    final previous = state.value;
    state = const AsyncLoading<KyoshinMonitorState>();
    state = await AsyncValue.guard(() async {
      final settings = ref.read(kyoshinMonitorSettingsProvider).requireValue;
      final realtimeDataType = settings.realtimeDataType;
      final realtimeLayer = settings.effectiveRealtimeLayer;
      final monitorSource = settings.effectiveMonitorSource;

      final analyzer = await ref.read(
        kyoshinMonitorAnalyzerIsolateProvider.future,
      );

      final fetchSw = Stopwatch()..start();
      final List<int> image;

      // LPGMデータ種別が選択されている場合は monitorSource に関わらず
      // LMoniになる (effectiveMonitorSource が吸収している)。
      if (monitorSource == KyoshinMonitorSource.lmoni) {
        final lpgmDataSource = ref.read(
          lpgmKyoshinMonitorWebApiDataSourceProvider,
        );
        image = await Timeline.timeSync(
          'lmoni.fetchImage',
          () async => lpgmDataSource.getRealtimeImageData(
            type: realtimeDataType,
            layer: realtimeLayer,
            dateTime: targetTime,
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

      // 取得できたので、オフセットを詰められないか試す。
      ref
          .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
          .onFetchSucceeded(
            profile: settings.delayProfile,
            targetTime: targetTime,
          );

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

    // 404 は「その時刻の画像がまだ公開されていない」というだけなので、
    // エラー表示に落とさずオフセットを調整して直前の表示を維持する。
    if (state case AsyncError(:final error)) {
      if (error is DioException && error.response?.statusCode == 404) {
        final delayProfile = ref
            .read(kyoshinMonitorSettingsProvider)
            .requireValue
            .delayProfile;
        ref
            .read(kyoshinMonitorOffsetAdjustmentProvider.notifier)
            .onFetchFailed(delayProfile);
        state = AsyncData(
          (previous ?? const KyoshinMonitorState()).copyWith(
            status: KyoshinMonitorStatus.delayed,
          ),
        );
      }
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

  /// 画像が遅延しているかどうかを判定する。
  ///
  /// [targetTime] は取得対象の時刻で、常に現在時刻([now])より過去になる。
  /// データが [delay] 以上遅れている (= `now - targetTime > delay`) 場合に
  /// 遅延とみなす。
  @visibleForTesting
  static bool isImageDelayed({
    required DateTime now,
    required DateTime targetTime,
    required Duration delay,
  }) => now.difference(targetTime) > delay;
}
