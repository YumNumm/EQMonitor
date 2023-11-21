// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryUseCaseHash() =>
    r'5a9c502ff25ef642d8a20e47e85e960040b0e340';

/// See also [earthquakeHistoryUseCase].
@ProviderFor(earthquakeHistoryUseCase)
final earthquakeHistoryUseCaseProvider =
    Provider<EarthquakeHistoryUseCase>.internal(
  earthquakeHistoryUseCase,
  name: r'earthquakeHistoryUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryUseCaseHash,
  dependencies: <ProviderOrFamily>[telegramHistoryDataSourceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    telegramHistoryDataSourceProvider,
    ...?telegramHistoryDataSourceProvider.allTransitiveDependencies
  },
);

typedef EarthquakeHistoryUseCaseRef = ProviderRef<EarthquakeHistoryUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
