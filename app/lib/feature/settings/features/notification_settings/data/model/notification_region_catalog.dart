import 'dart:collection';

final class NotificationCityOption {
  const NotificationCityOption({
    required this.code,
    required this.name,
    required this.kana,
  });

  final String code;
  final String name;
  final String? kana;
}

final class NotificationRegionOption {
  NotificationRegionOption({
    required this.code,
    required this.name,
    required this.kana,
    required List<NotificationCityOption> cities,
  }) : cities = UnmodifiableListView(cities);

  final String code;
  final String name;
  final String? kana;
  final List<NotificationCityOption> cities;

  NotificationCityOption? cityByCode(String code) {
    for (final city in cities) {
      if (city.code == code) {
        return city;
      }
    }
    return null;
  }
}

final class NotificationRegionCatalog {
  NotificationRegionCatalog({
    required List<NotificationRegionOption> regions,
    required List<String> unmappedCityCodes,
  }) : regions = UnmodifiableListView(regions),
       unmappedCityCodes = UnmodifiableListView(unmappedCityCodes);

  final List<NotificationRegionOption> regions;
  final List<String> unmappedCityCodes;

  NotificationRegionOption? regionByCode(String code) {
    for (final region in regions) {
      if (region.code == code) {
        return region;
      }
    }
    return null;
  }
}
