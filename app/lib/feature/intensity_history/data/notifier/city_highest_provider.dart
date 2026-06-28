import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_highest_provider.g.dart';

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。
@riverpod
Future<List<HighestIntensityEntry>> cityHighest(
  Ref ref,
  String prefectureCode,
) async {
  final repository = await ref.watch(intensityHighestRepositoryProvider.future);
  return repository.fetchCityHighest(prefectureCode);
}
