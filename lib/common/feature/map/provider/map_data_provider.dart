import 'package:eqmonitor/common/feature/map/data/model/state/map_data_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_data_provider.g.dart';

@Riverpod(keepAlive: true)
class MapData extends _$MapData {
  @override
  MapDataState build() => const MapDataState();

  Future<void> initialize() async {}
}
