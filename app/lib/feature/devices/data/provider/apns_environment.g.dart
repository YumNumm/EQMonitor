// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'apns_environment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apnsEnvironment)
final apnsEnvironmentProvider = ApnsEnvironmentProvider._();

final class ApnsEnvironmentProvider
    extends
        $FunctionalProvider<
          api.ApnsEnvironment,
          api.ApnsEnvironment,
          api.ApnsEnvironment
        >
    with $Provider<api.ApnsEnvironment> {
  ApnsEnvironmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apnsEnvironmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apnsEnvironmentHash();

  @$internal
  @override
  $ProviderElement<api.ApnsEnvironment> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  api.ApnsEnvironment create(Ref ref) {
    return apnsEnvironment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(api.ApnsEnvironment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<api.ApnsEnvironment>(value),
    );
  }
}

String _$apnsEnvironmentHash() => r'015794bfb78fc9ce0e63ab2899fb810e2649e408';
