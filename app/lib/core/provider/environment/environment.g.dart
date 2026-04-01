// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'environment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(environment)
final environmentProvider = EnvironmentProvider._();

final class EnvironmentProvider
    extends
        $FunctionalProvider<
          model.Environment,
          model.Environment,
          model.Environment
        >
    with $Provider<model.Environment> {
  EnvironmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'environmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$environmentHash();

  @$internal
  @override
  $ProviderElement<model.Environment> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  model.Environment create(Ref ref) {
    return environment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(model.Environment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<model.Environment>(value),
    );
  }
}

String _$environmentHash() => r'2f61055d207fb8e2c2793ecb753d4b0c03c9d973';
