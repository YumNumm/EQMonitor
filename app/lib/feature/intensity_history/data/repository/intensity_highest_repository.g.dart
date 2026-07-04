// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_highest_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(intensityHighestRepository)
final intensityHighestRepositoryProvider =
    IntensityHighestRepositoryProvider._();

final class IntensityHighestRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IntensityHighestRepository>,
          IntensityHighestRepository,
          FutureOr<IntensityHighestRepository>
        >
    with
        $FutureModifier<IntensityHighestRepository>,
        $FutureProvider<IntensityHighestRepository> {
  IntensityHighestRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityHighestRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityHighestRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<IntensityHighestRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IntensityHighestRepository> create(Ref ref) {
    return intensityHighestRepository(ref);
  }
}

String _$intensityHighestRepositoryHash() =>
    r'ab5b2d4437f9a776926dd97a49b09df065e1be21';
