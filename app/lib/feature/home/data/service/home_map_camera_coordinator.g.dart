// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_map_camera_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeMapCameraCoordinator)
final homeMapCameraCoordinatorProvider = HomeMapCameraCoordinatorProvider._();

final class HomeMapCameraCoordinatorProvider
    extends
        $FunctionalProvider<
          HomeMapCameraCoordinator,
          HomeMapCameraCoordinator,
          HomeMapCameraCoordinator
        >
    with $Provider<HomeMapCameraCoordinator> {
  HomeMapCameraCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeMapCameraCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeMapCameraCoordinatorHash();

  @$internal
  @override
  $ProviderElement<HomeMapCameraCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeMapCameraCoordinator create(Ref ref) {
    return homeMapCameraCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeMapCameraCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeMapCameraCoordinator>(value),
    );
  }
}

String _$homeMapCameraCoordinatorHash() =>
    r'2486f8c8745a31ca42ae4189bebfae2df97aa2a1';
