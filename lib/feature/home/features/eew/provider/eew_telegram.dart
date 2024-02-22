import 'package:eqmonitor/feature/earthquake_history_old/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history_old/viewmodel/earthquake_history_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_telegram.g.dart';

/// EEWを持つEarthquakeHistoryItem
@Riverpod(dependencies: [EarthquakeHistoryViewModel], keepAlive: true)
AsyncValue<List<EarthquakeHistoryItem>> eewTelegram(EewTelegramRef ref) {
  final state = ref.watch(earthquakeHistoryViewModelProvider);
  if (state == null) {
    return const AsyncLoading();
  }
  return switch (state) {
    AsyncData(:final List<EarthquakeHistoryItem> value) => AsyncData(
        value.where((e) => e.latestEew != null).toList(),
      ),
    AsyncError(:final error, :final stackTrace) =>
      AsyncError(error, stackTrace),
    _ => const AsyncLoading(),
  };
}

/*
class EewTelegram extends _$EewTelegram {
  @override
  List<EarthquakeHistoryItem> build() {
    /*
    ref.listen(earthquakeHistoryViewModelProvider, (previous, next) {
      for (final item in (next?.value ?? <EarthquakeHistoryItem>[])
          .where((e) => e.latestEew != null)) {
        if (_shouldShow(item)) {
          upsert(item);
        }
      }
    });

    /// 古くなったEEWを棄却するタイマー
    Timer.periodic(const Duration(seconds: 2), (_) {
      final result = state.where(_shouldShow).toList();
      if (result.length != state.length) {
        log('UPDATE EEW LIST(${result.length})');

        state = result;
      }
    });

    ref.listenSelf((previous, next) {
      log(next.toString());
    });
*/
    return [];
  }
}
*/
