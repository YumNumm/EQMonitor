import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:knet_api_client/src/knet_directory_parser.dart';

/// 防災科学技術研究所 K-NET/KiK-net 強震観測網 HTTPS ダウンロード クライアント
///
/// Basic 認証を使用して NIED のデータサーバーからデータを取得する。
/// 認証情報（ユーザーID/パスワード）はユーザーが入力し、
/// SecureStorage に保管する（アプリ側の責務）。
class KnetDownloadClient {
  /// クライアントを作成する
  ///
  /// [userId] BOSAI ユーザーID
  /// [password] BOSAI パスワード
  /// [baseUrl] ベース URL（デフォルト: 防災科研の公式サーバー）
  KnetDownloadClient({
    required String userId,
    required String password,
    String? baseUrl,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    final encoded = base64Encode(utf8.encode('$userId:$password'));
    _dio.options.baseUrl =
        baseUrl ?? 'https://www.kyoshin.bosai.go.jp/kyoshin/download';
    _dio.options.headers['Authorization'] = 'Basic $encoded';
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  final Dio _dio;

  /// Basic 認証ヘッダー値（`"Basic <base64>"`）
  ///
  /// VideoPlayer などで直接 HTTP ヘッダーを指定する際に利用する。
  /// _dio.options.headers から導出するため、hot reload 後も安全に使用できる。
  String get authorizationHeader =>
      _dio.options.headers['Authorization'] as String;

  /// 指定したURLからバイナリデータを取得する
  ///
  /// [onReceiveProgress] が指定された場合、受信バイト数と総バイト数を通知する。
  /// Throws [DioException] on network error or authentication failure
  Future<List<int>> fetchBytes(
    Uri url, {
    void Function(int received, int total)? onReceiveProgress,
    Duration? receiveTimeout,
  }) async {
    final response = await _dio.getUri<List<int>>(
      url,
      onReceiveProgress: onReceiveProgress,
      options: receiveTimeout != null
          ? Options(receiveTimeout: receiveTimeout)
          : null,
    );
    if (response.data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Empty response body',
      );
    }
    return response.data!;
  }

  /// 指定したURLからテキストデータを取得する
  Future<String> fetchText(Uri url, {Encoding encoding = utf8}) async {
    final bytes = await fetchBytes(url);
    return encoding.decode(bytes);
  }

  /// all/zip/ 配下の利用可能な年一覧を返す
  Future<List<int>> fetchYears() async {
    final html = await fetchText(
      Uri.parse('${_dio.options.baseUrl}/all/zip/'),
    );
    return KnetDirectoryParser.parseYears(html);
  }

  /// all/zip/{year}/ 配下の利用可能な月一覧を返す
  Future<List<int>> fetchMonths(int year) async {
    final html = await fetchText(
      Uri.parse('${_dio.options.baseUrl}/all/zip/$year/'),
    );
    return KnetDirectoryParser.parseMonths(html);
  }

  /// all/zip/{year}/{month}/ 配下の地震記録時刻一覧を返す（降順）
  Future<List<DateTime>> fetchRecords(int year, int month) async {
    final mm = month.toString().padLeft(2, '0');
    final html = await fetchText(
      Uri.parse('${_dio.options.baseUrl}/all/zip/$year/$mm/'),
    );
    final records = KnetDirectoryParser.parseRecords(html);
    return records.reversed.toList();
  }

  /// all/zip/{year}/{month}/{ts}/ 配下の CSV ZIP を取得して CSV テキストの Map を返す
  ///
  /// キー: ファイル名（例: `AIC0011103111446.csv`）
  /// 値: CSV テキスト
  ///
  /// ZIP ファイル内のタイムスタンプがディレクトリ名と異なる場合があるため、
  /// ディレクトリ一覧を取得してから実際のファイル名を決定する。
  Future<Map<String, String>> downloadAndExtractCsv(
    DateTime eventTime, {
    Encoding encoding = utf8,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    final datePath =
        '${eventTime.year}/${eventTime.month.toString().padLeft(2, '0')}';
    final ts = _formatFileName(eventTime);

    // ディレクトリ一覧から実際の CSV ZIP ファイル名を取得
    // （ファイル内タイムスタンプがディレクトリ名と異なる場合があるため必須）
    final dirHtml = await fetchText(
      Uri.parse('${_dio.options.baseUrl}/all/zip/$datePath/$ts/'),
    );
    final files = KnetDirectoryParser.parseFiles(dirHtml);
    final zipEntry = files.firstWhere(
      (e) => e.endsWith('_csv.zip'),
      orElse: () => throw StateError(
        'CSV ZIP not found in directory listing for event $ts',
      ),
    );

    // ZIP を取得
    final zipUrl = Uri.parse(
      '${_dio.options.baseUrl}/all/zip/$datePath/$ts/$zipEntry',
    );
    final zipBytes = await fetchBytes(
      zipUrl,
      onReceiveProgress: onReceiveProgress,
      receiveTimeout: const Duration(minutes: 10),
    );

    // ZIP を展開して CSV テキストへ変換
    final archive = ZipDecoder().decodeBytes(zipBytes);
    final result = <String, String>{};
    for (final file in archive.files) {
      if (!file.isFile || !file.name.toLowerCase().endsWith('.csv')) {
        continue;
      }
      final content = encoding.decode(file.content as List<int>);
      result[file.name] = content;
    }
    return result;
  }

  static String _formatFileName(DateTime dt) =>
      '${dt.year}'
      '${dt.month.toString().padLeft(2, '0')}'
      '${dt.day.toString().padLeft(2, '0')}'
      '${dt.hour.toString().padLeft(2, '0')}'
      '${dt.minute.toString().padLeft(2, '0')}'
      '${dt.second.toString().padLeft(2, '0')}';

  /// 認証が正常に通過できるか確認する
  ///
  /// 観測点リストの取得を試みて認証を検証する。
  /// Returns true if authentication succeeds.
  Future<bool> verifyAuthentication() async {
    try {
      final response = await _dio.get<dynamic>(
        'knet/',
        options: Options(responseType: ResponseType.stream),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return false;
      }
      rethrow;
    }
  }
}
