import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_intensity_list_data_source.g.dart';

@riverpod
Future<PrefectureIntensityListDataSource> prefectureIntensityListDataSource(
  Ref ref,
  String prefectureCode,
  String prefectureName,
) async {
  final repository = await ref.watch(intensityHighestRepositoryProvider.future);
  final parameterSet = await ref.watch(parameterSetProvider.future);
  final dataSource = PrefectureIntensityListDataSource(
    repository: repository,
    prefectureCode: prefectureCode,
    prefectureName: prefectureName,
    parameter: parameterSet.earthquake,
  );
  ref.onDispose(dataSource.dispose);
  return dataSource;
}

class PrefectureIntensityListDataSource
    extends GroupedDataSource<String?, String, IntensityAreaSearchItem> {
  PrefectureIntensityListDataSource({
    required IntensityHighestRepository repository,
    required String prefectureCode,
    required String prefectureName,
    required EarthquakeParameter parameter,
  }) : _repository = repository,
       _prefectureCode = prefectureCode,
       _prefectureName = prefectureName,
       _parameter = parameter;

  final IntensityHighestRepository _repository;
  final String _prefectureCode;
  final String _prefectureName;
  final EarthquakeParameter _parameter;

  @override
  String groupBy(IntensityAreaSearchItem value) {
    final intensity = value.area.intensity;
    if (intensity == null) {
      return '震度不明';
    }
    return '震度${intensity.label}';
  }

  @override
  Future<LoadResult<String?, IntensityAreaSearchItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append() => const None(),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, IntensityAreaSearchItem>> _fetch(
    String? cursor,
  ) async {
    try {
      final page = await _repository.fetchPrefectureIntensityList(
        prefectureCode: _prefectureCode,
        prefectureName: _prefectureName,
        parameter: _parameter,
        cursor: cursor,
        limit: 10,
      );
      return Success(
        page: PageData(data: page.items),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }
}
