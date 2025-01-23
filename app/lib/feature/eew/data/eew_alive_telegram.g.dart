// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'ee0e8fc7b4db6455d819f9cd4d0295347c8e3dac';

/// イベント終了していないEEWのうち、精度が低いものを除外したもの
///
/// Copied from [eewAliveNormalTelegram].
@ProviderFor(eewAliveNormalTelegram)
final eewAliveNormalTelegramProvider = Provider<List<EewV1>>.internal(
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EewAliveNormalTelegramRef = ProviderRef<List<EewV1>>;
String _$eewAliveCheckerHash() => r'21c8182cab2a3bb009efd938202257d2580030c9';

/// See also [eewAliveChecker].
@ProviderFor(eewAliveChecker)
final eewAliveCheckerProvider = Provider<EewAliveChecker>.internal(
  eewAliveChecker,
  name: r'eewAliveCheckerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveCheckerHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EewAliveCheckerRef = ProviderRef<EewAliveChecker>;
String _$eewAliveTelegramHash() => r'0f34793e7fbbc2dcc781d51e6bd49413e495555a';

/// イベント終了していないEEW
///
/// Copied from [EewAliveTelegram].
@ProviderFor(EewAliveTelegram)
final eewAliveTelegramProvider =
    NotifierProvider<EewAliveTelegram, List<EewV1>?>.internal(
  EewAliveTelegram.new,
  name: r'eewAliveTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewAliveTelegramHash,
  dependencies: <ProviderOrFamily>[timeTickerProvider, eewAliveCheckerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    timeTickerProvider,
    ...?timeTickerProvider.allTransitiveDependencies,
    eewAliveCheckerProvider,
    ...?eewAliveCheckerProvider.allTransitiveDependencies
  },
);

typedef _$EewAliveTelegram = Notifier<List<EewV1>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
