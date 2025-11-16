import 'package:dio/dio.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// NIED (National Research Institute for Earth Science and Disaster Resilience)
/// APIクライアント
///
/// 防災科学技術研究所が提供する各種APIにアクセスするためのクライアント
class NiedApiClient {
  /// NIED APIクライアントを作成
  ///
  /// [dio] HTTPクライアント
  NiedApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;
  HinetApiClient get hinet => HinetApiClient(_dio);

  FnetApiClient get fnet => FnetApiClient(
    api: FnetCatalogApi(_dio),
    parser: const FnetCatalogParser(),
  );
}
