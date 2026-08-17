import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_history_notice_notifier.g.dart';

@riverpod
class EewHistoryNoticeShown extends _$EewHistoryNoticeShown {
  static final markShownMutation = Mutation<void>();

  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: .eewHistoryNoticeShown) ?? false;
  }

  Future<void> markShown() async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: .eewHistoryNoticeShown, value: true);
    state = const AsyncData(true);
  }
}
