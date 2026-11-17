import 'dart:collection';

final class const NotificationCityOption({
  required final String code,
  required final String name,
  required final String? kana,
});

final class NotificationRegionOption({
  required final String code,
  required final String name,
  required final String? kana,
  required List<NotificationCityOption> cities,
}) {
  final List<NotificationCityOption> cities = UnmodifiableListView(cities);

  NotificationCityOption? cityByCode(String code) {
    for (final city in cities) {
      if (city.code == code) {
        return city;
      }
    }
    return null;
  }
}

final class NotificationRegionCatalog({
  required List<NotificationRegionOption> regions,
  required List<String> unmappedCityCodes,
}) {
  final List<NotificationRegionOption> regions = UnmodifiableListView(regions);
  final List<String> unmappedCityCodes = UnmodifiableListView(
    unmappedCityCodes,
  );

  NotificationRegionOption? regionByCode(String code) {
    for (final region in regions) {
      if (region.code == code) {
        return region;
      }
    }
    return null;
  }
}
