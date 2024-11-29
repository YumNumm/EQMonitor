// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'3d5ba64b3f98437062584f49208f9898a32358f3';

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
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EewAliveNormalTelegramRef = ProviderRef<List<EewV1>>;
String _$eewAliveCheckerHash() => r'f092d121ff9d9ea2b58fb253608779403a4ce39f';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EewAliveCheckerRef = ProviderRef<EewAliveChecker>;
String _$eewAliveTelegramHash() => r'75a2a8e24ee834cde6895bc29ff84cdc69470cb7';

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
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewAliveTelegram = Notifier<List<EewV1>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
