import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/changelog/data/repository/changelog_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'changelog_notifier.g.dart';

@Riverpod(keepAlive: true)
class ChangelogNotifier extends _$ChangelogNotifier {
  @override
  AsyncValue<api.ChangelogResponse?> build() => const AsyncValue.data(null);

  Future<void> fetch() async {
    state = const AsyncValue<api.ChangelogResponse?>.loading();
    final repo = await ref.read(changelogRepositoryProvider.future);
    final result = await repo.fetch();
    switch (result) {
      case Success(:final value):
        state = AsyncValue.data(value);
      case Failure(:final exception, :final stackTrace):
        state = AsyncValue.error(exception, stackTrace ?? StackTrace.current);
    }
  }
}
