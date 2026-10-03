import 'package:eqmonitor/core/data/network/native_dio_factory.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_credentials_provider.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_download_client_provider.g.dart';

/// 認証情報を基に [KnetDownloadClient] を生成するプロバイダ
///
/// 認証情報が未設定の場合は null を返す。
@Riverpod(keepAlive: true)
Future<KnetDownloadClient?> knetDownloadClient(Ref ref) async {
  final credentials = await ref.watch(knetCredentialsProvider.future);
  if (credentials == null) {
    return null;
  }
  final dio = const NativeDioFactory().build();
  ref.onDispose(() => dio.close(force: true));
  return KnetDownloadClient(
    dio: dio,
    userId: credentials.userId,
    password: credentials.password,
  );
}
