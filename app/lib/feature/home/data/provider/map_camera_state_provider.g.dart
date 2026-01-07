// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_camera_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeMapCameraState)
final homeMapCameraStateProvider = HomeMapCameraStateProvider._();

final class HomeMapCameraStateProvider
    extends $NotifierProvider<HomeMapCameraState, MapCameraState> {
  HomeMapCameraStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeMapCameraStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeMapCameraStateHash();

  @$internal
  @override
  HomeMapCameraState create() => HomeMapCameraState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapCameraState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapCameraState>(value),
    );
  }
}

String _$homeMapCameraStateHash() =>
    r'c6fce1b63d5cebc288a9f92b4ab950b847ed927a';

abstract class _$HomeMapCameraState extends $Notifier<MapCameraState> {
  MapCameraState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MapCameraState, MapCameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapCameraState, MapCameraState>,
              MapCameraState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
