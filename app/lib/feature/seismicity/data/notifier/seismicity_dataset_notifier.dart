import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/provider/seismicity_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seismicity_dataset_notifier.g.dart';

/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。
@Riverpod(name: 'seismicityDatasetNotifierProvider')
class SeismicityDatasetNotifier extends _$SeismicityDatasetNotifier {
  @override
  Future<SeismicityDataset> build(SeismicitySpan span) async {
    final repository = await ref.watch(seismicityRepositoryProvider.future);
    return repository.fetch(span: span);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
