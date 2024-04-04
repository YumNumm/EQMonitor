// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewAliveNormalTelegramHash() =>
    r'29da2deaf8b2611744f88585a5fa215e7c14d99a';

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

typedef EewAliveNormalTelegramRef = ProviderRef<List<EewV1>>;
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
