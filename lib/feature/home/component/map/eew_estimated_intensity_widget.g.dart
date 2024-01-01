// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_estimated_intensity_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewEstimatedIntensityListHash() =>
    r'bd70fa2cd32a529b38c62cedfa427f8c6008f5d2';

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
  dependencies: <ProviderOrFamily>[eewAliveTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewAliveTelegramProvider,
    ...?eewAliveTelegramProvider.allTransitiveDependencies
  },
);

typedef _$EewEstimatedIntensityList
    = AutoDisposeNotifier<List<(int code, JmaForecastIntensity intensity)>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
