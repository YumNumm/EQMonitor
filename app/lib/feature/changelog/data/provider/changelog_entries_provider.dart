import 'package:eqmonitor/feature/changelog/data/model/changelog_entry_model.dart';
import 'package:eqmonitor/feature/changelog/data/notifier/changelog_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'changelog_entries_provider.g.dart';

/// UI 層がドメイン型のみを参照できるよう、
/// API レスポンスをアプリ用ドメインモデルへ変換した変更履歴一覧を返す。
@riverpod
AsyncValue<List<ChangelogEntryModel>> changelogEntries(Ref ref) {
  final state = ref.watch(changelogProvider);
  return state.whenData(
    (response) =>
        response.entries.map((e) => e.toChangelogEntryModel()).toList(),
  );
}
