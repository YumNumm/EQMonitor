import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_provider.g.dart';

@riverpod
AsyncValue<List<EarthquakeHistoryItem>> tsunamiInformation(
  TsunamiInformationRef ref,
) {
  final state = ref.watch(earthquakeHistoryViewModelProvider);
  return switch (state) {
    AsyncData(:final value) =>
      AsyncData(value.where((e) => e.tsunami != null).toList()),
    AsyncError(:final error, :final stackTrace) =>
      AsyncError(error, stackTrace),
    _ => const AsyncLoading(),
  };
}

@riverpod
AsyncValue<List<EarthquakeHistoryItem>> aliveTsunamiInformation(
  AliveTsunamiInformationRef ref,
) {
  final state = ref.watch(earthquakeHistoryViewModelProvider);
  return switch (state) {
    AsyncData(:final value) => () {
        return AsyncData(
          value
              //.where((e) => e.tsunami != null && e.tsunami!.isTsunami == true)
              .toList(),
        );
      }(),
    AsyncError(:final error, :final stackTrace) =>
      AsyncError(error, stackTrace),
    _ => const AsyncLoading(),
  };
}
