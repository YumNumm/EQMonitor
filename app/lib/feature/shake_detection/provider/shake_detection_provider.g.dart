// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchShakeDetectionEventsHash() =>
    r'f38c3e2f402f56379e8ee0ebb8c8eef755723690';

/// See also [_fetchShakeDetectionEvents].
@ProviderFor(_fetchShakeDetectionEvents)
final _fetchShakeDetectionEventsProvider =
    FutureProvider<List<ShakeDetectionEvent>>.internal(
      _fetchShakeDetectionEvents,
      name: r'_fetchShakeDetectionEventsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchShakeDetectionEventsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _FetchShakeDetectionEventsRef =
    FutureProviderRef<List<ShakeDetectionEvent>>;
String _$shakeDetectionHash() =>
    r'3cbc2b6a6d3312d20de99ca4512ff627577f3dcd';

/// See also [ShakeDetection].
@ProviderFor(ShakeDetection)
final shakeDetectionProvider = AsyncNotifierProvider<
  ShakeDetection,
  List<ShakeDetectionEvent>
>.internal(
  ShakeDetection.new,
  name: r'shakeDetectionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$shakeDetectionHash,
  dependencies: <ProviderOrFamily>[timeTickerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    timeTickerProvider,
    ...?timeTickerProvider.allTransitiveDependencies,
  },
);

typedef _$ShakeDetection =
    AsyncNotifier<List<ShakeDetectionEvent>>;
String _$shakeDetectionKmoniPointsMergedHash() =>
    r'a8a638bd1ec8f32ddf7250c8ce4d4bb52759d19a';

/// See also [ShakeDetectionKmoniPointsMerged].
@ProviderFor(ShakeDetectionKmoniPointsMerged)
final shakeDetectionKmoniPointsMergedProvider =
    AsyncNotifierProvider<
      ShakeDetectionKmoniPointsMerged,
      List<ShakeDetectionKmoniMergedEvent>
    >.internal(
      ShakeDetectionKmoniPointsMerged.new,
      name: r'shakeDetectionKmoniPointsMergedProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$shakeDetectionKmoniPointsMergedHash,
      dependencies: <ProviderOrFamily>[
        shakeDetectionProvider,
      ],
      allTransitiveDependencies: <ProviderOrFamily>{
        shakeDetectionProvider,
        ...?shakeDetectionProvider
            .allTransitiveDependencies,
      },
    );

typedef _$ShakeDetectionKmoniPointsMerged =
    AsyncNotifier<List<ShakeDetectionKmoniMergedEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
