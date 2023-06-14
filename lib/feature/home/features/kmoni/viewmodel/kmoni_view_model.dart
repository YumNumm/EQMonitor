import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/home/features/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/features/kmoni/model/kmoni_view_model_state.dart';
import 'package:eqmonitor/feature/home/features/kmoni/use_case/kmoni_use_case.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_view_model.g.dart';

@Riverpod(keepAlive: true, dependencies: [kmoniUseCase])
class KmoniViewModel extends _$KmoniViewModel {
  @override
  KmoniViewModelState build() {
    _useCase = ref.watch(kmoniUseCaseProvider);
    ref.listenSelf((previous, next) {
      if (previous == null) {
        return;
      }
      if (previous.analyzedPoints == next.analyzedPoints) {
        return;
      }
      return;
      log(
        next.copyWith(
          analyzedPoints: [],
        ).toString(),
        name: 'KmoniViewModel',
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

  List<KmoniObservationPoint>? _observationPoints;
  late final KmoniUseCase _useCase;

  /// 画像取得タイマー
  Timer _kmoniFetchTimer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {},
  );

  /// 時刻更新タイマー
  Timer _kmoniSyncTimer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {},
  );

  Future<void> initialize() async {
    // ファイルの読み込み
    final file = await rootBundle.loadString('assets/kmoni/kansokuten.csv');
    final lines = file.split('\n');
    final result = <KmoniObservationPoint>[];
    for (final line in lines) {
      try {
        result.add(KmoniObservationPoint.fromList(line.split(',')));
      } on Exception catch (e) {
        log('error $e');
      }
    }
    _observationPoints = result;

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
    try {
      final now = DateTime.now().subtract(state.delay ?? Duration.zero);
      final result = await _useCase.fetchRealtimeShindo(
        now,
        obsPoints: _observationPoints!,
      );
      state = state.copyWith(
        lastUpdatedAt: now,
        analyzedPoints: result,
        status: KmoniStatus.realtime,
      );
    } on DioError catch (e) {
      final dioError = e;
      if (dioError.response?.statusCode == 404) {
        log('404');
        state = state.copyWith(
          delay: state.delay == null
              ? const Duration(milliseconds: 100)
              : state.delay! + const Duration(milliseconds: 100),
          status: KmoniStatus.delay,
        );
      }
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
      // 変わるまで100msごとに取得
      while (true) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
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
      return diff;
    } catch (e) {
      log('error $e', name: 'KmoniViewModel');
      state = state.copyWith(isDelayAdjusting: false);
      rethrow;
    }
  }
}
