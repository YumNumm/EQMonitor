// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'environment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(buildConfig)
final buildConfigProvider = BuildConfigProvider._();

final class BuildConfigProvider
    extends
        $FunctionalProvider<
          model.BuildConfig,
          model.BuildConfig,
          model.BuildConfig
        >
    with $Provider<model.BuildConfig> {
  BuildConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buildConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buildConfigHash();

  @$internal
  @override
  $ProviderElement<model.BuildConfig> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  model.BuildConfig create(Ref ref) {
    return buildConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(model.BuildConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<model.BuildConfig>(value),
    );
  }
}

String _$buildConfigHash() => r'2f61055d207fb8e2c2793ecb753d4b0c03c9d973';
