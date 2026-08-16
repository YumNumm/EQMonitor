import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_region_catalog_builder.g.dart';

@riverpod
NotificationRegionCatalogBuilder notificationRegionCatalogBuilder(Ref ref) =>
    const NotificationRegionCatalogBuilder();

final class NotificationRegionCatalogBuilder {
  const NotificationRegionCatalogBuilder();

  NotificationRegionCatalog build({
    required JmaCodeTableParameter codeTable,
    required EarthquakeParameter earthquake,
  }) {
    final knownRegionCodes = codeTable.codeTables.areaForecastLocalEew
        .map((region) => region.code)
        .toSet();
    final regionCodeByObservationCode = {
      for (final item in codeTable.codeTables.areaInformationCity)
        item.code: item.parentAreaForecastLocalEewCode,
    };
    final citiesByRegionCode = <String, Map<String, NotificationCityOption>>{};
    final unmappedCityCodes = <String>[];

    for (final prefecture in earthquake.prefectures) {
      for (final earthquakeRegion in prefecture.regions) {
        for (final city in earthquakeRegion.cities) {
          final observationCodes = {
            city.code,
            ...city.stations.map((station) => station.code),
          };
          final regionCodes = observationCodes
              .map((code) => regionCodeByObservationCode[code])
              .whereType<String>()
              .where(knownRegionCodes.contains)
              .toSet();
          if (regionCodes.isEmpty) {
            unmappedCityCodes.add(city.code);
            continue;
          }
          final option = NotificationCityOption(
            code: city.code,
            name: city.name.ja,
            kana: city.kana,
          );
          for (final regionCode in regionCodes) {
            (citiesByRegionCode[regionCode] ??= {})[city.code] = option;
          }
        }
      }
    }

    return NotificationRegionCatalog(
      regions: codeTable.codeTables.areaForecastLocalEew
          .map(
            (region) => NotificationRegionOption(
              code: region.code,
              name: region.name.ja,
              kana: region.kana,
              cities: citiesByRegionCode[region.code]?.values.toList() ?? [],
            ),
          )
          .toList(),
      unmappedCityCodes: unmappedCityCodes,
    );
  }
}
