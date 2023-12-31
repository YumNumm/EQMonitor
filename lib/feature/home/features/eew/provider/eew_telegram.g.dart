// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewTelegramHash() => r'0ce98004d262083f6eb12c7e732cbcacde83d86d';

/// EEWを持つEarthquakeHistoryItem
///
/// Copied from [eewTelegram].
@ProviderFor(eewTelegram)
final eewTelegramProvider =
    AutoDisposeProvider<AsyncValue<List<EarthquakeHistoryItem>>>.internal(
  eewTelegram,
  name: r'eewTelegramProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eewTelegramHash,
  dependencies: <ProviderOrFamily>[earthquakeHistoryViewModelProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    earthquakeHistoryViewModelProvider,
    ...?earthquakeHistoryViewModelProvider.allTransitiveDependencies
  },
);

typedef EewTelegramRef
    = AutoDisposeProviderRef<AsyncValue<List<EarthquakeHistoryItem>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
