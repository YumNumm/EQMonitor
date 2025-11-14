import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/aqua/aqua_api_client.dart';
import 'package:nied_api_client/src/hinet/fnet/fnet_api_client.dart';

/// Hi-net APIクライアント
///
/// 防災科研のHi-netシステムのAPIにアクセスします
class HinetApiClient {
  /// Hi-net APIクライアントを作成
  HinetApiClient(this._dio);

  final Dio _dio;

  AquaApiClient? _aqua;
  FnetApiClient? _fnet;

  /// AQUA APIクライアント
  ///
  /// AQUAシステム（Accurate and QUick Analysis System for Source Parameters）のAPIにアクセスします
  AquaApiClient get aqua {
    _aqua ??= AquaApiClient(_dio);
    return _aqua!;
  }

  /// F-net APIクライアント
  ///
  /// F-netの広帯域地震観測網のカタログデータにアクセスします
  FnetApiClient get fnet {
    _fnet ??= FnetApiClient(_dio);
    return _fnet!;
  }
}
