import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_response.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_highest_repository.g.dart';

@Riverpod(keepAlive: true)
Future<IntensityHighestRepository> intensityHighestRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  final parameter = await ref.watch(jmaParameterProvider.future);
  return IntensityHighestRepository(
    earthquake: apiClient.earthquake,
    parameter: parameter.earthquake,
  );
}

class IntensityHighestRepository {
  const IntensityHighestRepository({
    required EarthquakeApiClient earthquake,
    required EarthquakeParameter parameter,
  }) : _earthquake = earthquake,
       _parameter = parameter;

  final EarthquakeApiClient _earthquake;
  final EarthquakeParameter _parameter;

  /// 全都道府県の過去最高震度一覧を取得する。
  Future<List<HighestIntensityEntry>> fetchPrefectureHighest({
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureHighest();
    return response.data.toAppResponse(parameter: _parameter).items;
  }

  /// 指定都道府県内の市区町村ごとの過去最高震度一覧を取得する。
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode, {
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureCodeCityHighest(
          code: prefectureCode,
        );
    return response.data.toAppResponse(parameter: _parameter).items;
  }
}
