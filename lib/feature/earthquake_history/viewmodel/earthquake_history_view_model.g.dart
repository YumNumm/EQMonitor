// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryViewModelHash() =>
    r'aa19faefa8670f84bd5ba27a2fe02238e1ab4856';

/// See also [EarthquakeHistoryViewModel].
@ProviderFor(EarthquakeHistoryViewModel)
final earthquakeHistoryViewModelProvider = NotifierProvider<
    EarthquakeHistoryViewModel,
    AsyncValue<List<EarthquakeHistoryItem>>>.internal(
  EarthquakeHistoryViewModel.new,
  name: r'earthquakeHistoryViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryViewModelHash,
  dependencies: <ProviderOrFamily>[
    earthquakeHistoryUseCaseProvider,
    telegramWsProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    earthquakeHistoryUseCaseProvider,
    ...?earthquakeHistoryUseCaseProvider.allTransitiveDependencies,
    telegramWsProvider,
    ...?telegramWsProvider.allTransitiveDependencies
  },
);

typedef _$EarthquakeHistoryViewModel
    = Notifier<AsyncValue<List<EarthquakeHistoryItem>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
