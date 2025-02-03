import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Riverpod(keepAlive: true)
class MapConfigurationNotifier extends _$MapConfigurationNotifier {
  @override
  FutureOr<MapConfiguration> build() {
    return MapConfiguration(styleUrl: styleUrl);
  }
}
