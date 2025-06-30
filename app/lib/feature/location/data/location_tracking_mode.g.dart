// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'location_tracking_mode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocationTrackingMode)
const locationTrackingModeProvider = LocationTrackingModeProvider._();

final class LocationTrackingModeProvider
    extends $NotifierProvider<LocationTrackingMode, bool> {
  const LocationTrackingModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationTrackingModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationTrackingModeHash();

  @$internal
  @override
  LocationTrackingMode create() => LocationTrackingMode();

  @$internal
  @override
  $NotifierProviderElement<LocationTrackingMode, bool> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<bool>(value),
    );
  }
}

String _$locationTrackingModeHash() =>
    r'8ad1dc68a71bc2c4324e184080a68ee6be3aacae';

abstract class _$LocationTrackingMode extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
