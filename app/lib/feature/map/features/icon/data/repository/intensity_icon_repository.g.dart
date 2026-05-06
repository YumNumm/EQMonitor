// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(intensityIconRepository)
final intensityIconRepositoryProvider = IntensityIconRepositoryProvider._();

final class IntensityIconRepositoryProvider
    extends
        $FunctionalProvider<
          IntensityIconRepository,
          IntensityIconRepository,
          IntensityIconRepository
        >
    with $Provider<IntensityIconRepository> {
  IntensityIconRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityIconRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityIconRepositoryHash();

  @$internal
  @override
  $ProviderElement<IntensityIconRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IntensityIconRepository create(Ref ref) {
    return intensityIconRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityIconRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityIconRepository>(value),
    );
  }
}

String _$intensityIconRepositoryHash() =>
    r'29f562f4e80c51100b2559937cc010cc667b1ee5';
