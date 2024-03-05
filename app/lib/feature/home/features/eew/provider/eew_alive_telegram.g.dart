// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'10210952f6125eb8fd2c1c730277eaeba8e23692';

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
String _$eewAliveCheckerHash() => r'9a37a3cc06eecdcaf74ecf1e717f9f34a6761948';

/// See also [eewAliveChecker].
@ProviderFor(eewAliveChecker)
final eewAliveCheckerProvider = Provider<EewAliveChecker>.internal(
  eewAliveChecker,
  name: r'eewAliveCheckerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveCheckerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EewAliveCheckerRef = ProviderRef<EewAliveChecker>;
String _$eewAliveTelegramHash() => r'df98e3c00d6f87479476d78191b09969589176dd';

/// イベント終了していないEEW
///
/// Copied from [EewAliveTelegram].
@ProviderFor(EewAliveTelegram)
final eewAliveTelegramProvider =
    NotifierProvider<EewAliveTelegram, List<EarthquakeHistoryItem>?>.internal(
  EewAliveTelegram.new,
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

typedef _$EewAliveTelegram = Notifier<List<EarthquakeHistoryItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
