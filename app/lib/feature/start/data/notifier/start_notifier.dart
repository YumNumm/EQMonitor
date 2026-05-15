import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/start/data/repository/start_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_notifier.g.dart';

@Riverpod(keepAlive: true)
class StartNotifier extends _$StartNotifier {
  @override
  AsyncValue<api.StartResponse?> build() => const AsyncValue.data(null);

  /// バックグラウンドでStart APIを取得し、stateを更新する。
  /// エラーは無視し、キャッシュがあればそれを使う。
  Future<void> fetchInBackground() async {
    final repo = await ref.read(startRepositoryProvider.future);
    final result = await repo.fetch();
    switch (result) {
      case Success(:final value):
        state = AsyncValue.data(value);
      case Failure():
        // キャッシュも取れなかった場合のみ失敗状態にする
        if (state.value == null) {
          state = const AsyncValue.data(null);
        }
    }
  }

  /// 強制的に再取得する（デバッグ用など）。
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchInBackground();
  }
}
