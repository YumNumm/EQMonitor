// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_wake_lock_owner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(screenWakeLockOwner)
final screenWakeLockOwnerProvider = ScreenWakeLockOwnerProvider._();

final class ScreenWakeLockOwnerProvider
    extends
        $FunctionalProvider<
          ScreenWakeLockOwner,
          ScreenWakeLockOwner,
          ScreenWakeLockOwner
        >
    with $Provider<ScreenWakeLockOwner> {
  ScreenWakeLockOwnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWakeLockOwnerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWakeLockOwnerHash();

  @$internal
  @override
  $ProviderElement<ScreenWakeLockOwner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScreenWakeLockOwner create(Ref ref) {
    return screenWakeLockOwner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenWakeLockOwner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenWakeLockOwner>(value),
    );
  }
}

String _$screenWakeLockOwnerHash() =>
    r'50cd164909b2dbc7890c507347d6c5d5e1434c0c';
