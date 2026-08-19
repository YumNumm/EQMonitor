import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_map_selection_notifier.g.dart';

@riverpod
class NotificationRegionMapSelectionController
    extends _$NotificationRegionMapSelectionController {
  @override
  NotificationRegionMapSelection build() =>
      const NotificationRegionMapNationwide();

  void focusRegion(NotificationRegionOption region) {
    state = NotificationRegionMapFocused(region: region);
  }

  bool selectCity(NotificationCityOption city) {
    final current = state;
    final region = switch (current) {
      NotificationRegionMapFocused(:final region) => region,
      NotificationRegionMapCitySelected(:final region) => region,
      NotificationRegionMapNationwide() => null,
    };
    if (region == null || region.cityByCode(city.code) == null) {
      return false;
    }
    state = NotificationRegionMapCitySelected(region: region, city: city);
    return true;
  }

  void deselectCity() {
    final current = state;
    if (current is NotificationRegionMapCitySelected) {
      state = NotificationRegionMapFocused(region: current.region);
    }
  }

  void reset() {
    state = const NotificationRegionMapNationwide();
  }
}
