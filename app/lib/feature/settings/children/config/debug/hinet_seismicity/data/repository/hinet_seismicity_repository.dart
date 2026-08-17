import 'package:eqmonitor/feature/nied/data/provider/nied_api_client_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_seismicity_repository.g.dart';

/// ログイン失敗時に送出する例外。
class HinetLoginException implements Exception {
  const new();

  @override
  String toString() => 'Hi-net へのログインに失敗しました';
}

/// [HinetSeismicityRepository.fetch] の結果。
class HinetSeismicityFetchResult {
  const new({
    required this.events,
    required this.skippedLineCount,
  });

  final List<SeismicityEvent> events;
  final int skippedLineCount;
}

/// [HinetSeismicityRepository.fetch] が期間の途中で失敗した場合に送出する例外。
///
/// [HinetJmalistPartialFetchException] をアプリ層のモデル([SeismicityEvent])
/// へ変換した上でラップし、UI 側で部分結果を破棄せず表示できるようにする。
class HinetSeismicityPartialFetchException implements Exception {
  const new({
    required this.partialResult,
    required this.failedFrom,
    required this.failedTo,
    required this.cause,
  });

  /// 失敗するまでに取得できていた結果。
  final HinetSeismicityFetchResult partialResult;

  /// 失敗したチャンクの開始日(UTC、この日を含む)。
  final DateTime failedFrom;

  /// 失敗したチャンクの終了日(UTC、この日を含む)。
  final DateTime failedTo;

  /// 失敗の原因となった元の例外。
  final Object cause;

  @override
  String toString() =>
      'Hi-net の取得が $failedFrom〜$failedTo で失敗しました (cause: $cause)';
}

@Riverpod(keepAlive: true)
HinetSeismicityRepository hinetSeismicityRepository(Ref ref) =>
    HinetSeismicityRepository(client: ref.watch(niedApiClientProvider));

class HinetSeismicityRepository {
  const new({required NiedApiClient client})
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

    try {
      final result = await _client.hinet.jmalist.fetchRange(
        from: from,
        to: to,
        onProgress: onProgress,
      );

      return HinetSeismicityFetchResult(
        events: result.events.map((e) => e.toSeismicityEvent).toList(),
        skippedLineCount: result.skippedLineCount,
      );
    } on HinetJmalistPartialFetchException catch (e) {
      throw HinetSeismicityPartialFetchException(
        partialResult: HinetSeismicityFetchResult(
          events: e.partialResult.events
              .map((event) => event.toSeismicityEvent)
              .toList(),
          skippedLineCount: e.partialResult.skippedLineCount,
        ),
        failedFrom: e.failedFrom,
        failedTo: e.failedTo,
        cause: e.cause,
      );
    }
  }
}
