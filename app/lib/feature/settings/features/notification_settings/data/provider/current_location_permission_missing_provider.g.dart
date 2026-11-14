// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'current_location_permission_missing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isCurrentLocationPermissionMissing)
final isCurrentLocationPermissionMissingProvider =
    IsCurrentLocationPermissionMissingProvider._();

final class IsCurrentLocationPermissionMissingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsCurrentLocationPermissionMissingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isCurrentLocationPermissionMissingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$isCurrentLocationPermissionMissingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isCurrentLocationPermissionMissing(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isCurrentLocationPermissionMissingHash() =>
    r'f0dc28e0233caf41a1ab286b64c545434c429346';
