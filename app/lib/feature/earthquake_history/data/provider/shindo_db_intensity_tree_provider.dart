import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shindo_db_intensity_tree_provider.g.dart';

/// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される
@riverpod
Future<ShindoDbIntensityTree?> shindoDbIntensityTree(
  Ref ref,
  String eventId,
) async {
  final earthquake = await ref.watch(
    earthquakeHistoryDetailsProvider(eventId).future,
  );
  final catalog = earthquake.catalog;
  if (catalog == null) {
    return null;
  }
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  return repository.buildShindoDbIntensityTree(catalog: catalog);
}
