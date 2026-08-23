import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'earthquake_overlay_source_incarnation_provider.g.dart';

typedef EarthquakeOverlaySourceIncarnationFactory =
    MapSourceIncarnation Function();

@riverpod
EarthquakeOverlaySourceIncarnationFactory
earthquakeOverlaySourceIncarnationFactory(Ref ref) =>
    () => createMapSourceIncarnation(value: const Uuid().v7());

@riverpod
MapSourceIncarnation earthquakeOverlaySourceIncarnation(Ref ref) =>
    ref.watch(earthquakeOverlaySourceIncarnationFactoryProvider)();
