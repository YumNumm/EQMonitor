// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'api_authentication_payload.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiAuthenticationPayload)
const apiAuthenticationPayloadProvider = ApiAuthenticationPayloadProvider._();

final class ApiAuthenticationPayloadProvider
    extends
        $FunctionalProvider<
          AsyncValue<({String id, String role})>,
          ({String id, String role}),
          FutureOr<({String id, String role})>
        >
    with
        $FutureModifier<({String id, String role})>,
        $FutureProvider<({String id, String role})> {
  const ApiAuthenticationPayloadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiAuthenticationPayloadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiAuthenticationPayloadHash();

  @$internal
  @override
  $FutureProviderElement<({String id, String role})> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<({String id, String role})> create(Ref ref) {
    return apiAuthenticationPayload(ref);
  }
}

String _$apiAuthenticationPayloadHash() =>
    r'e90163fb1098b728ed25229d501a59885c224c93';
