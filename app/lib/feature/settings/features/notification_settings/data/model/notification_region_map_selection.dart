import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';

sealed class NotificationRegionMapSelection {
  const NotificationRegionMapSelection();
}

final class NotificationRegionMapNationwide
    extends NotificationRegionMapSelection {
  const NotificationRegionMapNationwide();
}

final class NotificationRegionMapFocused
    extends NotificationRegionMapSelection {
  const NotificationRegionMapFocused({required this.region});

  final NotificationRegionOption region;
}

final class NotificationRegionMapCitySelected
    extends NotificationRegionMapSelection {
  const NotificationRegionMapCitySelected({
    required this.region,
    required this.city,
  });

  final NotificationRegionOption region;
  final NotificationCityOption city;
}
