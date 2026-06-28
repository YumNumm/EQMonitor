import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_intensity_list_data_source.g.dart';

@riverpod
Future<CityIntensityListDataSource> cityIntensityListDataSource(
  Ref ref,
  String cityCode,
) async {
  final repository = await ref.watch(intensityHighestRepositoryProvider.future);
  final dataSource = CityIntensityListDataSource(
    repository: repository,
    cityCode: cityCode,
  );
  ref.onDispose(dataSource.dispose);
  return dataSource;
}

class CityIntensityListDataSource
    extends GroupedDataSource<String?, String, IntensityCitySearchItem> {
  CityIntensityListDataSource({
    required IntensityHighestRepository repository,
    required String cityCode,
  }) : _repository = repository,
       _cityCode = cityCode;

  final IntensityHighestRepository _repository;
  final String _cityCode;

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(IntensityCitySearchItem value) {
    final originTime = value.earthquake.originTime;
    if (originTime == null) {
      return '不明';
    }
    return _dateFormatter.format(originTime.toLocal());
  }

  @override
  Future<LoadResult<String?, IntensityCitySearchItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, IntensityCitySearchItem>> _fetch(
    String? cursor,
  ) async {
    try {
      final limit = cursor != null ? 100 : 20;
      final page = await _repository.fetchCityIntensityList(
        cityCode: _cityCode,
        cursor: cursor,
        limit: limit,
      );
      return Success(
        page: PageData(data: page.items, appendKey: page.nextToken),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }
}
