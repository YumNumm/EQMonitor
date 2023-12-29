// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveTelegramHash() => r'3aaa11eaa3f0424d7936ef4ef97873c4de8900e9';

/// イベント終了していないEEW
///
/// Copied from [eewAliveTelegram].
@ProviderFor(eewAliveTelegram)
final eewAliveTelegramProvider =
    AutoDisposeProvider<List<EarthquakeHistoryItem>?>.internal(
  eewAliveTelegram,
  name: r'eewAliveTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveTelegramHash,
  dependencies: <ProviderOrFamily>[eewTelegramProvider, timeTickerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewTelegramProvider,
    ...?eewTelegramProvider.allTransitiveDependencies,
    timeTickerProvider,
    ...?timeTickerProvider.allTransitiveDependencies
  },
);

typedef EewAliveTelegramRef
    = AutoDisposeProviderRef<List<EarthquakeHistoryItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
