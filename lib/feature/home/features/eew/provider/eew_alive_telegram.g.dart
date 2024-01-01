// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'5f9a2dc85fdde28fc0268b4a10e52edb332abcf1';

/// イベント終了していないEEWのうち、精度が低いものを除外したもの
///
/// Copied from [eewAliveNormalTelegram].
@ProviderFor(eewAliveNormalTelegram)
final eewAliveNormalTelegramProvider =
    AutoDisposeProvider<List<EarthquakeHistoryItem>>.internal(
  eewAliveNormalTelegram,
  name: r'eewAliveNormalTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveNormalTelegramHash,
  dependencies: <ProviderOrFamily>[eewAliveTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewAliveTelegramProvider,
    ...?eewAliveTelegramProvider.allTransitiveDependencies
  },
);

typedef EewAliveNormalTelegramRef
    = AutoDisposeProviderRef<List<EarthquakeHistoryItem>>;
String _$eewAliveTelegramHash() => r'88a24577230a7b6f3e04bdbf54a0fa5fe4803d54';

/// イベント終了していないEEW
///
/// Copied from [eewAliveTelegram].
@ProviderFor(eewAliveTelegram)
final eewAliveTelegramProvider =
    Provider<List<EarthquakeHistoryItem>?>.internal(
  eewAliveTelegram,
  name: r'eewAliveTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveTelegramHash,
  dependencies: <ProviderOrFamily>[eewTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewTelegramProvider,
    ...?eewTelegramProvider.allTransitiveDependencies
  },
);

typedef EewAliveTelegramRef = ProviderRef<List<EarthquakeHistoryItem>?>;
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
