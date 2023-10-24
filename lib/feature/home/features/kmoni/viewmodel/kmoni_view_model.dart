import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/features/kmoni/model/kmoni_view_model_state.dart';
import 'package:eqmonitor/feature/home/features/kmoni/use_case/kmoni_use_case.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'kmoni_view_model.g.dart';

@Riverpod(keepAlive: true)
class KmoniViewModel extends _$KmoniViewModel {
  @override
  KmoniViewModelState build() {
    _useCase = ref.watch(kmoniUseCaseProvider);
    _talker = ref.watch(talkerProvider);
    ref.listen(appLifeCycleProvider, (_, next) async {
      if (next == AppLifecycleState.resumed) {
        state = state.copyWith(
          status: KmoniStatus.none,
        );
        await syncDelayWithKmoni();
        await _update();
        return;
      }
      // 停止
      state = state.copyWith(
        status: KmoniStatus.stopped,
      );
    });
    return const KmoniViewModelState(
      isInitialized: false,
      lastUpdatedAt: null,
      delay: Duration(seconds: 1),
      analyzedPoints: null,
      status: KmoniStatus.none,
      isDelayAdjusting: false,
    );
  }

  late final KmoniUseCase _useCase;
  late final Talker _talker;

  /// 画像取得タイマー
  Timer _kmoniFetchTimer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {},
  );

  /// 時刻更新タイマー
  // ignore: unused_field
  Timer _kmoniSyncTimer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {},
  );

  Future<void> initialize() async {
    // Timer開始
    while (true) {
      try {
        await syncDelayWithKmoni();
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        log('error $e');
        await Future<void>.delayed(const Duration(milliseconds: 1000));
        continue;
      }
      break;
    }
    state = state.copyWith(
      isInitialized: true,
    );

    // 1分おきに遅延を更新
    _kmoniSyncTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => syncDelayWithKmoni(),
    );
  }

  /// 画像取得
  Future<void> _update() async {
    if (state.status == KmoniStatus.stopped ||
        !ref.read(kmoniSettingsProvider).useKmoni) {
      return;
    }
    final now = DateTime.now().subtract(state.delay ?? Duration.zero);
    // 最終更新から5秒以上経過している場合は 遅延判定
    if (state.lastUpdatedAt != null &&
        now.difference(state.lastUpdatedAt!).inSeconds > 5) {
      state = state.copyWith(
        status: KmoniStatus.delay,
      );
    }

    try {
      final result = await _useCase.fetchRealtimeShindo(
        now,
        obsPoints: ref.read(kmoniObservationPointsProvider) ?? [],
      );
      state = state.copyWith(
        lastUpdatedAt: now,
        analyzedPoints: result,
        status: KmoniStatus.realtime,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        log('404');
        state = state.copyWith(
          delay: state.delay == null
              ? const Duration(milliseconds: 100)
              : state.delay! + const Duration(milliseconds: 100),
          status: KmoniStatus.delay,
        );
      }
      log('error $e');
    }
  }

  Future<Duration> syncDelayWithKmoni() async {
    if (state.isDelayAdjusting) {
      return state.delay!;
    }
    state = state.copyWith(isDelayAdjusting: true);
    try {
      // kmoniから現在時刻を取得
      final firstDateTime = await _useCase.getLatestDataTime();
      var latestDataTime = firstDateTime;
      // 変わるまで200msごとに取得
      while (true) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        latestDataTime = await _useCase.getLatestDataTime();
        if (latestDataTime != firstDateTime) {
          break;
        }
      }
      // 現在時刻との差分を取得
      final diff = DateTime.now().difference(latestDataTime);
      // 適用
      state = state.copyWith(
        delay: diff,
        isDelayAdjusting: false,
      );
      // タイマー再起動
      _kmoniFetchTimer.cancel();
      _kmoniFetchTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _update(),
      );
      _talker.logTyped(
        KmoniLog('遅延調整を行いました ${diff.inMicroseconds / 1000}ms'),
      );
      return diff;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _talker.logTyped(
        KmoniLog('遅延調整失敗 $e'),
      );
      state = state.copyWith(isDelayAdjusting: false);
      rethrow;
    }
  }
}
