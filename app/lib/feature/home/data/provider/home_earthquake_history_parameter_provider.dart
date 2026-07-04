import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
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
  switch (home.common.earthquakeHistoryScope) {
    case HomeEarthquakeHistoryScope.nationwide:
      return const EarthquakeHistoryParameter.all(
        sortBy: .eventId,
        sortOrder: .desc,
      );
    case HomeEarthquakeHistoryScope.currentLocation:
      // Use the current stream state synchronously so that the provider
      // returns null immediately when no position is available (e.g. GPS
      // not ready, permission denied) and re-evaluates when it arrives.
      final posAsync = ref.watch(locationStreamProvider);
      final position = switch (posAsync) {
        AsyncData(:final value) => value,
        _ => null,
      };
      if (position == null) {
        return null;
      }
      // Round to 3 decimal places (~110m) to avoid re-fetching on tiny GPS fluctuations.
      final lat = (position.latitude * 1000).round() / 1000;
      final lng = (position.longitude * 1000).round() / 1000;
      final latLng = LatLng(lat, lng);
      final city = await ref.watch(
        jmaMapAreaInformationCityInsideProvider(latLng).future,
      );
      if (city == null) {
        return null;
      }
      return EarthquakeHistoryParameter.city(
        sortBy: .eventId,
        sortOrder: .desc,
        cityCode:
            city.property?.code ??
            () {
              throw Exception('city code is null');
            }(),
      );
    case HomeEarthquakeHistoryScope.custom:
      return home.common.parameter;
  }
}
