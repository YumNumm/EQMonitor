import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_highest_provider.g.dart';

/// 全都道府県の過去最高震度一覧をキャッシュする provider。
@Riverpod(keepAlive: true)
Future<List<HighestIntensityEntry>> prefectureHighest(Ref ref) async {
  final repository = await ref.watch(intensityHighestRepositoryProvider.future);
  return repository.fetchPrefectureHighest();
}
