import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_catalog_builder.g.dart';

@riverpod
NotificationRegionCatalogBuilder notificationRegionCatalogBuilder(Ref ref) =>
    const NotificationRegionCatalogBuilder();

final class const NotificationRegionCatalogBuilder() {
  NotificationRegionCatalog build({
    required EarthquakeParameter earthquake,
  }) => NotificationRegionCatalog(
    // EEW予報・地震情報の通知判定は、どちらもAreaForecastLocalEを使う。
    regions: [
      for (final prefecture in earthquake.prefectures)
        for (final region in prefecture.regions)
          NotificationRegionOption(
            code: region.code,
            name: region.name.ja,
            kana: region.kana,
            cities: [
              for (final city in region.cities)
                NotificationCityOption(
                  code: city.code,
                  name: city.name.ja,
                  kana: city.kana,
                ),
            ],
          ),
    ],
    unmappedCityCodes: const [],
  );
}
