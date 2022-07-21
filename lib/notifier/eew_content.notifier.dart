import 'dart:async';

import 'package:eqmonitor/api/svir.dart';
import 'package:eqmonitor/model/eew.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';

import '../main.dart';

class EEWNotifier extends StateNotifier<EEWModel> {
  EEWNotifier(this.isar)
      : super(
          const EEWModel(
            responses: [],
            apiFetchDuration: 1000,
          ),
        ) {
    _onInit();
  }
  final Isar isar;
  final Logger _logger = Logger();
  final SvirApi svirApi = SvirApi();

  static const String url = 'https://svir.jp/eew/data.json';

  Timer? svirTimer;

  void _onInit() {
    svirTimer = Timer.periodic(
      Duration(milliseconds: state.apiFetchDuration),
      (timer) => updateData(),
    );
    _logger.w(svirTimer?.isActive);
  }

  Future<void> updateData() async {
    _logger.i('Fetch Svir EEW');
    final res = await svirApi.getData();
    // Stateよりも古い場合には更新しない。
    if (state.responses[0].head.dateTime.isBefore(res.head.dateTime)) return;
    state.copyWith(responses: [res]);
  }

  set apiFetchDuration(Duration duration) {
    svirTimer!.cancel();
    state = state.copyWith(apiFetchDuration: duration.inMilliseconds);
    svirTimer = Timer.periodic(
      Duration(milliseconds: state.apiFetchDuration),
      (timer) => updateData(),
    );
  }
}

final EewStateNotifier = StateNotifierProvider<EEWNotifier, EEWModel>((ref) {
  return EEWNotifier(ref.watch(isarProvider));
});
