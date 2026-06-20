import 'dart:async';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_details_notifier.g.dart';

@riverpod
class TsunamiDetailsNotifier extends _$TsunamiDetailsNotifier {
  Timer? _refreshTimer;

  @override
  Future<TsunamiState> build(String tsunamiId) async {
    ref.onDispose(() => _refreshTimer?.cancel());
    final result = await _fetch();
    if (result.isActive) {
      _startPolling();
    }
    return result;
  }

  Future<TsunamiState> _fetch() async {
    final client = await ref.read(apiClientProvider.future);
    final response = await client.tsunami.getV2TsunamiTsunamiId(
      tsunamiId: tsunamiId,
    );
    return response.data;
  }

  void _startPolling() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) async {
        state = await AsyncValue.guard(() => _fetch());
        if (state case AsyncData(value: final tsunami) when !tsunami.isActive) {
          _refreshTimer?.cancel();
        }
      },
    );
  }
}
