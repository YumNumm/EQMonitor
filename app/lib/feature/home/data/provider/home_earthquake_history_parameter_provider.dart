import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_earthquake_history_parameter_provider.g.dart';

/// ホーム地震履歴カード用の検索パラメータ。
/// 現在地・指定地域が未設定のときは `null`。
@riverpod
Future<EarthquakeHistoryParameter?> homeEarthquakeHistoryParameter(
  Ref ref,
) async {
  final home = await ref.watch(homeConfigurationProvider.future);
  switch (home.earthquakeHistoryScope) {
    case .nationwide:
      return const EarthquakeHistoryParameter();
    case .currentLocation:
      final position = ref.watch(locationStreamProvider.select((v) => v.value));
      if (position == null) {
        return null;
      }
      final latLng = LatLng(position.latitude, position.longitude);
      final city = await ref.watch(
        jmaMapAreaInformationCityInsideProvider(latLng).future,
      );
      if (city == null) {
        return null;
      }
      return EarthquakeHistoryParameter(
        regionSearchType: RegionSearchType.city,
        regionCode: city.property?.code ?? '',
        regionName: city.property?.name.isNotEmpty == true
            ? city.property!.name
            : null,
      );
    case .designatedRegion:
      final cfg = await ref.watch(earthquakeHistoryConfigProvider.future);
      final list = cfg.list;
      final t = list.designatedRegionSearchType;
      final c = list.designatedRegionCode;
      if (t == null || c == null) {
        return null;
      }
      return EarthquakeHistoryParameter(
        regionSearchType: t,
        regionCode: c,
        regionName: list.designatedRegionName,
      );
  }
}
