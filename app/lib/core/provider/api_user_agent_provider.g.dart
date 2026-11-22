// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'api_user_agent_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiUserAgent)
final apiUserAgentProvider = ApiUserAgentProvider._();

final class ApiUserAgentProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  ApiUserAgentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiUserAgentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiUserAgentHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return apiUserAgent(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$apiUserAgentHash() => r'121e03c3ffceef7a266636bf40caa8f29b073b4e';
