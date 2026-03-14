import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor_api/export.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_telegram.g.dart';

@Riverpod(keepAlive: true)
class Eew extends _$Eew {
  @override
  AsyncValue<List<EewItemWithRelations>> build() {
    final restResult = ref.watch(_eewRestProvider);

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        log('AppLifecycleState.resumed: Refetch EEW');
        _refetchRestApi();
      }
    });

    final refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _refetchRestApi(),
    );
    ref.onDispose(refreshTimer.cancel);
    return restResult;
  }

  void _refetchRestApi() {
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      return;
    }
    talker.log('Refetch EEW');
    ref.invalidate(_eewRestProvider);
  }

  void _upsert(EewItemWithRelations item) {
    final dataView = state.value ?? [];
    final data = [...dataView];
    final rawIndex = data.indexWhere((e) => e.eventId == item.eventId);
    final index = rawIndex == -1 ? null : rawIndex;
    if (index != null) {
      final previous = data[index];
      if (previous.serialNo <= item.serialNo) {
        data[index] = item;
      }
    } else {
      data.add(item);
    }
    state = AsyncData(data);
  }

  void upsert(EewItemWithRelations eew) {
    _upsert(eew);
  }
}

@Riverpod(keepAlive: true)
Future<List<EewItemWithRelations>> _eewRest(Ref ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.eew.getV2EewLatest();
  return response.data.items;
}
