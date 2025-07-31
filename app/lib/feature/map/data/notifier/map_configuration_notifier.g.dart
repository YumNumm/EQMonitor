// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_configuration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(MapConfigurationNotifier)
const mapConfigurationNotifierProvider = MapConfigurationNotifierProvider._();

final class MapConfigurationNotifierProvider
    extends $AsyncNotifierProvider<MapConfigurationNotifier, MapConfiguration> {
  const MapConfigurationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapConfigurationNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapConfigurationNotifierHash();

  @$internal
  @override
  MapConfigurationNotifier create() => MapConfigurationNotifier();
}

String _$mapConfigurationNotifierHash() =>
    r'32df3d97aa64cf68e5320209bf36c4392e23582c';

abstract class _$MapConfigurationNotifier
    extends $AsyncNotifier<MapConfiguration> {
  FutureOr<MapConfiguration> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<MapConfiguration>, MapConfiguration>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MapConfiguration>, MapConfiguration>,
              AsyncValue<MapConfiguration>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
