import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/jmalist/model/hinet_jmalist_event.dart';
import 'package:nied_api_client/src/hinet/jmalist/parser/hinet_jmalist_parser.dart';

/// [HinetJmalistApiClient.fetchRange] の進捗。
class HinetJmalistFetchProgress {
  const HinetJmalistFetchProgress({
    required this.completedRequests,
    required this.totalRequests,
  });

  final int completedRequests;
  final int totalRequests;
}

/// Hi-net 気象庁一元化処理 震源リスト(`jmalist.php`)の認証付きクライアント。
///
/// フォーム認証(`auth_un`/`auth_pw` POST → `_ssl_auth` Cookie)を行った上で
/// `jmalist.php` へ `list_year`/`list_month`/`list_day`/`list_span` を POST する。
/// 1リクエストは最大7日分のため、指定期間はこのクライアント内で分割し、
/// [requestInterval] を挟みながら直列に実行してサーバ負荷を抑える。
///
/// NIED により震源情報の二次配布が禁止されているため、このクライアントは
/// 一般公開機能から到達不可能なデバッグ画面専用として扱うこと。
class HinetJmalistApiClient {
  HinetJmalistApiClient(
    this._dio, {
    this.requestInterval = const Duration(seconds: 2),
    this.parser = const HinetJmalistParser(),
  });

  final Dio _dio;

  /// 期間分割リクエスト間のウェイト(サーバ負荷配慮)
  final Duration requestInterval;
  final HinetJmalistParser parser;

  static const _baseUrl = 'https://hinetwww11.bosai.go.jp';

  /// フォーム認証を行い、成功した場合 true を返す。
  ///
  /// [_dio] に紐づく Cookie 保存(`CookieManager`/`PersistCookieJar`)は
  /// 呼び出し側([HinetApiClient]生成時)で設定済みであることを前提とする。
  Future<bool> login({
    required String userId,
    required String password,
  }) async {
    final response = await _dio.post<dynamic>(
      '$_baseUrl/auth/?LANG=ja',
      data: FormData.fromMap({'auth_un': userId, 'auth_pw': password}),
      options: Options(
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    final statusCode = response.statusCode ?? 0;
    // ログイン成功時はリダイレクト(302)、失敗時は 401/200(再表示)を想定。
    return statusCode >= 300 && statusCode < 400;
  }

  /// [from] から [to] までの震源リストを取得する(両端含む、UTC日付単位)。
  ///
  /// 1リクエスト最大7日分の制約に従い、内部で期間を分割して直列実行する。
  Future<HinetJmalistParseResult> fetchRange({
    required DateTime from,
    required DateTime to,
    void Function(HinetJmalistFetchProgress)? onProgress,
  }) async {
    final chunks = _splitIntoWeeklyChunks(from: from, to: to);
    final allEvents = <HinetJmalistEvent>[];
    var skippedLineCount = 0;

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final text = await _fetchChunk(chunk.start, chunk.days);
      final result = parser.parse(text);
      allEvents.addAll(result.events);
      skippedLineCount += result.skippedLineCount;

      onProgress?.call(
        HinetJmalistFetchProgress(
          completedRequests: i + 1,
          totalRequests: chunks.length,
        ),
      );

      if (i != chunks.length - 1 && requestInterval > Duration.zero) {
        await Future<void>.delayed(requestInterval);
      }
    }

    return HinetJmalistParseResult(
      events: allEvents,
      skippedLineCount: skippedLineCount,
    );
  }

  Future<String> _fetchChunk(DateTime start, int days) async {
    final response = await _dio.post<String>(
      '$_baseUrl/auth/JMA/jmalist.php',
      data: FormData.fromMap({
        'list_year': start.year.toString(),
        'list_month': start.month.toString(),
        'list_day': start.day.toString(),
        'list_span': days.toString(),
      }),
      options: Options(responseType: ResponseType.plain),
    );
    return _extractPreText(response.data ?? '');
  }

  /// HTMLレスポンスの `<pre>...</pre>` 部分のみを抽出する。
  String _extractPreText(String html) {
    final match = RegExp(
      r'<pre[^>]*>(.*?)</pre>',
      dotAll: true,
    ).firstMatch(html);
    return match?.group(1) ?? html;
  }

  List<({DateTime start, int days})> _splitIntoWeeklyChunks({
    required DateTime from,
    required DateTime to,
  }) {
    const maxDaysPerRequest = 7;
    final chunks = <({DateTime start, int days})>[];
    var cursor = DateTime.utc(from.year, from.month, from.day);
    final end = DateTime.utc(to.year, to.month, to.day);

    while (!cursor.isAfter(end)) {
      final remainingDays = end.difference(cursor).inDays + 1;
      final days = remainingDays > maxDaysPerRequest
          ? maxDaysPerRequest
          : remainingDays;
      chunks.add((start: cursor, days: days));
      cursor = cursor.add(Duration(days: days));
    }
    return chunks;
  }
}
