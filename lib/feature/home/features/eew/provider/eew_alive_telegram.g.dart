// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'766b0b917c342b7df80bfb30b959f517a1c0b518';

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
  dependencies: null,
  allTransitiveDependencies: null,
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
