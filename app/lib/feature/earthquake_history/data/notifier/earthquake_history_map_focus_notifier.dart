import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_map_focus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_map_focus_notifier.g.dart';

@riverpod
class EarthquakeHistoryMapFocus extends _$EarthquakeHistoryMapFocus {
  @override
  EarthquakeIntensityMapFocus? build(String eventId) => null;

  void select(EarthquakeIntensityMapFocus? focus) {
    state = focus;
  }
}
