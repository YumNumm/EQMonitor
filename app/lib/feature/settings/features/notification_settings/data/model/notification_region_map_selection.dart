import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';

sealed class NotificationRegionMapSelection {
  const new();
}

final class NotificationRegionMapNationwide
    extends NotificationRegionMapSelection {
  const new();
}

final class NotificationRegionMapFocused
    extends NotificationRegionMapSelection {
  const new({required this.region});

  final NotificationRegionOption region;
}

final class NotificationRegionMapCitySelected
    extends NotificationRegionMapSelection {
  const new({
    required this.region,
    required this.city,
  });

  final NotificationRegionOption region;
  final NotificationCityOption city;
}
