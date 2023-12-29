// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveTelegramHash() => r'e17c3dd6d88428dd5a6d0486e80eda4e84102cdf';

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
String _$eewAliveCheckerHash() => r'b0fa8533e9d43c782b141fa6e24f080e863105d6';

/// See also [eewAliveChecker].
@ProviderFor(eewAliveChecker)
final eewAliveCheckerProvider = AutoDisposeProvider<EewAliveChecker>.internal(
  eewAliveChecker,
  name: r'eewAliveCheckerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveCheckerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EewAliveCheckerRef = AutoDisposeProviderRef<EewAliveChecker>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
