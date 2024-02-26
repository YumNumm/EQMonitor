// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryViewModelHash() =>
    r'd90b4963be0f06ffcd8db9b7c8c87b0c068c7f10';

/// See also [EarthquakeHistoryViewModel].
@ProviderFor(EarthquakeHistoryViewModel)
final earthquakeHistoryViewModelProvider = NotifierProvider<
    EarthquakeHistoryViewModel,
    AsyncValue<List<EarthquakeHistoryItem>>?>.internal(
  EarthquakeHistoryViewModel.new,
  name: r'earthquakeHistoryViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryViewModelHash,
  dependencies: <ProviderOrFamily>[
    telegramWsProvider,
    earthquakeHistoryUseCaseProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    telegramWsProvider,
    ...?telegramWsProvider.allTransitiveDependencies,
    earthquakeHistoryUseCaseProvider,
    ...?earthquakeHistoryUseCaseProvider.allTransitiveDependencies
  },
);

typedef _$EarthquakeHistoryViewModel
    = Notifier<AsyncValue<List<EarthquakeHistoryItem>>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
