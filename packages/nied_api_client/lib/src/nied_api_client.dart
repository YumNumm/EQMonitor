import 'package:dio/dio.dart';
<<<<<<< HEAD
import 'package:nied_api_client/nied_api_client.dart';
=======
import 'package:nied_api_client/src/fnet/fnet_api_client.dart';
import 'package:nied_api_client/src/hinet/hinet_api_client.dart';
>>>>>>> 0a08d0f1490fdc902d175d415269dbaa3b5d21da

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

<<<<<<< HEAD
  FnetApiClient get fnet => FnetApiClient(
    api: FnetCatalogApi(_dio),
    parser: const FnetCatalogParser(),
  );
=======
  HinetApiClient? _hinet;
  FnetApiClient? _fnet;

  /// Hi-net APIクライアント
  ///
  /// Hi-netシステムのAPIにアクセスします
  HinetApiClient get hinet {
    _hinet ??= HinetApiClient(_dio);
    return _hinet!;
  }

  /// F-net APIクライアント
  ///
  /// F-netの地震カタログデータにアクセスします
  FnetApiClient get fnet {
    _fnet ??= FnetApiClient(dio: _dio);
    return _fnet!;
  }
>>>>>>> 0a08d0f1490fdc902d175d415269dbaa3b5d21da
}
