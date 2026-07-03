// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_configuration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapConfigurationNotifier)
final mapConfigurationProvider = MapConfigurationNotifierProvider._();

final class MapConfigurationNotifierProvider
    extends $AsyncNotifierProvider<MapConfigurationNotifier, MapConfiguration> {
  MapConfigurationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapConfigurationProvider',
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
    r'b9df3172b78904e871c2726bb977e12383789137';

abstract class _$MapConfigurationNotifier
    extends $AsyncNotifier<MapConfiguration> {
  FutureOr<MapConfiguration> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
