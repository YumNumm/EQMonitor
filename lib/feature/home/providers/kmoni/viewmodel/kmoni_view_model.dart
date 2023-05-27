import 'dart:async';

import 'package:eqmonitor/common/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model_state.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_view_model.g.dart';

@Riverpod(keepAlive: true, dependencies: [NtpState])
class KmoniViewModel extends _$KmoniViewModel {
  @override
  KmoniViewModelState build() {
    return const KmoniViewModelState(
      isInitialized: false,
      lastUpdatedAt: null,
      delay: null,
    );
  }

  List<KmoniObservationPoint>? _observationPoints;

  /// 画像取得タイマー
  final Timer _timer = Timer.periodic(
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
      } on Exception catch (_) {}
    }
    _observationPoints = result;

    // assetの読み込み
    state = state.copyWith(
      isInitialized: true,
    );
    // Timer開始
  }

  Future<void> update() async {
    // 画像取得
    // 画像更新
    // state = state.copyWith(
    //   lastUpdatedAt: DateTime.now(),
    // );
  }
}
