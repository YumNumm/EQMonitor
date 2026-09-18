import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';

sealed class const NotificationRegionMapSelection();

final class const NotificationRegionMapNationwide()
    extends NotificationRegionMapSelection;

final class const NotificationRegionMapFocused({
  required final NotificationRegionOption region,
}) extends NotificationRegionMapSelection;

final class const NotificationRegionMapCitySelected({
  required final NotificationRegionOption region,
  required final NotificationCityOption city,
}) extends NotificationRegionMapSelection;
