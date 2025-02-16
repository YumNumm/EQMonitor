// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mapCameraControllerHash() =>
    r'b07505fbfa59261dfdc49dcb44d5ee4cefd27862';

/// マップのカメラ位置を制御するコントローラー
///
/// Copied from [MapCameraController].
@ProviderFor(MapCameraController)
final mapCameraControllerProvider =
    AutoDisposeNotifierProvider<
      MapCameraController,
      MapCameraPosition
    >.internal(
      MapCameraController.new,
      name: r'mapCameraControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$mapCameraControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MapCameraController =
    AutoDisposeNotifier<MapCameraPosition>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
