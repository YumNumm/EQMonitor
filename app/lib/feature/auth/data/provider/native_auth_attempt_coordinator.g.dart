// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'native_auth_attempt_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nativeAuthAttemptCoordinator)
final nativeAuthAttemptCoordinatorProvider =
    NativeAuthAttemptCoordinatorProvider._();

final class NativeAuthAttemptCoordinatorProvider
    extends
        $FunctionalProvider<
          NativeAuthAttemptCoordinator,
          NativeAuthAttemptCoordinator,
          NativeAuthAttemptCoordinator
        >
    with $Provider<NativeAuthAttemptCoordinator> {
  NativeAuthAttemptCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nativeAuthAttemptCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nativeAuthAttemptCoordinatorHash();

  @$internal
  @override
  $ProviderElement<NativeAuthAttemptCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NativeAuthAttemptCoordinator create(Ref ref) {
    return nativeAuthAttemptCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NativeAuthAttemptCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NativeAuthAttemptCoordinator>(value),
    );
  }
}

String _$nativeAuthAttemptCoordinatorHash() =>
    r'f08ea441da322f6248ed3182e38970f4766eba6d';
