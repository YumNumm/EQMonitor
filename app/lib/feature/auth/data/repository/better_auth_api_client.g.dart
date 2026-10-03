// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'better_auth_api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(betterAuthApiClient)
final betterAuthApiClientProvider = BetterAuthApiClientProvider._();

final class BetterAuthApiClientProvider
    extends
        $FunctionalProvider<
          AsyncValue<BetterAuthApiClient>,
          BetterAuthApiClient,
          FutureOr<BetterAuthApiClient>
        >
    with
        $FutureModifier<BetterAuthApiClient>,
        $FutureProvider<BetterAuthApiClient> {
  BetterAuthApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'betterAuthApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$betterAuthApiClientHash();

  @$internal
  @override
  $FutureProviderElement<BetterAuthApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BetterAuthApiClient> create(Ref ref) {
    return betterAuthApiClient(ref);
  }
}

String _$betterAuthApiClientHash() =>
    r'b624df72efd1d3816eec7a1021131e8b719bfe4d';
