import 'dart:async';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_details_notifier.g.dart';

@riverpod
class TsunamiDetailsNotifier extends _$TsunamiDetailsNotifier {
  Timer? _refreshTimer;
  bool _isPollingRefreshInProgress = false;

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
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (_isPollingRefreshInProgress) {
        return;
      }
      _isPollingRefreshInProgress = true;
      try {
        final tsunami = await _fetch();
        state = AsyncValue.data(tsunami);
        if (!tsunami.isActive) {
          _refreshTimer?.cancel();
        }
      } on Exception catch (error, stackTrace) {
        if (!state.hasValue) {
          state = AsyncValue.error(error, stackTrace);
        }
      } finally {
        _isPollingRefreshInProgress = false;
      }
    });
  }
}
