// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewTelegramHash() => r'02131229e453d7aa36e1d82018fcf5641c4b6e34';

/// See also [EewTelegram].
@ProviderFor(EewTelegram)
final eewTelegramProvider =
    NotifierProvider<EewTelegram, List<EarthquakeHistoryItem>>.internal(
  EewTelegram.new,
  name: r'eewTelegramProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eewTelegramHash,
  dependencies: <ProviderOrFamily>[earthquakeHistoryViewModelProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    earthquakeHistoryViewModelProvider,
    ...?earthquakeHistoryViewModelProvider.allTransitiveDependencies
  },
);

typedef _$EewTelegram = Notifier<List<EarthquakeHistoryItem>>;
String _$eewEstimatedIntensityHash() =>
    r'24b78ca4cd869b15c0f438fdc346b69130810169';

/// See also [EewEstimatedIntensity].
@ProviderFor(EewEstimatedIntensity)
final eewEstimatedIntensityProvider = NotifierProvider<EewEstimatedIntensity,
    List<(int code, JmaForecastIntensity intensity)>>.internal(
  EewEstimatedIntensity.new,
  name: r'eewEstimatedIntensityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewEstimatedIntensityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EewEstimatedIntensity
    = Notifier<List<(int code, JmaForecastIntensity intensity)>>;
String _$eewNormalTelegramHash() => r'3bb7263846a2b4c3a3f7dd77e2ea673917c4a798';

/// キャンセル報を除いた最新のEEW
///
/// Copied from [EewNormalTelegram].
@ProviderFor(EewNormalTelegram)
final eewNormalTelegramProvider = AutoDisposeNotifierProvider<EewNormalTelegram,
    List<(TelegramVxse45Body body, TelegramV3 telegram)>>.internal(
  EewNormalTelegram.new,
  name: r'eewNormalTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewNormalTelegramHash,
  dependencies: <ProviderOrFamily>[eewTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewTelegramProvider,
    ...?eewTelegramProvider.allTransitiveDependencies
  },
);

typedef _$EewNormalTelegram
    = AutoDisposeNotifier<List<(TelegramVxse45Body body, TelegramV3 telegram)>>;
String _$eewFilteredTelegramHash() =>
    r'c5cc0f4e3a22eb8c8dc36083a198daf3bb907d44';

/// レベル法・PLUM法・IPF1点のEEWを 除いた最新のEEW
///
/// Copied from [EewFilteredTelegram].
@ProviderFor(EewFilteredTelegram)
final eewFilteredTelegramProvider = AutoDisposeNotifierProvider<
    EewFilteredTelegram,
    List<(TelegramVxse45Body body, TelegramV3 telegram)>>.internal(
  EewFilteredTelegram.new,
  name: r'eewFilteredTelegramProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewFilteredTelegramHash,
  dependencies: <ProviderOrFamily>[eewNormalTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewNormalTelegramProvider,
    ...?eewNormalTelegramProvider.allTransitiveDependencies
  },
);

typedef _$EewFilteredTelegram
    = AutoDisposeNotifier<List<(TelegramVxse45Body body, TelegramV3 telegram)>>;
String _$eewEstimatedIntensityListHash() =>
    r'75e1555dc8fd05f8e62faa87cd3a3b105f6ca975';

/// EEWの予想震度のリスト
///
/// Copied from [EewEstimatedIntensityList].
@ProviderFor(EewEstimatedIntensityList)
final eewEstimatedIntensityListProvider = AutoDisposeNotifierProvider<
    EewEstimatedIntensityList,
    List<(int code, JmaForecastIntensity intensity)>>.internal(
  EewEstimatedIntensityList.new,
  name: r'eewEstimatedIntensityListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eewEstimatedIntensityListHash,
  dependencies: <ProviderOrFamily>[eewNormalTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewNormalTelegramProvider,
    ...?eewNormalTelegramProvider.allTransitiveDependencies
  },
);

typedef _$EewEstimatedIntensityList
    = AutoDisposeNotifier<List<(int code, JmaForecastIntensity intensity)>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
