import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'changelog_repository.g.dart';

@Riverpod(keepAlive: true)
ChangelogRepository changelogRepository(Ref ref) => const ChangelogRepository();

class ChangelogRepository {
  const ChangelogRepository();

  Future<api.ChangelogResponse> fetch(api.ApiClient client) async {
    final response = await client.changelog.getV1Changelog();
    return response.data;
  }
}
