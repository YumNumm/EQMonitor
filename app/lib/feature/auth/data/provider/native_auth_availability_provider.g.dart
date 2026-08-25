// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'native_auth_availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nativeAuthAvailability)
final nativeAuthAvailabilityProvider = NativeAuthAvailabilityProvider._();

final class NativeAuthAvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<NativeAuthAvailability>,
          NativeAuthAvailability,
          FutureOr<NativeAuthAvailability>
        >
    with
        $FutureModifier<NativeAuthAvailability>,
        $FutureProvider<NativeAuthAvailability> {
  NativeAuthAvailabilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nativeAuthAvailabilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nativeAuthAvailabilityHash();

  @$internal
  @override
  $FutureProviderElement<NativeAuthAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NativeAuthAvailability> create(Ref ref) {
    return nativeAuthAvailability(ref);
  }
}

String _$nativeAuthAvailabilityHash() =>
    r'a6123a375f1dbd07376dd66bc3f4c83b8757139b';
