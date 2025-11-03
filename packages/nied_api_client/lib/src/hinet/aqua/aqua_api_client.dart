import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/aqua/api/aqua_catalog_api.dart';
import 'package:nied_api_client/src/hinet/aqua/util/focal_mechanism_url_generator.dart';

/// AQUA APIクライアント
///
/// AQUAシステム（Accurate and QUick Analysis System for Source Parameters）のAPIにアクセスします
class AquaApiClient {
  /// AQUA APIクライアントを作成
  AquaApiClient(this._dio);

  final Dio _dio;

  /// カタログAPI
  ///
  /// AQUAカタログページからデータを取得します
  AquaCatalogApi get catalog => AquaCatalogApi(_dio);

  /// 発震機構解画像URL生成
  ///
  /// 発震機構解のビーチボール図の画像URLを生成します
  FocalMechanismUrlGenerator get focalMechanism => FocalMechanismUrlGenerator();
}
