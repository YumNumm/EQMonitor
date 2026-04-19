// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'nied_api_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(niedApiClient)
final niedApiClientProvider = NiedApiClientProvider._();

final class NiedApiClientProvider
    extends $FunctionalProvider<NiedApiClient, NiedApiClient, NiedApiClient>
    with $Provider<NiedApiClient> {
  NiedApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'niedApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$niedApiClientHash();

  @$internal
  @override
  $ProviderElement<NiedApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NiedApiClient create(Ref ref) {
    return niedApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NiedApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NiedApiClient>(value),
    );
  }
}

String _$niedApiClientHash() => r'd7e79068f79506136cfca4d4c9eccfda02510cbe';
