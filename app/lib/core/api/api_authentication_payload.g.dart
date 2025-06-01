// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'api_authentication_payload.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(apiAuthenticationPayload)
const apiAuthenticationPayloadProvider = ApiAuthenticationPayloadProvider._();

final class ApiAuthenticationPayloadProvider
    extends
        $FunctionalProvider<
          AsyncValue<({String id, String role})>,
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
    r'b381a5161adb22c2ec3263673d35a62839b77de9';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
