import 'package:eqmonitor/feature/nied/data/provider/nied_api_client_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_seismicity_repository.g.dart';

/// ログイン失敗時に送出する例外。
class HinetLoginException implements Exception {
  const HinetLoginException();

  @override
  String toString() => 'Hi-net へのログインに失敗しました';
}

/// [HinetSeismicityRepository.fetch] の結果。
class HinetSeismicityFetchResult {
  const HinetSeismicityFetchResult({
    required this.events,
    required this.skippedLineCount,
  });

  final List<SeismicityEvent> events;
  final int skippedLineCount;
}

@Riverpod(keepAlive: true)
HinetSeismicityRepository hinetSeismicityRepository(Ref ref) =>
    HinetSeismicityRepository(client: ref.watch(niedApiClientProvider));

class HinetSeismicityRepository {
  const HinetSeismicityRepository({required NiedApiClient client})
    : _client = client;

  final NiedApiClient _client;

  Future<HinetSeismicityFetchResult> fetch({
    required HinetCredentials credentials,
    required DateTime from,
    required DateTime to,
    void Function(HinetJmalistFetchProgress)? onProgress,
  }) async {
    final loggedIn = await _client.hinet.jmalist.login(
      userId: credentials.userId,
      password: credentials.password,
    );
    if (!loggedIn) {
      throw const HinetLoginException();
    }

    final result = await _client.hinet.jmalist.fetchRange(
      from: from,
      to: to,
      onProgress: onProgress,
    );

    return HinetSeismicityFetchResult(
      events: result.events.map((e) => e.toSeismicityEvent).toList(),
      skippedLineCount: result.skippedLineCount,
    );
  }
}
