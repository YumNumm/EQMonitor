import 'dart:convert';

import 'package:dio/dio.dart';

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
    final credentials = base64Encode(utf8.encode('$userId:$password'));
    _dio.options.baseUrl =
        baseUrl ?? 'https://kensho-web.kyoshin.bosai.go.jp/kyoshin/download';
    _dio.options.headers['Authorization'] = 'Basic $credentials';
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  final Dio _dio;

  /// 指定したURLからバイナリデータを取得する
  ///
  /// Throws [DioException] on network error or authentication failure
  Future<List<int>> fetchBytes(Uri url) async {
    final response = await _dio.getUri<List<int>>(url);
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
