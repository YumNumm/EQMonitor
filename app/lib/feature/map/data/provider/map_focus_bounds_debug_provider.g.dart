// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_focus_bounds_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isMapFocusBoundsDebugEnabled)
final isMapFocusBoundsDebugEnabledProvider =
    IsMapFocusBoundsDebugEnabledProvider._();

final class IsMapFocusBoundsDebugEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsMapFocusBoundsDebugEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isMapFocusBoundsDebugEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isMapFocusBoundsDebugEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isMapFocusBoundsDebugEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isMapFocusBoundsDebugEnabledHash() =>
    r'c59ae78b1450893667a7f25f2ca7b15894b60c87';
