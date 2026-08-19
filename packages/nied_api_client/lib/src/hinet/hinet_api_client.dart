import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/aqua/aqua_api_client.dart';
import 'package:nied_api_client/src/hinet/jmalist/api/hinet_jmalist_api_client.dart';

/// Hi-net APIクライアント
///
/// 防災科研のHi-netシステムのAPIにアクセスします
class HinetApiClient {
  /// Hi-net APIクライアントを作成
  new(this._dio);

  final Dio _dio;

  AquaApiClient get aqua => AquaApiClient(_dio);

  /// 気象庁一元化処理 震源リスト(jmalist.php)クライアント
  ///
  /// NIED により震源情報の二次配布が禁止されているため、
  /// アプリ側では一般公開機能から到達不可能なデバッグ画面専用で使うこと。
  HinetJmalistApiClient get jmalist => HinetJmalistApiClient(_dio);
}
