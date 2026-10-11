// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_behavior_platform.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supportsLockScreenDisplay)
final supportsLockScreenDisplayProvider = SupportsLockScreenDisplayProvider._();

final class SupportsLockScreenDisplayProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  SupportsLockScreenDisplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportsLockScreenDisplayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportsLockScreenDisplayHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return supportsLockScreenDisplay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$supportsLockScreenDisplayHash() =>
    r'48e4e0713e1d3c1b8a239db273e794736735b5db';
