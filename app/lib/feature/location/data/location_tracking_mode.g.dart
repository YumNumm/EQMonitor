// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location_tracking_mode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationTrackingMode)
final locationTrackingModeProvider = LocationTrackingModeProvider._();

final class LocationTrackingModeProvider
    extends $AsyncNotifierProvider<LocationTrackingMode, bool> {
  LocationTrackingModeProvider._()
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
}

String _$locationTrackingModeHash() =>
    r'90a91706bc15e3989dab1d917cde63681c3e5b18';

abstract class _$LocationTrackingMode extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
