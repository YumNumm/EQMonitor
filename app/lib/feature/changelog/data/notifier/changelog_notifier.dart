import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/changelog/data/repository/changelog_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'changelog_notifier.g.dart';

@Riverpod(keepAlive: true)
class ChangelogNotifier extends _$ChangelogNotifier
    with CachedNotifier<api.ChangelogResponse> {
  @override
  Future<api.ChangelogResponse> build() => cachedBuild();

  @override
  Future<api.ChangelogResponse> fetch(api.ApiClient client) async {
    final repository = ref.read(changelogRepositoryProvider);
    return repository.fetch(client);
  }
}
