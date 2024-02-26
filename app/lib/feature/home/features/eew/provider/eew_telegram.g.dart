// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewTelegramHash() => r'85a3dddbf3d79cbedf93b209fb9dbf2cc810ff8a';

/// EEWを持つEarthquakeHistoryItem
///
/// Copied from [eewTelegram].
@ProviderFor(eewTelegram)
final eewTelegramProvider =
    Provider<AsyncValue<List<EarthquakeHistoryItem>>>.internal(
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

typedef EewTelegramRef = ProviderRef<AsyncValue<List<EarthquakeHistoryItem>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
