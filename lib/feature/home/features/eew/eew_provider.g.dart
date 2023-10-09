// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewTelegramHash() => r'44409e5097cf2769ce4da17925c554455c1e3a23';

/// See also [EewTelegram].
@ProviderFor(EewTelegram)
final eewTelegramProvider =
    NotifierProvider<EewTelegram, List<EarthquakeHistoryItem>>.internal(
  EewTelegram.new,
  name: r'eewTelegramProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eewTelegramHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewTelegram = Notifier<List<EarthquakeHistoryItem>>;
String _$eewEstimatedIntensityHash() =>
    r'24b78ca4cd869b15c0f438fdc346b69130810169';

/// See also [EewEstimatedIntensity].
@ProviderFor(EewEstimatedIntensity)
final eewEstimatedIntensityProvider = NotifierProvider<EewEstimatedIntensity,
    List<(int, JmaForecastIntensity)>>.internal(
  EewEstimatedIntensity.new,
  name: r'eewEstimatedIntensityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewEstimatedIntensityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewEstimatedIntensity = Notifier<List<(int, JmaForecastIntensity)>>;
String _$eewNormalTelegramHash() => r'92309b7a1d71db5377903ba9967b0650c6826a23';

/// キャンセル報を除いた最新のEEW
///
/// Copied from [EewNormalTelegram].
@ProviderFor(EewNormalTelegram)
final eewNormalTelegramProvider = AutoDisposeNotifierProvider<EewNormalTelegram,
    List<(TelegramVxse45Body, TelegramV3)>>.internal(
  EewNormalTelegram.new,
  name: r'eewNormalTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewNormalTelegramHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewNormalTelegram
    = AutoDisposeNotifier<List<(TelegramVxse45Body, TelegramV3)>>;
String _$eewFilteredTelegramHash() =>
    r'75e2200485f6741e50eecc129fed3b28ee47952a';

/// レベル法・PLUM法・IPF1点のEEWを 除いた最新のEEW
///
/// Copied from [EewFilteredTelegram].
@ProviderFor(EewFilteredTelegram)
final eewFilteredTelegramProvider = AutoDisposeNotifierProvider<
    EewFilteredTelegram, List<(TelegramVxse45Body, TelegramV3)>>.internal(
  EewFilteredTelegram.new,
  name: r'eewFilteredTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewFilteredTelegramHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewFilteredTelegram
    = AutoDisposeNotifier<List<(TelegramVxse45Body, TelegramV3)>>;
String _$eewEstimatedIntensityListHash() =>
    r'71b7b31417727755d6384d346dd534880e390bc4';

/// EEWの予想震度のリスト
///
/// Copied from [EewEstimatedIntensityList].
@ProviderFor(EewEstimatedIntensityList)
final eewEstimatedIntensityListProvider = AutoDisposeNotifierProvider<
    EewEstimatedIntensityList, List<(int, JmaForecastIntensity)>>.internal(
  EewEstimatedIntensityList.new,
  name: r'eewEstimatedIntensityListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewEstimatedIntensityListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewEstimatedIntensityList
    = AutoDisposeNotifier<List<(int, JmaForecastIntensity)>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
