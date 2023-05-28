import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/use_case/kmoni_use_case.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model_state.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_view_model.g.dart';

@Riverpod(keepAlive: true, dependencies: [kmoniUseCase])
class KmoniViewModel extends _$KmoniViewModel {
  @override
  KmoniViewModelState build() {
    _useCase = ref.watch(kmoniUseCaseProvider);
    return const KmoniViewModelState(
      isInitialized: false,
      lastUpdatedAt: null,
      delay: Duration(seconds: 1),
      analyzedPoints: null,
    );
  }

  List<KmoniObservationPoint>? _observationPoints;
  late final KmoniUseCase _useCase;

  /// 画像取得タイマー
  Timer _timer = Timer.periodic(
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

    // assetの読み込み
    state = state.copyWith(
      isInitialized: true,
    );
    // Timer開始
    // 00msになるまで待機
    final now = DateTime.now();
    final delay = Duration(
      milliseconds: 1000 - now.millisecond,
      microseconds: 1000 - now.microsecond,
    );
    await Future<void>.delayed(delay);

    _timer.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _update(),
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
      );
    } on DioError catch (e) {
      final dioError = e;
      if (dioError.response?.statusCode == 404) {
        log('404');
        state = state.copyWith(
          delay: state.delay == null
              ? const Duration(milliseconds: 200)
              : state.delay! + const Duration(milliseconds: 200),
        );
      }
    }
  }
}
