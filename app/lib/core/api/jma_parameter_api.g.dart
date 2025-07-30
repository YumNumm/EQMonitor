// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_parameter_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jmaParameterApiClient)
const jmaParameterApiClientProvider = JmaParameterApiClientProvider._();

final class JmaParameterApiClientProvider
    extends
        $FunctionalProvider<
          JmaParameterApiClient,
          JmaParameterApiClient,
          JmaParameterApiClient
        >
    with $Provider<JmaParameterApiClient> {
  const JmaParameterApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaParameterApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaParameterApiClientHash();

  @$internal
  @override
  $ProviderElement<JmaParameterApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JmaParameterApiClient create(Ref ref) {
    return jmaParameterApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JmaParameterApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JmaParameterApiClient>(value),
    );
  }
}

String _$jmaParameterApiClientHash() =>
    r'1049f167512c0194430cb0c6715bd65a7a207589';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
